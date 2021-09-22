// pages/order/wechatpayment.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    paymentAmount: 0,
    barcodeImageUrl:'',
  },
  previewImage:function()
  {
    wx.previewImage({
      current: this.data.barcodeImageUrl,
      urls: [this.data.barcodeImageUrl],
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(options.barcodeImageUrl);
    this.setData({ paymentAmount: options.paymentAmount, barcodeImageUrl: options.barcodeImageUrl});
  },
  onPaid:function(){
    wx.redirectTo({ url: "/pages/user/order?currentTab=2" });
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

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})