/**
 * PageXXXX XXXX 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';

Page({
    data: {
        shareImageUrl: null,
        clientHeight: 'auto',
        offsetHeight: 0,
        storeName: {},
        GZHQRCode: '',
        ReferCode: '',
    },
    onLoad: function (options) {
        wx.getSystemInfo({
            success: (res) => {
                this.setData({
                    clientHeight: res.windowHeight
                });
                console.log("clientHeight-->", res.windowHeight);
            }
        });
        this.setData({
            storeName: app.globalData.storeInfo.StoreName
        });
        console.log("share-to-friend---->onLoad", options);
        wx.showShareMenu({
            withShareTicket: true
        })
        webapi.GetGZHQRCode().then(res => {
            this.setData({GZHQRCode: res.Data.ImageUrl, ReferCode: res.Data.ShareGuid});
        });
        if (options.hasOwnProperty("shareImageUrl")) {
            this.setData({
                shareImageUrl: options.shareImageUrl,
            });
        } else {
            this.getShareImage();
        }
    },

    getShareImage: function () {
        webapi.GetGZHSharePicture().then(json => {
            console.log("GetMySharePicture--->", json);
            this.setData({
                shareImageUrl: json.Data.ImageUrl,
            });
        });
    },
    onReady: function () {

    },

    onCopy: function() {
        Util.setClipboard(this.data.apiLoginInfo.CustomerUniqueCode, `供货商推荐码 ${this.data.apiLoginInfo.CustomerUniqueCode} 已复制`);
    },

    bindSaveShare: function () {
        const {shareImageUrl} = this.data;
        if (shareImageUrl != null) {
            Util.saveImgToPhotosAlbum(shareImageUrl).then(res => {
                console.log("bindSaveShare--->", res);
                Util.showToast("图片已保存到相册");
            });
        }
    },
    bindShareToFirend: function () {
        console.log("bindSaveShare--->")
    },
    onShareAppMessage: function () {
        return {
            title: "推荐您成为我的小买卖圈的分销商，跟我一起开店吧～",
            path: Util.getShareUrl()
        };
    },
});
