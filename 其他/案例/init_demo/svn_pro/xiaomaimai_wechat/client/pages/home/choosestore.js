const app = getApp()
import config from "../../utils/config"
import webapi from "../../utils/webapi"

// pages/home/choosestore.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    myAccessStores:[],
    myVisitStores: [],
    myOwnStores:[],
    ShareGuid:'',
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    needAuthor: true,
    showapplynewstore:false,
  },
  allocateStores: function(myAccessStores){
    let myVisitStores = [];
    let myOwnStores = [];
    for (var index = 0; index < myAccessStores.length; index++)
    {
      if (myAccessStores[index].IsOwner==true)
      {
        myOwnStores.push(myAccessStores[index]);
      }
      else
      {
        myVisitStores.push(myAccessStores[index]);
      }
    }
    this.setData({
      myAccessStores: myAccessStores,
      myVisitStores: myVisitStores,
      myOwnStores: myOwnStores });
  },
  onApplyNew:function(){
    wx.navigateTo({
      url: '/pages/storeapplication/index',
    });
  },
  onChooseStore:function(e){
    var storeGuid = e.currentTarget.dataset.storeguid;
    var storeHost = e.currentTarget.dataset.storehost;
    app.globalData.storeName = storeHost;
    app.globalData.storeGuid = storeGuid;
    app.globalData.userInfo = null;
    app.globalData.apiLoginInfo = null;
    app.globalData.productTagList = null;
    app.globalData.wishList = [];
    app.globalData.shippingCost = 0;
    app.globalData.storeInfo = null;

    wx.reLaunch({
      url: '/pages/home/index',
    });
  },
  bindGetUserInfo: function () {
    this.GetMyStoreList(true);
    this.setData({
      needAuthor: false,
    });
  },
  GetMyStoreList:function(redirect){
    var self = this;
    wx.showLoading({
      title: '获取数据',
      icon: 'loading',
      mask: true,
    });
    app.globalData.storeName = null;
    app.globalData.storeGuid = null;
    app.globalData.userInfo = null;
    app.globalData.apiLoginInfo = null;
    app.globalData.productTagList = null;
    app.globalData.wishList = [];
    app.globalData.shippingCost = 0;
    app.globalData.shoppingCartCount = 0;
    app.globalData.storeInfo = null;
    app.globalData.moments = [];
    app.globalData.productGroupNames = [];
    app.globalData.photoWallList = [];
    wx.login({
      success: resLogin => {
        wx.getUserInfo({
          success: res => {
            webapi.getMyAccessStores(resLogin.code, res.encryptedData, res.iv).then((res) => {
              wx.hideLoading();
              if (res.Success) {
                app.globalData.myAccessStores = res.Data;
                if (redirect && (app.globalData.myAccessStores.length == 1)) {
                  app.globalData.storeName = app.globalData.myAccessStores[0].StoreHost;
                  app.globalData.storeGuid = app.globalData.myAccessStores[0].StoreGuid;
                  wx.reLaunch({
                    url: '/pages/home/index',
                  });
                }
                else
                  self.allocateStores(app.globalData.myAccessStores);
                if(self.data.myOwnStores.length==0)
                  self.setData({ showapplynewstore: true});
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
          fail: (error) => {
            console.log("wx.getUserInfo 失败", error);
            wx.hideLoading();
          }
        });
      },
      fail: (error) => {
        console.log("wx.login 失败", error);
        wx.hideLoading();
      }
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
      //调用应用实例的方法获取全局数据
      if (options.ShareGuid)
        this.data.ShareGuid = options.ShareGuid;
      wx.getSetting({
        success: (res) => {
          if (res.authSetting['scope.userInfo']) {
            if (app.globalData.storeName != null && app.globalData.storeGuid != null && app.globalData.myAccessStores != null)
              this.GetMyStoreList(false);
            else
              this.GetMyStoreList(true);
            this.setData({
              needAuthor: false,
            });
          } else {
            this.setData({
              needAuthor: true,
            });
          }
        }
      });
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