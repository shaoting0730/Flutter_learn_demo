import webApi from "../../utils/webapi"
const app = getApp()

// components/listbox/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
      moments: {
          type: Array,
          value: []
      },
      seller:{
        type:Boolean,
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
    },

    /**
     * 组件的初始数据
     */
    data: {
    },
    /**
     * 组件的方法列表
     */
    methods: {
      /**
       * 收藏
       */
      onFavorite(event) {
          console.log("收藏", event);
      },
      /**
       * 分享
       */
      onShare(event) {
        const guid = event.currentTarget.dataset.guid;
          wx.navigateTo({
            url: '/pages/share/index?momentguid=' + guid
          });
      },
      onAdvertisement(event) {
        const guid = event.currentTarget.dataset.guid;
        wx.navigateTo({
          url: '/pages/advertisement/advertisement?guid=' + guid
        });
      },
      onPublishAdvertisement(event) {
        const guid = event.currentTarget.dataset.guid;
        wx.showLoading({
          title: '正在发布...',
        });
        webApi.PublishAdvertisement({ Guid: guid}).then((res)=>{
          wx.hideLoading();
          if(res.Success)
          {
            wx.navigateTo({
              url: '/pages/advertisement/advertisementhistory?publish=' + this.properties.publish
            });
          }
          else {
            wx.showToast({
              title: "网络异常",
              icon: 'none',
              duration: 2000,
            });
          }
        }).catch((res) => {
          console.log("网络异常", res);
          wx.hideLoading();
        });
      },
      onRemoveAdvertisement(event){
        const guid = event.currentTarget.dataset.guid;
        wx.showModal({
          title: '提示',
          content: '您确定下架广告吗？',
          success: function (res) {
            if (res.confirm) {
              webApi.RemoveAdvertisement([guid]).then((res) => {
                wx.redirectTo({
                  url: '/pages/advertisement/advertisementhistory?publish='+this.properties.publish
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
          if(val.Guid==guid)
            selectedMoment = val;
        });
        wx.showModal({
          title: '提示',
          content: '您正在离开当前店铺，去往新店铺，确定吗？',
          success: function (res) {
            wx.hideLoading();
            if (res.confirm) {
              wx.showLoading({
                title: '正在跳转...',
              });
              webApi.AdvertisementClicked(selectedMoment.Advertisement.Guid).then((res)=>{
                if(res.Success)
                {
                  app.globalData.storeName = selectedMoment.Advertisement.PublishStoreHost;
                  app.globalData.storeGuid = selectedMoment.Advertisement.PublishStoreGuid;
                  app.globalData.userInfo = null;
                  app.globalData.apiLoginInfo = null;
                  app.globalData.productTagList = null;
                  app.globalData.wishList = [];
                  app.globalData.shippingCost = 0;
                  app.globalData.storeInfo = null;
                  app.globalData.moments = [];
                  app.globalData.productGroupNames = [];
                  app.globalData.photoWallList = [];
                  wx.reLaunch({
                    url: '/pages/home/index?active=0&ShareProductGuid=' + selectedMoment.Advertisement.DisplayItemGuid,
                  });
                }
                else {
                  wx.showToast({
                    title: "网络异常",
                    icon: 'none',
                    duration: 2000,
                  });
                }
              }).catch((res) => {
                console.log("网络异常", res);
                wx.hideLoading();
              });
            } else if (res.cancel) {
            }
          }
        })
      },
      onRemoveMoment(event) {
        const guid = event.currentTarget.dataset.guid;
        wx.showModal({
          title: '提示',
          content: '您确定删除此内容吗？',
          success: function (res) {
            if (res.confirm) {
              webApi.removeMoment({Guid:guid}).then((res)=>{
                app.globalData.moments = [];
                app.globalData.productGroupNames = [];
                app.globalData.photoWallList = [];
                wx.redirectTo({
                  url: '/pages/home/index'
                });
              });
            } else if (res.cancel) {
            }
          }
        })
      },
    }
})
