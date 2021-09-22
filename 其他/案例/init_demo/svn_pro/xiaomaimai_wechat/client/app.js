import Request from "./utils/request";
import webApi from "./utils/webapi";
var webapi = require('./utils/webapi');
var config = require('./utils/config');

//app.js
App({
    onLaunch: function (options) {
        let query = options.query
        ///wx.cloud.init();
        if (query.hasOwnProperty("REFCODE")) {
            wx.setStorageSync('Refercode', query.REFCODE)
        }

    },
    // 登录
    getUserInfo: function (cb) {
        var that = this
        if (this.globalData.userInfo) {
            typeof cb == "function" && cb(this.globalData.userInfo);
        } else {
            wx.showLoading({
                title: '正在登录',
                icon: 'loading',
                mask: true,
            });
            console.log("登录中....");
            wx.login({
                success: resLogin => {
                    // 发送 res.code 到后台换取 openId, sessionKey, unionId
                    console.log("wx.login 成功", resLogin);
                    wx.getUserInfo({
                        success: res => {
                            console.log("wx.getUserInfo 成功", res);
                            // 可以将 res 发送给后台解码出 unionId
                            that.globalData.userInfo = res.userInfo;
                            webapi.userLogin(resLogin.code, res.encryptedData, res.iv).then((res) => {
                                console.log(res, "--->LoginInfo");
                                wx.hideLoading();
                                if (res.Success) {
                                    Request.setApiLoginInfo(res.Data);
                                    webapi.retrieveStoreInfo().then((res2) => {
                                      if(res2.Success)
                                      {
                                        that.globalData.storeInfo = res2.Data;
                                        that.globalData.seller = that.globalData.storeInfo == null ? false : that.globalData.storeInfo.OwnerGuid == that.globalData.apiLoginInfo.StoreCustomerGuid;
                                      }
                                      typeof cb == "function" && cb(that.globalData.userInfo);
                                    });
                                    webapi.loadChinaCityCode().then((res2) => {
                                        that.globalData.chinaCityCode = res2.Data;
                                    });
                                    webapi.loadProductTags().then((res2) => {
                                        that.globalData.productTagList = res2.Data;
                                    });
                                    webApi.loadWishList().then(wishListRes => {
                                        let wishList = [];
                                        if (wishListRes && wishListRes.Success) {
                                            wishListRes.Data.forEach(d => wishList.push(d.Guid));
                                            that.globalData.wishList = wishList;
                                        }
                                    });
                                    webApi.GetBasicShippingFee().then((res)=>{
                                      if(res.Success)
                                          that.globalData.shippingCost = res.Data;
                                    });
                                } else {
                                    console.log(res, "数据状态");
                                    wx.showToast({
                                        title: "网络异常",
                                        icon: 'none',
                                        duration: 2000,
                                    });
                                }

                            }).catch((res) => {
                                console.log("登录异常", res);
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
        }
    },
    globalData: {
      userInfo: null,
      apiLoginInfo: null,
      chinaCityCode: null,
      wishList: [],
      shippingCost:0,
      storeInfo:null,
      seller: false,
      hometimerId:null,
      storeName:null,
      storeGuid:null,
      productTagList: [],
      moments: [],
      productGroupNames: [],
      photoWallList: [],
      shoppingCartCount:0,
    },

})
