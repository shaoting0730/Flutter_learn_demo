/**
 * PageXXXX XXXX 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
import Config from "../../utils/config";

var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';

Page({
    data: {
        shareImageUrl: null,
        clientHeight: 'auto',
        offsetHeight: 0,
        storeName: {},
        apiLoginInfo: {},
        top: app.px2rpx(84),
        canIUse: wx.canIUse('button.open-type.getUserInfo'),
        status: 'none',
        version: app.version,
        GZHQRCode: '',
    },
    onLoad: function (options) {
        this.setData({options});
        const self = this;
        console.log(options);
        webapi.logOnLoad(options);
        if (app.globalData.apiLoginInfo && (!options.storeGuid || app.globalData.apiLoginInfo.storeGuid === options.storeGuid)) {
            this.setData({status: 'ready'});
            self.initPage(options);
        } else {
            this.setData({status: 'need-author'});
            app.getUserInfo({
                success: () => {
                    app.clearStoreInfo();
                    webapi.loadUserBind(options.storeGuid || Config.StoreGuid).then((res) => {
                        if (res.Success) {
                            app.onLoggedIn(res.Data, {
                                success: () => {
                                    this.setData({status: 'ready'});
                                    self.initPage(options);
                                }
                            });
                        }
                    });
                },
            });
        }
    },

    initPage(options) {
        wx.getSystemInfo({
            success: (res) => {
                this.setData({
                    clientHeight: res.windowHeight
                });
                console.log("clientHeight-->", res.windowHeight);
            }
        });

        if(app.globalData.storeInfo && app.globalData.storeInfo.StoreName) {
            this.setData({
                storeName: app.globalData.storeInfo.StoreName,
                apiLoginInfo: app.globalData.apiLoginInfo,
            });
          }
          webapi.GetGZHQRCode().then(res => {
            console.log(res);
              this.setData({GZHQRCode: res.Data.ImageUrl, ReferCode: res.Data.ShareGuid});
          });
          console.log("share-to-friend---->onLoad", options);
          wx.showShareMenu({
              withShareTicket: true
          })
          if (options.hasOwnProperty("shareImageUrl")) {
              this.setData({
                  shareImageUrl: options.shareImageUrl,
              });
          } else {
              this.getShareImage();
          }
    },

    getShareImage: function () {
        webapi.GetMySharePicture().then(json => {
            console.log("GetMySharePicture--->", json);
            this.setData({
                shareImageUrl: json.Data.ImageUrl,
            });
        });
    },
    onReady: function () {

    },

    onCopy: function () {
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
    bindGetUserInfo(event) {
        if (event && event.detail && event.detail.userInfo) {
            this.setData({status: 'ready'});
            this.onLoad(this.data.options);
        }
    },
});
