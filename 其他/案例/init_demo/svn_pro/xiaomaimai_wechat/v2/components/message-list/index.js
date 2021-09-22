import util from "../../utils/util";

var app = getApp();
var webapi = require('../../utils/webapi');

function getDisableCommentText(checked) {
  return checked ? "全站评论开启" : "全站评论关闭"
}

Component({
  properties: {
    ishome: {
      type: Boolean,
      value: false
    }
  },
  data: {
    seller: false,
    checked: true,
    searchModel: {
      pageIndex: 0,
      pageSize: 10
    },
    scrollTop: 0,
    refresherScrollTop: 0,
    messageData: [],
    disableCommentText: getDisableCommentText(true),
    scrollHeight: app.getClientAreaHeight(),
    safeAreaBottom: app.getSafeAreaBottom(),

  },
  ready() {

  },

  methods: {
    onLoad(){
      this.refresher = this.selectComponent("#refresher");
      this.refresher.setParent(this);
      const { ishome } = this.properties;

      const checked = app.globalData.apiLoginInfo.DisableComment === 0

      this.setData({
        seller: app.globalData.seller,
        checked,
        disableCommentText: getDisableCommentText(checked),
        scrollHeight: app.getClientAreaHeight()- (ishome ? 44 + 50 : 0)
      }, () => {
        this.refresher.triggerRefresh();
      })
    },
    onChange({ detail }) {
      const value = detail ? 0 : 1
      webapi.SetDisableComment(value).then(res => {
        app.globalData.apiLoginInfo.DisableComment = res.Data
        app.getHomePage().updataDisableComment();
        this.setData({
          checked: detail,
          disableCommentText: getDisableCommentText(detail)
        }, () => {
          this.refresher.triggerRefresh();
        })
      })
    },
    refresherScroll(e) {
      this.setData({
        refresherScrollTop: e.detail.scrollTop
      });
    },
    onRefresh() {
      const { searchModel, checked } = this.data;
      searchModel.pageIndex = 0;
      if (checked) {
        this.getMassages().then(data => {
          this.refresher.finishPullToRefresh();
        });
      } else {
        this.setData({
          messageData: []
        })
        this.refresher.finishPullToRefresh();
        this.refresher.finishLoadmore(true);
      }
    },
    onLoadmore() {
      const { searchModel, messageData, checked } = this.data;
      searchModel.pageIndex += 1;
      this.getMassages().then(data => {
        const isEnd = data.TotalCount === messageData.length;
        this.refresher.finishLoadmore(isEnd);
      });
    },
    getMassages() {
      const { searchModel, messageData, seller } = this.data;

      const result = seller ?
        webapi.StoreRecentComment(searchModel) :
        webapi.MyRecentComment(searchModel);

      result.then(res => {
        if (res.Success) {
          const { ListObjects } = res.Data;
          if (searchModel.pageIndex === 0) {
            this.setData({
              messageData: ListObjects
            })
          } else {
            this.setData({
              messageData: messageData.concat(ListObjects)
            })
          }
          return res.Data
        } else {
          wx.showToast({
            title: "网络异常",
            icon: 'none',
          });
        }
      }).catch((res) => {
        console.log("网络异常", res);
        app.hideLoading();
      });
      return result;

    },
    onToComment(e) {
      const { item } = e.currentTarget.dataset;
      wx.showLoading({
        title: '加载中',
      })
      webapi.searchDQProductGroup({ ProductGroupGuid: [item.GroupGuid], pageIndex: 0, pageSize: 1 }).then(res => {
        wx.hideLoading()
        if (res && res.Success) {
          const { ListObjects } = res.Data;
          if (ListObjects.length > 0) {
            wx.navigateTo({
              url: '/pages/comment/index',
              events: {
                getMoment(callback) {
                  const moment = ListObjects[0];
                  moment.UpdatedOn = util.timeStampToDateTime(moment.UpdatedOn, "M-D");
                  callback(moment)
                },
                updataMoment: (moment) => {
                  app.getHomePage().updateMoment(moment)
                }
              }
            });
          } else {
            wx.showToast({
              title: "该商品已经不存在",
              icon: 'none',
            });
          }
        } else {
          wx.showToast({
            title: "网络异常",
            icon: 'none',
          });
        }
      }).catch((res) => {
        console.log("网络异常", res);
        wx.hideLoading()
        app.hideLoading();
      });
    }
  }
})

