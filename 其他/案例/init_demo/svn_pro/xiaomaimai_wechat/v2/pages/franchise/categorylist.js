// pages/franchise/categorylist.js
const app = getApp()
import webapi from "../../utils/webapi"

Page({

  /**
   * 页面的初始数据
   */
  data: {
    myCategorys: [],
    showModal: false,
    VendorCode: '',
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onShowBindVendor: function () {
    this.setData({ showModal: true });
  },
  bindNewVendor: function () {
    if (this.data.VendorCode.length <= 3) {
      wx.showToast({
        title: '请输入有效的供应商推荐码！',
      });
      return;
    } else {
      var self = this;
      webapi.BindInternalVendor({ MainGuid: app.globalData.apiLoginInfo.StoreGuid, BindVendorCode: this.data.VendorCode }).then((res) => {
        if (res.Success) {
          wx.showToast({
            title: '绑定成功！',
          });
          self.GetVendorCategoryList();
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
      this.setData({ showModal: false });
    }
  },
  bindVendorCodeInput: function (event) {
    this.setData({ VendorCode: event.detail.value });
  },
  onChooseCategory: function (e) {
    var categoryguid = e.currentTarget.dataset.categoryguid;
    wx.navigateTo({
      url: '/pages/franchise/vendor?vendorcategory=' + categoryguid,
    });
  },
  btnBackToHome: function () {
    this.setData({ shareGuid: '' });
    wx.redirectTo({
      url: '/pages/home/index',
    });
  },
  GetVendorCategoryList: function () {
    var self = this;
    webapi.GetVendorCategoryList().then((res) => {
      console.log(res);
      if (res.Success) {
        self.setData({ myCategorys: res.Data });
      } else {
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
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.GetVendorCategoryList();
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },
})
