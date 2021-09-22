/**
 * PageXXXX 商品详情 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
import Request from "../../utils/request";

var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';

Page({
    data: {
        clientHeight: 'auto',
        offsetHeight: 0,
        apiLoginInfo: null,
        userInfo: null,
        seller:false,
        vendorCode:'',
     },
    onShow: function () {
    },

    onLoad: function (options) {
        wx.getSystemInfo({
            success: (res) => {
                this.setData({
                    clientHeight: res.windowHeight
                });
                console.log("clientHeight-->", res.windowHeight)
            }
        });

        const apiLoginInfo = Request.getApiLoginInfo();
        const userInfo = Request.getUserInfo();
        console.log(apiLoginInfo, "---->apiLoginInfo");
        this.setData({
            apiLoginInfo: apiLoginInfo,
            userInfo: userInfo,
            seller:app.globalData.seller,
            vendorCode: apiLoginInfo.CustomerUniqueCode,
            maskPhoneNumber: Util.maskInfo(apiLoginInfo.CellPhone, '*', 3, 3),
        });
    },
    bindAddressTo: function () {
        wx.navigateTo({url: "/pages/address/user-address/user-address"});
    },
    bindMyOrder: function () {
        wx.navigateTo({url: "/pages/address/user-address/user-address"});
    },
    copyVendorCode: function () {
      const vendorCode = this.data.apiLoginInfo.CustomerUniqueCode;
      Util.setClipboard(vendorCode, "供应商推荐码已复制");
    },
    bindPhoneNumber:function(){
        //跳转到手机号
        wx.navigateTo({url:"/pages/choose-binding-phone-ways/index"});
    },
    // onShareAppMessage:Util.shareApp,
});
