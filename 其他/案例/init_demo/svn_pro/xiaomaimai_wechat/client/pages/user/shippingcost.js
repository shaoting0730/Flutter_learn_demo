// pages/user/shippingcost.js
var app = getApp();
var webapi = require('../../utils/webapi');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    shippingCost:0,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

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
    this.setData({ shippingCost: app.globalData.shippingCost});
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
  onInputShippingCost:function(e){
    this.setData({ shippingCost: e.detail.value });

  },
  onSave: function(){
    webapi.SetBasicShippingFee(this.data.shippingCost).then((res)=>{
      if(res.Success)
      {
        app.globalData.shippingCost = this.data.shippingCost;
      }
      wx.navigateBack({
      });
      ///({
      ///  url: '/pages/aboutme/index',
      ///});
    });
  },
})