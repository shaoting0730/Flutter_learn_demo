// pages/franchise/productlist.js
const app = getApp({allowDefault: true})
import webapi from "../../utils/webapi"

Page({
  data: {
    productList: [],
    vendor: {},
    product: {},
    scrollTop: 0,
    refresherScrollTop: 0,
    showPublishModal: false,
    publishSuccess: false,
    scrollHeight: app.getClientAreaHeight() - 50,
    safeAreaTop: app.getSafeAreaTop(),
    searchModel: {
      pageIndex: 0,
      pageSize: 10,
    }
  },
  onLoad(o) {
    this.refresher = this.selectComponent("#refresher");
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('onGetOption', (options) => {
      const { searchModel } = this.data;
      this.setData({
        vendor: options.vendor,
        searchModel: { ...searchModel, ...options.search }
      })
      this.refresher.triggerRefresh();
    })
  },
  GetVendorProductList: function () {
    const { searchModel, productList } = this.data;
    return webapi.SearchVendorProduct(searchModel).then((res) => {
      if (res.Success) {
        const { ListObjects } = res.Data;
        if (searchModel.pageIndex === 0) {
          this.setData({
            productList: ListObjects
          })
        } else {
          this.setData({
            productList: productList.concat(ListObjects)
          })
        }
        return res.Data
      } else {
        wx.showToast({
          title: "网络异常",
          icon: 'none',
        });
      }
    }).catch((res) => {
      console.log("网络异常", res);
      app.hideLoading();
    });
  },
  refresherScroll(e) {
    this.setData({
      refresherScrollTop: e.detail.scrollTop
    });
  },
  onRefresh() {
    const { searchModel } = this.data;
    searchModel.pageIndex = 0;
    this.GetVendorProductList().then(data => {
      this.refresher.finishPullToRefresh();
    });
  },
  onLoadmore() {
    const { searchModel, productList } = this.data;
    searchModel.pageIndex += 1;
    this.GetVendorProductList().then(data => {
      const isEnd = data.TotalCount === productList.length;
      this.refresher.finishLoadmore(isEnd);
    });
  },
  onSearch(e) {
    const { searchModel } = this.data;
    this.setData({
      scrollTop: 0,
      searchModel: {
        ...searchModel,
        productName: e.detail
      }
    });
    this.refresher.triggerRefresh();
  },
  onNavigateBack() {
    wx.navigateBack({
      delta: 1
    });
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
  onPublish(e) {
    const { product ,vendor } = this.data;
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
