/**
 * PageXXXX XXXX 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
var app = getApp();
var webapi = require('../../utils/webapi');

Page({
    data: {
        errInfo: "",
        myAccessStores: [],
    },
    onLoad: function (options) {
        app.GetMyStoreList({
            success: (myAccessStores) => {
                this.setData({myAccessStores})
            },
            fail: () => {
                this.setData({errInfo: "无法获取我的小买卖信息。"});
            }
        })
    }
});
