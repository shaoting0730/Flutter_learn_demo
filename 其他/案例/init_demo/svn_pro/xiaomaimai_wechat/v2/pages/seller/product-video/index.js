import Util from "../../../utils/util.js";
const app = getApp();

Page({
  data: {
    videoUrl: '',
    progress: {
      show: false,
    },
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onLoad() {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('getVideo', (url) => {
      this.setData({
        videoUrl: url
      });
    });
  },
  onSetMain({ target }) {
    const { index } = target.dataset;
    this.setData({
      mainIndex: index
    })
  },
  onChooseVideo(e) {
    Util.chooseVideo((progress) => {
      this.setData({
        progress
      })
    }).then(result => {
      const { progress, url } = result
      this.setData({
        progress,
        videoUrl: url
      })
    }).catch(() => {
      wx.showToast({
        title: "网络异常",
        icon: 'none',
        duration: 2000,
      });
      this.setData({
        progress: { show: false, percent: 0 }
      })
    })
  },
  onSave(e) {
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.emit('setVideo', this.data.videoUrl);
    wx.navigateBack({
      changed: true
    })
  }
})
