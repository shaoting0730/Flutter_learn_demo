//index.js
var app = getApp();
var webapi = require('../../utils/webapi');
import Util from '../../utils/util';

Component({
  data: {
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    needAuthor: true,
    userInfo: {},
    vendorCode: '',
    hasResult: false,
    needPhoneNumber: false,
    TotalAmount: 0,
    AccountBalance: 0,
    UsedAmount: 0,
    saveMoney: 0,
    ServiceCallNumber: "40028322848",
    ServiceEMail: "shoppingtool@outlook.com",
    unPaidOrderCount: 0,
    wishListCount: 0,
    shippingCost: 0,
    seller: false,
    apiLoginInfo: {},
    summary: {},
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight - 180,
    stores: []
  },
  pageLifetimes: {
    show: function () {
      this.onShow();
    }
  },
  methods: {
    onShow: function () {
      var self = this;
      this.initPage();
      this.setData({
        seller: app.globalData.seller,
        shippingCost: app.globalData.shippingCost,
        AccountBalance: app.globalData.apiLoginInfo && app.globalData.apiLoginInfo.AccountBalance,
        storeInfo: app.globalData.storeInfo,
        wishListCount: app.globalData.wishList.length,
        stores: app.globalData.myAccessStores
      });
      if (this.data.seller) {
        this.setData({
          vendorCode: app.globalData.apiLoginInfo && app.globalData.apiLoginInfo.CustomerUniqueCode
        });
      }
    },
    getPhoneNumber: function (e) {
      if (e.detail.errMsg == 'getPhoneNumber:fail user deny') {
        wx.showModal({
          title: '提示',
          showCancel: false,
          content: '未授权',
          success: function (res) { }
        });
      } else {
        wx.showModal({
          title: '提示',
          showCancel: false,
          content: e.detail.errMsg,
          success: function (res) { }
        });
      }
    },

    bindChooseStore() {
      wx.navigateTo({ url: "/pages/change-store/index" });
    },
    bindChangePhone() {
      console.log("ChangePhone");
    },
    bindServiceEmail() {
      const {
        ServiceEMail
      } = this.data;
      Util.setClipboard(ServiceEMail, "邮箱已复制");
    },
    initPage() {
      if (app.globalData.apiLoginInfo && app.globalData.apiLoginInfo.StoreCustomerGuid) {
        webapi.loadOrderCountSummary()
          .then((res) => {
            console.log(res);
            if (res.Success) {
              this.setData({
                summary: res.Data,
                unPaidOrderCount: res.Data['Unpaid'],
              });
            }
          });
      }
    },
    onLoad: function (options) {
      //调用应用实例的方法获取全局数据
      var self = this;
      self.setData({
        needAuthor: app.globalData.userInfo == null,
        apiLoginInfo: app.globalData.apiLoginInfo,
      });
      app.getUserInfo({
        success: (userInfo) => {
          self.setData({
            userInfo: userInfo,
          });
          self.initPage();
        }
      });
    },

    bindGetUserInfo: function () {
      app.getUserInfo((userInfo) => {
        console.log(userInfo, "---->userInfo");
        //更新数据
        this.setData({
          userInfo: userInfo,
          needAuthor: false,
        });
      });
    },

    copyOwnerWechatId() {
      Util.setClipboard(this.data.storeInfo.OwnerWechatId, "店主微信已复制");
    },
  },
  // onShareAppMessage: Util.shareApp,
})
