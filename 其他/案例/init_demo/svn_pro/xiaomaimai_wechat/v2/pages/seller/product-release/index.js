import webapi from "../../../utils/webapi";
import Util from "../../../utils/util.js";

const app = getApp();
Page({
  data: {
    show: false,
    isOneVideo: false,
    products: [],
    actions: [{ type: 'image', name: '上传图片' }, { type: 'video', name: '上传视频' }],
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
    progress: {},
    currentProduct: {}
  },
  onLoad(options) {
    this.onAddProduct();
  },
  onCloseActionSheet() {
    this.setData({ show: false });
  },
  onShowActionSheet({ detail }) {
    const { products } = this.data;
    if (products.find(item => item.ProductList)) {
      this.onChooseImage();
    } else {
      this.setData({ show: true, currentProduct: detail });
    }
  },
  onSelectActionSheet({ detail }) {
    const { type } = detail;
    switch (type) {
      case 'image': this.onChooseImage();
        return;
      case 'video': this.onChooseVideo();
    }
  },
  onChooseImage() {
    Util.chooseImage({
      onProgress: (progress) => {
        this.setData({
          progress
        })
      }
    }).then(result => {
      const { products, currentProduct } = this.data;
      const { progress, imageList } = result
      const product = products.find(item => item.uuid === currentProduct.uuid);
      product.PictureList = imageList;
      this.setData({
        progress,
        products
      })
    }).catch(() => {
      wx.showToast({
        title: "网络异常",
        icon: 'none',
        duration: 2000,
      });
      this.setData({
        progress: { show: false, percent: 0 }
      })
    })
  },
  onChooseVideo() {
    Util.chooseVideo((progress) => {
      this.setData({
        progress
      })
    }).then(result => {
      const { currentProduct } = this.data;
      const { progress, url } = result;
      currentProduct.VideoUrl = url
      this.setData({
        isOneVideo: true,
        progress,
        products: [currentProduct]
      })
    }).catch(() => {
      wx.showToast({
        title: "网络异常",
        icon: 'none',
        duration: 2000,
      });
      this.setData({
        progress: { show: false, percent: 0 }
      })
    })
  },
  onUpdataProduct({ detail }) {
    const { products } = this.data;
    const index = products.findIndex(item => item.uuid === detail.uuid);
    products[index] = detail;
    this.setData({
      products
    })

  },
  onAddProduct() {
    const { products } = this.data;
    products.push({
      uuid: Util.uuid(),
      FileName: '',
      ProductName: '',
      Description: '',
      PriceType: 1,
      Price: '',
      MinPrice: '',
      MaxPrice: '',
      Status: 1,
      DisplayOnHomePage: 1,
      DisplayOrder: 0,
      VideoUrl: '',
      PictureList: [],
      TagList: [],
      ConfirmPriceRequired: false,
      RangePriceRequired: false,
    })
    this.setData({ products })
  },
  onRelease() {
    const { products } = this.data;
    const eventChannel = this.getOpenerEventChannel();
    if (this.validate()) {
      webapi.addNewProducts({ ProductList: products }).then(res => {
        if (res.Success) {
          wx.navigateBack({});
          eventChannel.emit("onComplete", { products: [] });
        } else {
          console.log(res, "数据状态");
          app.hideLoading();
          setTimeout(() => {
            wx.showToast({
              title: "网络异常",
              icon: "none",
              duration: 2000
            });
          }, 100);
        }
      }).catch(res => {
        console.log("网络异常", res);
        //app.hideLoading();
      });
    }
  },
  onReleasePublish() {
    const { products } = this.data;
    const eventChannel = this.getOpenerEventChannel();
    if (this.validate()) {
      webapi.addNewProducts({ ProductList: products }).then(res => {
        if (res.Success) {
          //wx.navigateBack({});
          eventChannel.emit("onComplete", { products: res.Data.ProductList });
        } else {
          console.log(res, "数据状态");
          app.hideLoading();
          setTimeout(() => {
            wx.showToast({
              title: "网络异常",
              icon: "none",
              duration: 2000
            });
          }, 100);
        }
      }).catch(res => {
        console.log("网络异常", res);
        //app.hideLoading();
      });
    }
  },
  validate() {
    const { products } = this.data;
    let success = true;
    let message = ''
    products.forEach((item, i) => {
      const { Description, Price, PictureList, VideoUrl } = item;
      if (Description.length === 0 || Price.length === 0) {
        message = `商品${i + 1}请填写"商品名称和价格`;
        success = false;
        return false;
      }
      if (VideoUrl.length === 0 && PictureList.length === 0) {
        message = `商品${i + 1}请上传商品图片`;
        success = false;
        return false;
      }
    });
    if (!success) {
      wx.showToast({
        title: message,
        icon: "none",
        duration: 2000
      });
    }
    return success;
  },
})
