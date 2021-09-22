import Util from "../../../utils/util.js";
const app = getApp();

Page({
  data: {
    mainIndex: 0,
    images: [],
    progress: {
      show: false,
    },
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },

  onLoad() {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('getImages', (list) => {
      this.setData({
        images: list
      });
    });
  },
  onSetMain({ target }) {
    const { index } = target.dataset;
    this.setData({
      mainIndex: index
    })
  },
  onChooseImage(e) {
    Util.chooseImage({
      onProgress: (progress) => {
        this.setData({
          progress
        })
      }
    }).then(result => {
      const { images } = this.data;
      const { progress, imageList } = result
      this.setData({
        progress,
        images: images.concat(imageList)
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
  onDelete({ target }) {
    const { images } = this.data;
    const { index } = target.dataset;
    images.splice(index, 1);

    this.setData({
      images
    })
  },
  onSave(e) {
    const { mainIndex, images } = this.data;
    const eventChannel = this.getOpenerEventChannel();
    const list = [images[mainIndex]];
    images.splice(mainIndex, 1);
    eventChannel.emit('setImages', list.concat(images));
    wx.navigateBack({
      changed: true
    })
  }
})
