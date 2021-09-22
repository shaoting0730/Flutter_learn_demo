/**
 * PageXXXX XXXX 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';
import Request from "../../utils/request";

Page({
    data: {
      userInfo:null,
        shareImageUrl:null,
        clientHeight:'auto',
        offsetHeight:0,
    },
    onLoad: function (options) {
        wx.getSystemInfo({
            success: (res)=>{
                this.setData({
                    clientHeight: res.windowHeight
                });
                console.log("clientHeight-->",res.windowHeight);
            }
        });
        console.log("share-to-friend---->onLoad",options);
        wx.showShareMenu({
            withShareTicket: true
        })
        if(options.hasOwnProperty("shareImageUrl")){
            this.setData({
                shareImageUrl:options.shareImageUrl,
            });
        }else{
            this.getShareImage();
        }
    },
    getShareImage:function(){
      this.setData({
        shareImageUrl: app.globalData.storeInfo.ShareQRCode,
      });
    },
    onReady:function(){

    },
    bindSaveShare:function(){
      const {shareImageUrl} = this.data;
        if(shareImageUrl!=null){
            Util.saveBase64ImgToPhotosAlbum(shareImageUrl).then(res=>{
                console.log("bindSaveShare--->",res);
                Util.showToast("图片已保存到相册");
            });
        }
    },
    bindShareToFirend:function(){
        console.log("bindSaveShare--->")
    },
    onShareAppMessage: function(){
        return Util.shareApp(true);
    },
});
