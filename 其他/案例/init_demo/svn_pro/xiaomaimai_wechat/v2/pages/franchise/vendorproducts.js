// pages/franchise/categorylist.js
const app = getApp()
import webapi from "../../utils/webapi"

Page({
  data: {
    dataset: [],
    productList: [],
    category: null,
    vendors: [],
    keywords: "",
    VendorCode: "",
    product: {},
    searchModel: {
      PageIndex: 0,
      PageSize: 10
    },
    showPublishModal: false,
    showVendorModal: false,
    publishSuccess: false,
    scrollHeight: app.getClientAreaHeight() - 40,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onLoad(o) {
    this.GetLoadAllVendors().then(() => {
      this.GetVendorCategoryList();
    })
  },
  onSearch(e) {
    const keyword = new RegExp(e.detail, 'gi');
    const { productList } = this.data;
    const dataset = productList.map(item => {
      return {
        ...item,
        products: item.products.filter(i => i.ProductName.search(keyword) > -1 || i.ProductDescription.search(keyword) > -1)
      }
    })
    this.setData({ dataset })
  },
  onSearchChange(e) {
    this.setData({
      keywords: e.detail
    })
  },
  onCollapseChange(e) {
    const { category } = this.data;
    category.forEach((item, index) => {
      item.isOpen = e.detail.includes(index);
      if (item.isOpen && !item.products) {
        this.GetVendorProductList({
          VendorCategoryGuid: item.Guid,
          PageIndex: 0,
          PageSize: 10
        }).then(data => {
          item.products = data.products;
          item.PageIndex = data.PageIndex;
          item.PageSize = data.PageSize;
          item.TotalCount = data.TotalCount;
          this.setData({
            category
          })
        });
      }
    })
    this.setData({
      category,
      activeNames: e.detail
    })
  },
  loadProductMore(e) {
    const { item, index } = e.currentTarget.dataset;
    const { category } = this.data;
    category[index].isLoading = true;
    this.GetVendorProductList({
      VendorCategoryGuid: item.Guid,
      PageIndex: item.PageIndex + 1,
      PageSize: item.PageSize
    }).then(data => {
      item.products = item.products.concat(data.products);
      item.PageIndex = data.PageIndex;
      item.PageSize = data.PageSize;
      item.TotalCount = data.TotalCount;
      item.isLoading = false;
      category[index] = item;
      this.setData({
        category
      })
    });
    this.setData({ category })
  },
  bindNewVendor(e) {
    const { dialog } = e.detail;
    dialog.stopLoading();
    const { VendorCode } = this.data;
    if (VendorCode.length <= 3) {
      wx.showToast({
        title: '请输入有效的供应商推荐码！',
      });
    } else {
      webapi.BindInternalVendor({ MainGuid: app.globalData.apiLoginInfo.StoreGuid, BindVendorCode: VendorCode }).then((res) => {
        if (res.Success) {
          wx.showToast({
            title: '绑定成功！',
          });
          this.GetLoadAllVendors()
        } else
          wx.showModal({
            title: '提示',
            content: '绑定供应商失败，请确认供应商推荐码是否正确！',
            showCancel: false,
          });
      }).catch((err) => {
        app.hideLoading();
        wx.showToast({
          title: '网络异常',
        });
      });
      this.setData({ VendorCode: '' })
      dialog.close();
    }
  },
  bindVendorCodeInput: function (event) {
    this.setData({ VendorCode: event.detail.value });
  },
  onVendorProduct(e) {
    var { item } = e.currentTarget.dataset;
    wx.navigateTo({
      url: '/pages/franchise/productlist',
      events: {
        onGetOption(callback) {
          callback({
            vendor: item,
            search: {
              VendorGuid: item.Guid,
              VendorCategoryGuid: ''
            }
          })
        }
      }
    });
  },
  GetLoadAllVendors() {
    return webapi.LoadAllVendors().then(res => {
      if (res.Success) {
        this.setData({ vendors: res.Data })
        return res.Data
      }
    })
  },
  GetVendorCategoryList() {
    return webapi.GetVendorCategoryList().then(res => {
      if (res.Success) {
        const category = res.Data.map(item => {
          return {
            ...item,
            isOpen: false
          }
        })
        this.setData({
          category
        })
      }
    })
  },
  GetVendorProductList(postModel) {
    const { vendors } = this.data;
    return webapi.SearchVendorProduct(postModel).then(res => {
      if (res.Success) {
        const { ListObjects, TotalCount, PageIndex, PageSize } = res.Data;
        const products = ListObjects.map(item => {
          const vendor = vendors.find(v => v.Guid === item.VendorGuid) || { VendorName: '未知供应商' }
          return {
            ...item,
            vendor
          }
        })
        return {
          products,
          PageIndex,
          PageSize,
          TotalCount,
        };
      } else {
        wx.showToast({
          title: "网络异常",
          icon: 'none',
        });
      }
    })
  },
  onClosePublishModal(e) {
    this.setData({
      showPublishModal: false,
      publishSuccess: false,
    })
  },
  onShowPublishModal(e) {
    const { item } = e.currentTarget.dataset
    this.setData({
      showPublishModal: true,
      publishSuccess: false,
      product: item
    })
  },
  onShowBindVendor(e) {
    this.setData({
      showVendorModal: true,
    })
  },
  onCloseBindVendor(e = {}) {
    if (e.detail !== "confirm") {
      this.setData({
        showVendorModal: false,
      })
    }
  },
  onPublish(e) {
    const { product } = this.data;
    const formData = e.detail.value;

    webapi.GetVendorProduct4Publish(product.Guid).then(res => {
      const p = res.Data;
      const postData = {
        status: 1,
        productList: [{
          MyGuid: product.MyGuid,
          MyDescription: formData.productName,
          VendorProductGuid: product.Guid,
          VendorGuid: product.VendorGuid,
          myprice: formData.price || 0,
          RangePriceRequired: formData.priceType === '2',
          myminprice: formData.minPrice || 0,
          mymaxprice: formData.maxPrice || 0,
          status: 1,
          displayOnHomePage: 1,
          displayOrder: 0,
          confirmPriceRequired: false,
          pictureList: p.PictureList,
          tagList: p.TagList,
          productName: p.ProductName,
          description: p.ProductDescription,
        }]
      }
      webapi.PublishVendorProduct(postData).then((res) => {
        if (res.Success) {
          this.setData({ publishSuccess: true })
          app.getHomePage().onLoadProductGroupList(true);
        } else {
          wx.showToast({
            title: "网络异常",
            icon: 'none',
          });
        }
      }).catch((res) => {
        console.log("网络异常", res);
      });
    })
  },
})
