// pages/franchise/productlist.js
const app = getApp()
import config from "../../utils/config"
import webapi from "../../utils/webapi"

Page({

  /**
   * 页面的初始数据
   */
  data: {
    productList: [],
    vendorcategoryguid: '',
    vendorguid:'',
  },
  btnBackToHome: function () {
    this.setData({ shareGuid: '' });
    wx.redirectTo({
      url: '/pages/home/index',
    });
  },
  GetVendorProductList: function () {
    var self = this;
    wx.showLoading({
      title: '获取数据',
      icon: 'loading',
      mask: true,
    });
    webapi.SearchVendorProduct({ VendorCategoryGuid: self.data.vendorcategoryguid, VendorGuid: self.data.vendorguid }).then((res) => {
      wx.hideLoading();
      console.log(res);
      if (res.Success) {
        var productList = [];
        res.Data.ListObjects.forEach(o => {
          o.ProductList = [];
          o.ProductList.push({ Guid: o.Guid, PictureList: o.PictureList });
          productList.push(o);
        });
        self.setData({ productList: productList });
        console.log(self.data.productList);
      } else {
        wx.showToast({
          title: "网络异常",
          icon: 'none',
          duration: 2000,
        });
      }
    }).catch((res) => {
      console.log("网络异常", res);
      wx.hideLoading();
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.data.vendorcategoryguid = options.vendorcategory;
    this.data.vendorguid = options.vendor;
    this.GetVendorProductList();
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