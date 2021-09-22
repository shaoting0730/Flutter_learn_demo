// pages/franchise/vendor.js
const app = getApp()
import webapi from "../../utils/webapi"


Page({

  /**
   * 页面的初始数据
   */
  data: {
    myVendors: [],
    vendorCategoryGuid: '',
  },
  btnBackToHome: function () {
    this.setData({ shareGuid: '' });
    wx.redirectTo({
      url: '/pages/home/index',
    });
  },
  onVendorProduct(e) {
    const { item } = e.currentTarget.dataset
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
  GetVendorList: function () {
    var self = this;
    webapi.LoadAllVendors().then((res) => {
      console.log(res);
      if (res.Success) {
        self.setData({ myVendors: res.Data });
        /*if (self.myVendors.length == 1) {
          wx.navigateTo({
            url: '/pages/franchise/categorylist?vendor='+self.myVendors[0].Guid,
          });
        }*/
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
    this.data.vendorCategoryGuid = options.vendorcategory;
    this.GetVendorList();
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
