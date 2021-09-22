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
      value: true
    },
    disableComment:{
      type: Boolean,
      value: false
    }
  },
  data: {
    comments: [],
    count: 0,
    disableComment: false
  },
  ready() {
    // this.setData({
    //   disableComment: app.globalData.apiLoginInfo.DisableComment === 1
    // })
  },
  methods: {
    upMoment(n) {
      const Comments = n.Comments || [];
      this.setData({
        comments: Comments.slice(0, 3),
      })
    },
    onToComment(e) {
      const { moment } = this.properties;
      wx.navigateTo({
        url: '/pages/comment/index',
        events: {
          getMoment(callback) {
            callback(moment)
          },
          updataMoment: (moment) => {
            this.triggerEvent('updataMoment', moment)
          }
        }
      });
    },
    onComment(e) {
      app.getHomePage().onShowMomment(this.commitMomment.bind(this))
    },
    commitMomment(text) {
      const { moment } = this.properties;

      return webapi.AddNewComment({
        GroupGuid: moment.Guid,
        Content: text
      }).then(res => {
        if (res.Success) {
          this.triggerEvent('updataMoment', {
            ...moment,
            Comments: res.Data
          })
          return res;
        } else {
          wx.showToast({
            title: res.Message,
            icon: "none",
          });
        }
      }).catch(res => {
        wx.showToast({
          title: "网络异常",
          icon: "none",
        });
      });

    }
  },

});

