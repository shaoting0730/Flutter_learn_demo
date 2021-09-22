//index.js
var app = getApp();
var webapi = require('../../utils/webapi');

Page({
    data: {
        userInfo: {},
        AccountBalance: 0,
        seller: false,
    },
    onShow: function () {
        this.setData({seller: app.globalData.seller, userInfo: app.globalData.userInfo, AccountBalance: app.globalData.apiLoginInfo.AccountBalance});
    },

    bindShowAdvertisement() {
        wx.navigateTo({
            url: '/pages/advertisement/advertisementhistory?publish=0'
        });
    },
    bindAdvertisementHistory() {
        wx.navigateTo({
            url: '/pages/advertisement/advertisementhistory?publish=1'
        });
    },
    onLoad: function (options) {
        this.setData({seller: app.globalData.seller, userInfo: app.globalData.userInfo, AccountBalance: app.globalData.apiLoginInfo.AccountBalance});
    },
})
