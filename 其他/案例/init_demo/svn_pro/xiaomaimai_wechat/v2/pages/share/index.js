var app = getApp();
import Util from './../../utils/util';
Page({
  data: {
    shareImageUrl: null,
    shareGroupGuid: '',
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
    shareReturn: {},
    navTitle: '分享好友',
    share: {}
  },
  onLoad(options) {
    const eventChannel = this.getOpenerEventChannel()
    wx.showShareMenu({
      withShareTicket: true
    })
    eventChannel.emit('getShare', (data) => {
      this.setData({
        ...data
      })
    });
    eventChannel.emit('getImage', (data) => {
      this.setData({
        shareImageUrl: data.ImageUrl,
        shareGroupGuid: data.ShareGuid,
        share: data.share
      })
    });
  },
  bindSaveShare() {
    app.showLoading({
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
    app.hideLoading();
  },
  onShareAppMessage() {
    const sharePageUrl = Util.getShareUrl() + '&active=1&ShareProductGuid=' + this.data.shareGroupGuid
    const { shareImageUrl, share } = this.data;
    console.log("shareApp--->", sharePageUrl, share);

    return {
      title: share.title || '来看看，这里有你想要的~',
      path: share.path || sharePageUrl,
      imageUrl: shareImageUrl,
      success(res) {
        showToast("分享成功");
      },
      fail(res) {
        showToast("分享已取消");
      }
    };
  },
})
