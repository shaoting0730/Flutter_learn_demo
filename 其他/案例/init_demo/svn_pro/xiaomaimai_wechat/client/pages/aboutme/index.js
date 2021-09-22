//index.js
var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';
Page({
    data: {
        canIUse: wx.canIUse('button.open-type.getUserInfo'),
        needAuthor:true,
        userInfo: {},
        vendorCode:'',
        hasResult:false,
        needPhoneNumber:false,
        TotalAmount:0,
        AccountBalance:0,
        UsedAmount:0,
        saveMoney:0,
        ServiceCallNumber:"40028322848",
        ServiceEMail:"shoppingtool@outlook.com",
        shoppingCartCount:0,
        unPaidOrderCount:0,
        wishListCount:0,
        shippingCost:0,
        seller:false,
    },
    onShow: function () {
      var self = this;
      webapi.loadOrderCountSummary().then((res1) => {
        console.log(res1);
        if (res1.Success) {
          self.setData({
            unPaidOrderCount: res1.Data['Unpaid'],
          });
        }
      });     
      this.setData({ seller: app.globalData.seller, shoppingCartCount: app.globalData.shoppingCartCount, shippingCost: app.globalData.shippingCost, AccountBalance: app.globalData.apiLoginInfo.AccountBalance});
      if(this.data.seller)
      {
        this.setData({ vendorCode: app.globalData.apiLoginInfo.CustomerUniqueCode});
      }
    },
    getPhoneNumber: function (e) {
        if (e.detail.errMsg == 'getPhoneNumber:fail user deny') {
            wx.showModal({
                title: '提示',
                showCancel: false,
                content: '未授权',
                success: function (res) {
                }
            });
        } else {
            wx.showModal({
                title: '提示',
                showCancel: false,
                content: e.detail.errMsg,
                success: function (res) {
                }
            });
        }
    },
  
    bindFranchise() {
      wx.navigateTo({
        url: '/pages/franchise/categorylist'
      });
    },
    bindAdvertisement() {
      wx.navigateTo({
        url: '/pages/advertisement/index'
      });
    },
    bindChooseStore(){
      wx.reLaunch({
        url: '/pages/home/choosestore',
      });
    },
    bindShare(){
      wx.navigateTo({
        url: '/pages/share-to-friend/index',
      });
    },
    bindChangePhone(){
        console.log("ChangePhone");
    },
    bindMyShoppingCart(){
      wx.navigateTo({ url: "/pages/cart/cart" });
    },
    bindShippingCost(){
      wx.navigateTo({ url: "/pages/user/shippingcost" });
    },
    bindMyOrder(){
        wx.navigateTo({url:"/pages/user/order?currentTab=0"});
    },
    bindMyWhishList() {
      wx.navigateTo({ url: "/pages/user/favorite" });
    },
    bindMyAddress() {
      wx.navigateTo({ url: "/pages/address/user-address/user-address" });
    },
    bindShareUs(){
        wx.navigateTo({url:"/pages/share-to-friend/index"});
    },
    bindServiceEmail(){
        const { ServiceEMail } = this.data;
        Util.setClipboard(ServiceEMail,"邮箱已复制");
    },
    initPage: function()
    {
      this.setData({ wishListCount: app.globalData.wishList.length });
      this.setData({
        shoppingCartCount: app.globalData.shoppingCartCount,
      });
      webapi.loadOrderCountSummary().then((res1) => {
        console.log(res1);
        if (res1.Success) {
          this.setData({
            unPaidOrderCount: res1.Data['Unpaid'],
          });
        }
      });
    },
    onLoad: function (options) {
        //调用应用实例的方法获取全局数据
        var self = this;
        self.setData({
          needAuthor: app.globalData.userInfo == null,
        });
        if(app.globalData.userInfo==null)
        {
          wx.getSetting({
            success: (res) => {
              if (res.authSetting['scope.userInfo']) {
                self.setData({
                  needAuthor: false,
                });
                // 已经授权，可以直接调用 getUserInfo 获取头像昵称
                app.getUserInfo((userInfo) => {
                  console.log(userInfo, "---->userInfo");
                  self.setData({
                    userInfo: userInfo,
                  });
                });
                self.initPage();

              } else {
                self.setData({
                  needAuthor: true,
                });
              }
            }
          });
        }
        else
        {
          self.setData({
            userInfo: app.globalData.userInfo,
          });
          self.initPage();
        }
    },
    bindGetUserInfo:function(){
        wx.showLoading({
            title: '正在登录',
            icon: 'loading',
            mask: true,
        });
        app.getUserInfo((userInfo)=>{
            console.log(userInfo, "---->userInfo");
            //更新数据
            this.setData({
                userInfo: userInfo,
                needAuthor:false,
            });
        });
    },
    // onShareAppMessage: Util.shareApp,
})
