import webapi from "../../../utils/webapi"
import cloudApi from "../../../utils/cloudapi"
import Util from "../../../utils/util.js";
const app = getApp()

Page({
  data: {
    product: {},
    progress: {
      percent: 0,
      show: false
    },
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },

  onLoad(options) {

    webapi.searchDQProduct({
      ProductGuid: [options.productId]
    }).then(res => {
      console.log("moment res:", res);
      if (res && res.Success) {
        if (res.Data.ListObjects[0].Price == 0 && res.Data.ListObjects[0].MinPrice == 0 && res.Data.ListObjects[0].MaxPrice == 0)
          res.Data.ListObjects[0].PriceType = 1;
        else if (res.Data.ListObjects[0].MinPrice > 0 && res.Data.ListObjects[0].MaxPrice > 0)
          res.Data.ListObjects[0].PriceType = 2;
        else if (res.Data.ListObjects[0].Price > 0)
          res.Data.ListObjects[0].PriceType = 1;
        else
          res.Data.ListObjects[0].PriceType = 1;
        this.setData({
          product: res.Data.ListObjects[0],
        });
      }
    });
  },
  onUpdataProduct({ detail }) {
    this.setData({
      product: detail
    })
  },
  onSaveProduct(e) {
    const { product } = this.data;
    const homePage = app.getHomePage()
    if (this.validate()) {
      webapi.updateDQProduct(product).then((res) => {
        if (res.Success) {
          homePage.updateProduct(product)
          wx.navigateBack({})
        } else {
          console.log(res, "数据状态");
          wx.showToast({
            title: "网络异常",
            icon: 'none',
            duration: 2000,
          });
        }
      }).catch((res) => {
        console.log("网络异常", res);
        app.hideLoading();
      });
    }
  },
  validate() {
    const { product } = this.data;
    let success = true
    let message = '';
    const { Description, Price, VideoUrl, PictureList } = product;
    if (Description.length === 0 || Price.length === 0) {
      message = `商品${index + 1}请填写"商品名称和价格`;
      success= false;
      return false;
    }
    if ((VideoUrl || '').length === 0 && PictureList.length === 0) {
      message = `商品${i + 1}请上传商品图片`;
      success= false;
      return false;
    }
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
