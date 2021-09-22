// pages/advertisement/advertisement.js
import webApi from "../../utils/webapi"
import util from "../../utils/util"
import Request from "../../utils/request";

const app = getApp()

Page({

  /**
   * 页面的初始数据
   */
  data: {
    moment:{},
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    if (options.guid)
    {
      wx.showLoading({
        title: '获取数据...',
      })
      webApi.searchDQProductGroup({ ShareGroupKey: options.guid })
        .then(res => {
          wx.hideLoading();
          if (res && res.Success) {
            let list = res.Data.ListObjects;
            list.forEach((val, key) => {
              val.Description = val.Description.substring(val.Description.indexOf(" ") + 1);
              val.UpdatedOn = util.timeStampToDateTime(val.UpdatedOn, 'M-D');
              if(val.Advertisement==null)
                val.Advertisement = {};
            });
            this.setData({ moment: list[0] });
          }
        });
    }
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  },
  
  bindAddMomentDesc: function(event) {
    var moment = this.data.moment;
    moment.Advertisement.Description = event.detail.value;
    this.setData({ moment: moment });
  },
  onPublishAdvertisement: function () {
    if (app.globalData.apiLoginInfo.AccountBalance<100){
      wx.showModal({
        title: '账户余额不足',
        content: '投放广告的客户需要账户余额至少100元才可以使用，请使用您的店主账户登录www.xiaomaimaiquan.com网站充值后再使用！',
      });
      return;
    }
    if(this.data.moment.Guid)
    {
      wx.showLoading({
        title: '正在发布...',
      });
      webApi.PublishAdvertisement({ PublishStoreGuid: Request.getStoreGuid(), PublishStoreHost: Request.getStoreName(), DisplayStoreGuid: '', DisplayItemGuid: this.data.moment.Guid, Description: this.data.moment.Advertisement.Description, DisplayType: 1, Status: 1, BidPrice:1 })
        .then(res => {
          wx.hideLoading();
          if (res && res.Success) {
            wx.navigateTo({
              url: '/pages/advertisement/advertisementhistory?publish=1',
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
    }
    wx.showLoading({
      title: '正在提交数据...',
    })
  }
})