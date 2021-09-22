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
        wx.showLoading({
            title: '正在加载中...',
            icon: 'loading',
            mask: true,
        });
        webapi.GetMySharePicture().then(json=>{
            console.log("GetMySharePicture--->",json);
            this.setData({
                shareImageUrl:json.Data.ImageUrl,
            });
            wx.hideLoading();
        });
    },
    drawTextCenter(ctx,fontSize,fontColor,y,text){
        ctx.setFontSize(fontSize);
        const metrics = ctx.measureText(text);
        ctx.setFillStyle(fontColor);
        ctx.fillText(text, (690-metrics.width)/2, y);
    },
    drawRichTextCenter(ctx,fontSize,fontColor,y,textList){
        let totalWidth = 0;
        let textMetricList = [];
        textList.map((textInfo,index)=>{
            ctx.setFontSize(textInfo.fontSize);
            const metrics = ctx.measureText(textInfo.text);
            totalWidth += metrics.width;
            textMetricList.push({
                index:index,
                textInfo:textInfo,
                metrics:metrics,
            });
        });
        let startX = (690 - totalWidth)/2;
        let offsetX = 0;
        textMetricList.map((textMetric,index)=> {
            ctx.setFontSize(textMetric.textInfo.fontSize);
            ctx.setFillStyle(textMetric.textInfo.fontColor);
            ctx.fillText(textMetric.textInfo.text, startX + offsetX, y);
            offsetX += textMetric.metrics.width;
        });
    },
    drawCanvas:function(){
        const me = this;
        const nickName = "微信昵称";
        const myPoint = 1200;
        const tips = "我已获得 12 枚徽章，打败了96%的人";
        //绘制背景
        var ctx = wx.createCanvasContext("canvas-shared")

        //绘制文字
        this.drawTextCenter(ctx,30,'red',210,nickName);
        this.drawTextCenter(ctx,26,'#666666',324,"我的积分");
        this.drawTextCenter(ctx,80,'#FF4E4E',420,myPoint);

        this.drawRichTextCenter(ctx,28,'#333333',500,[
            {text:"我已获得 ",fontSize:28,fontColor:"#333333"},
            {text:"12",fontSize:28,fontColor:"#3A8EFF"},
            {text:" 枚徽章，打败了96%的人",fontSize:28,fontColor:"#333333"},
        ]);

        //绘制二维码
        drawQrcode({
            x:175,
            y:625,
            width: 340,
            height: 340,
            // canvasId: 'canvas-shared',
            canvasContext:ctx,
            text: 'https://github.com/yingye',
            reserve:true,
            callback:function(){
                wx.canvasToTempFilePath({
                    canvasId: 'canvas-shared',
                    success: function(res) {
                        console.log("导出路径:",res.tempFilePath);
                        me.setData({
                            shareImageUrl:res.tempFilePath,
                        });
                    }
                })
            }
        });
    },
    onReady:function(){

    },
    bindSaveShare:function(){
        const {shareImageUrl} = this.data;
        if(shareImageUrl!=null){
            Util.saveImgToPhotosAlbum(shareImageUrl).then(res=>{
                console.log("bindSaveShare--->",res);
                Util.showToast("图片已保存到相册");
            });
        }
    },
    bindShareToFirend:function(){
        console.log("bindSaveShare--->")
    },
    onShareAppMessage: function(){
        return Util.shareApp();
    },
});
