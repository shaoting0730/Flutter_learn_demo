/**
 * PageXXXX XXXX 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';

Page({
    data: {},
    onShow: function () {
    },

    onLoad: function (options) {

    },
    bindByWechat: function (event) {
        console.log("bindByWechat", event);
        //获取到用户手机号后，绑定
        const phoneNumber = "";
        Util.showToast("正在绑定手机号")
        webapi.UpdateStoreCustomerAttribute({
            // Guid:"",
            AttributeName: webapi.StoreCustomerAttributeName.BindMobile,
            AttributeValue: phoneNumber,
            // AttributeType:"",
            ActionType: webapi.UpdateAction.Overwrite,
        }).then(json => {
            Util.showToast("手机号绑定成功");
        });

    },
    bindByUser: function () {
        wx.navigateTo({url: `/pages/binding-phone-by-manual/index`});
    },
    // onShareAppMessage: Util.shareApp,
});
