import Request from "./utils/request";
import webapi from "./utils/webapi";

var config = require('./utils/config');

//app.js
App({
  version: '1.0.14',
  onLaunch: function (options) {
    console.log(options);
    let query = options.query
    ///wx.cloud.init();
    if (query.hasOwnProperty("REFCODE")) {
      wx.setStorageSync('Refercode', query.REFCODE)
    }
    this.globalData.systemInfo = wx.getSystemInfoSync();
    console.log(this.globalData.systemInfo);
    this.globalData.hasIPhoneX = this.globalData.systemInfo.model.search(/iphone x\w*/ig) > -1;
  },
  px2rpx(px) {
    return px * 750 / this.globalData.systemInfo.screenWidth;
  },
  rpx2px(rpx) {
    return rpx * this.globalData.systemInfo.screenWidth / 750;
  },
  getSafeAreaTop() {
    return this.globalData.systemInfo.statusBarHeight;
  },
  getSafeAreaBottom() {
    return this.globalData.systemInfo.screenHeight - this.globalData.systemInfo.safeArea.bottom;
  },
  getClientAreaHeight() {
    return this.globalData.systemInfo.screenHeight - this.getSafeAreaTop() - this.globalData.titleHeight - this.getSafeAreaBottom();
  },
  getClientHeightPX() {
    return this.globalData.systemInfo.safeArea.height - this.globalData.systemInfo.safeArea.top
  },
  showLoading(options) {
    let title = "加载中...";
    if (options && options.title) title = options.title;

    let duration = 360000;
    if (options && options.duration) duration = options.duration;

    if (this.loadingHideTimer) {
      clearTimeout(this.loadingHideTimer);
      this.loadingHideTimer = null;
    }
    wx.showToast({
      title: title,
      // image: "../../images/loading.gif",
      icon: 'loading',
      duration: duration,
      mask: true
    });
  },

  showToast(options) {
    if (this.loadingHideTimer) {
      clearTimeout(this.loadingHideTimer);
      this.loadingHideTimer = null;
    }
    wx.showToast(options);
  },
  hideLoading() {
    const self = this;
    this.loadingHideTimer = setTimeout(() => {
      wx.hideToast({});
      self.loadingHideTimer = null;
    }, 100);
  },

  // 登录
  getUserInfo: function (options) {
    const self = this;
    if (this.globalData.userInfo) {
      if (options.success) options.success(this.globalData.userInfo);
    } else {
      self.showLoading({
        title: '微信登录...'
      });
      // console.log("登录中....");
      wx.login({
        success: resLogin => {
          // 发送 res.code 到后台换取 openId, sessionKey, unionId
          // console.log("wx.login 成功", resLogin);
          self.showLoading({
            title: '微信授权...'
          });
          wx.getUserInfo({
            success: res => {
              console.log("wx.getUserInfo 成功", res);
              // 可以将 res 发送给后台解码出 unionId
              self.globalData.userInfo = res.userInfo;
              var refCode = wx.getStorageSync('Refercode');
              webapi.userLogin(resLogin.code, res.encryptedData, res.iv, refCode, options.storeGuid).then((res) => {
                // console.log(res, "--->LoginInfo");
                if (res.Success) {
                  self.onLoggedIn(res.Data, options);
                } else {
                  // console.log(res, "数据状态");
                  wx.showToast({
                    title: "网络异常",
                    icon: 'none',
                    duration: 2000,
                  });
                  if (options.fail) options.fail(res);
                  else self.doReload();
                }
              }).catch((res) => {
                console.log("登录异常", res);
                self.hideLoading();
                if (options.fail) options.fail(res);
                else self.doReload();
              });
            },
            fail: (error) => {
              console.log("wx.getUserInfo 失败", error);
              self.hideLoading();
              // self.showToast({
              //   title: "微信授权失败",
              //   icon: 'none',
              //   duration: 2000,
              // });
              if (options.fail) options.fail(error);
              else self.doReload();
            }
          });
        },
        fail: (error) => {
          self.hideLoading();
          console.log("wx.login 失败", error);
          self.showToast({
            title: "微信登录失败",
            icon: 'none',
            duration: 2000,
          });
          if (options.fail) options.fail(error);
          else self.doReload();
        }
      });
    }
  },
  GetMyStoreList: function (options) {
    if (!options) options = {};
    const self = this;
    self.globalData.moments = [];
    self.globalData.productGroupNames = [];
    self.globalData.photoWallList = [];

    self.getUserInfo({
      storeGuid: options.storeGuid,
      success: (res) => {
        webapi.getMyAccessStores('', '', '', options.storeGuid).then((res) => {
          self.hideLoading();
          if (res.Success) {
            self.globalData.myAccessStores = res.Data;
            if (options.success) options.success(self.globalData.myAccessStores);
          } else {
            wx.showToast({
              title: "网络异常",
              icon: 'none',
              duration: 2000,
            });
            if (options.success) options.fail();
            else self.doReload();
          }
        }).catch((res) => {
          console.log("网络异常", res);
          self.hideLoading();
          if (options.fail) options.fail();
          else self.doReload();
        });
      },
      fail: (error) => {
        console.log("wx.getUserInfo 失败", error);
        if (options.fail) options.fail(error);
        else self.doReload();
      }
    });
  },
  currentPage() {
    const pages = getCurrentPages();
    return pages[pages.length - 1];
  },
  getHomePage() {
    const pages = getCurrentPages();
    return pages.find(page => page.route.indexOf('pages/home/index') > -1) || {}
  },
  getPage(name) {
    const pages = getCurrentPages();
    return pages.find(page => page.route.indexOf(`pages/${name}`) > -1) || {}
  },
  onLoggedIn(data, options) {
    const self = this;
    Request.setApiLoginInfo(data);
    webapi.retrieveStoreInfo().then((res2) => {
      if (res2.Success) {
        self.globalData.storeInfo = res2.Data;
        self.globalData.seller = self.globalData.storeInfo == null ? false : self.globalData.storeInfo.OwnerGuid == self.globalData.apiLoginInfo.StoreCustomerGuid;
      }
      if (options.success) options.success(self.globalData.userInfo)
    });
    webapi.loadChinaCityCode().then((res2) => {
      self.globalData.chinaCityCode = res2.Data;
    });
    webapi.GetBasicShippingFee().then((res) => {
      if (res.Success)
        self.globalData.shippingCost = res.Data;
    });
    webapi.GetBuyerInfo().then((res) => {
      if (res.Success) {
        self.globalData.buyerInfo = res.Data
      }
    })
  },
  changeStore(storeGuid) {
    const self = this;
    const stores = this.globalData.myAccessStores;

    for (let i = 0; i < stores.length; ++i) {
      if (stores[i].StoreGuid !== storeGuid) continue;

      self.hideLoading();
      self.currentPage().setData({
        changeStore: false
      });
      self.clearStoreInfo();
      webapi.loadUserBind(storeGuid).then((res) => {
        self.hideLoading();

        if (res.Success) {
          self.onLoggedIn(res.Data, {
            success: () => {
              if (self.currentPage().data.isHome) {
                self.currentPage().reload();
              } else {
                wx.reLaunch({
                  url: `/pages/home/index?storeGuid=${storeGuid}`
                })
              }
            }
          });
        } else { }
      });
      return;
    }
  },
  changeStoreEx(storeGuid) {
    if (this.globalData.storeInfo.StoreGuid === storeGuid) {
      this.changeStore(storeGuid)
    } else {
      wx.showModal({
        title: '提示',
        content: '您是否确认跳转到其他店铺?',
        cancelText: '我再想想',
        confirmText: '确认跳转',
        success: (res) => {
          res.confirm && this.changeStore(storeGuid)
        }
      });
    }
  },
  clearStoreInfo() {
    this.globalData.storeInfo = null;
    this.globalData.productTagList = null;
    this.globalData.wishList = [];
    this.globalData.shippingCost = 0;
  },
  doReload() {
    wx.showModal({
      title: '错误',
      content: '网络请求出错，重新加载',
      showCancel: false,
      success(res) {
        wx.reLaunch({
          url: '/pages/home/index',
        });
      }
    })
  },
  globalData: {
    /** store info **/
    storeInfo: null,
    apiLoginInfo: null,
    productTagList: [],
    wishList: [],
    shippingCost: 0,
    /** store info **/

    chinaCityCode: null,
    seller: false,
    hometimerId: null,
    moments: [],
    productGroupNames: [],
    photoWallList: [],
    myAccessStores: [],

    // UI
    titleHeight: 50, // px
    bottomTabBarHeight: 50, //px
    topTabBarHeight: 44, //px
  },
  loadingHideTimer: null,
});
