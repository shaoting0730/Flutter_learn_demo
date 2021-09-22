import webapi from "../../utils/webapi"
const app = getApp()

Component({
  properties: {
    moment: {
      type: Object,
      value: {},
      observer: 'upMoment'
    },
    seller: {
      type: Boolean,
      value: false,
    },
    isAdvertisement: {
      type: Boolean,
      value: false,
    },
    publish: {
      type: Number,
      value: 0,
    },
    StoreGuid: {
      type: String,
      value: '',
    },
    disableComment:{
      type: Boolean,
      value: false
    }
  },
  data: {
    moment: {}
  },
  methods: {
    upMoment(n) {
      this.setData({ moment: n })
    },
    onAdvertisement(event) {
      const guid = event.currentTarget.dataset.guid;
      wx.navigateTo({
        url: '/pages/advertisement/advertisement?guid=' + guid
      });
    },
    onPublishAdvertisement(event) {
      const guid = event.currentTarget.dataset.guid;
      webapi.PublishAdvertisement({ Guid: guid }).then((res) => {
        if (res.Success) {
          wx.navigateTo({
            url: '/pages/advertisement/advertisementhistory?publish=' + this.properties.publish
          });
        } else {
          wx.showToast({
            title: "网络异常",
            icon: 'none',
            duration: 2000,
          });
        }
      }).catch((res) => {
        console.log("网络异常", res);
        app.hideLoading();
      });
    },
    onRemoveAdvertisement(event) {
      const guid = event.currentTarget.dataset.guid;
      wx.showModal({
        title: '提示',
        content: '您确定下架广告吗？',
        success: function (res) {
          if (res.confirm) {
            webapi.RemoveAdvertisement([guid]).then((res) => {
              wx.redirectTo({
                url: '/pages/advertisement/advertisementhistory?publish=' + this.properties.publish
              });
            });
          } else if (res.cancel) {
          }
        }
      })
    },
    onGoToStore(event) {
      const guid = event.currentTarget.dataset.guid;
      var selectedMoment;
      this.data.moments.forEach((val, key) => {
        if (val.Guid === guid)
          selectedMoment = val;
      });
      wx.showModal({
        title: '提示',
        content: '您正在离开当前店铺，去往新店铺，确定吗？',
        success: function (res) {
          if (res.confirm) {
            webapi.AdvertisementClicked(selectedMoment.Advertisement.Guid).then((res) => {
              if (res.Success) {
                app.clearStoreInfo();
                app.globalData.storeHost = selectedMoment.Advertisement.PublishStoreHost;
                app.globalData.storeGuid = selectedMoment.Advertisement.PublishStoreGuid;
                app.globalData.userInfo = null;
                app.globalData.apiLoginInfo = null;
                app.globalData.storeInfo = null;
                wx.reLaunch({
                  url: '/pages/home/index?active=0&ShareProductGuid=' + selectedMoment.Advertisement.DisplayItemGuid,
                });
              } else {
                wx.showToast({
                  title: "网络异常",
                  icon: 'none',
                  duration: 2000,
                });
              }
            }).catch((res) => {
              console.log("网络异常", res);
              app.hideLoading();
            });
          } else if (res.cancel) {
          }
        }
      })
    },
    onUpdataMoment({ detail }) {
      this.setData({
        moment: detail
      })
    }
  }
})
