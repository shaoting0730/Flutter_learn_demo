var app = getApp();
import webapi from './../../utils/webapi';
import Request from './../../utils/request';
import Util from './../../utils/util';
// pages/share/index.js
Page({

    /**
     * 页面的初始数据
     */
    data: {
        shareImageUrl: null,
        shareGroupGuid:'',
        clientHeight: 'auto',
        offsetHeight: 0,
    },

    /**
     * 生命周期函数--监听页面加载
     */
  onLoad: function (options) {
    const momentguid = options.momentguid;
    wx.getSystemInfo({
      success: (res) => {
        this.setData({
          clientHeight: res.windowHeight
        });
        console.log("clientHeight-->", res.windowHeight);
      }
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
      this.getShareImage(momentguid);
    }
  },

  getShareImage: function (momentguid) {
    wx.showLoading({
      title: '正在加载中...',
      icon: 'loading',
      mask: true,
    });
    webapi.GetDQMomentSharePicture(momentguid).then(json => {
      console.log("GetDQMomentSharePicture--->", json);
      this.setData({
        shareImageUrl: json.Data.ImageUrl,
        shareGroupGuid: json.Data.ShareGuid,
      });
      wx.hideLoading();
    });
  },

  onReady: function () {

  },
  bindSaveShare: function () {
    wx.showLoading({
      title: '正在保存',
      icon: 'loading',
      mask: true,
    });
    const { shareImageUrl } = this.data;
    if (shareImageUrl != null) {
      Util.saveImgToPhotosAlbum(shareImageUrl).then(res => {
        console.log("bindSaveShare--->", res);
        Util.showToast("图片已保存到相册");
      });
    }
    wx.hideLoading();
  },
  onShareAppMessage: function () {
    var storeName = Request.getStoreName();
    var storeGuid = Request.getStoreGuid();
    const sharePageUrl = '/pages/home/index?active=1&ShareProductGuid=' + this.data.shareGroupGuid + '&storeGuid=' + storeGuid + '&storeName=' + storeName;
    const { shareImageUrl } = this.data;
    console.log("shareApp--->", sharePageUrl);
    return {
      title: '来看看，这里有你想要的~',
      path: sharePageUrl,
      imageUrl: shareImageUrl,
      success: function (res) {
        showToast("分享成功");
      },
      fail: function (res) {
        // 分享失败
        showToast("分享已取消");
      }
    };
  },
})