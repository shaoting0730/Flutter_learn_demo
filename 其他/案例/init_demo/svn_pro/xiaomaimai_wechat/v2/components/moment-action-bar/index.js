import webapi from "../../utils/webapi"

import Popover from "../one-popover/popover"
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
    showMome: {
      type: Boolean,
      value: true
    },
    showCommentBtn: {
      type: Boolean,
      value: true
    },
    disableComment: {
      type: Boolean,
      value: false
    }
  },
  data: {
    hasLiked: false,
    likes: 0,
    count: 0,
    disableComment: false
  },
  ready() {
    this.popover = this.selectComponent("#popover");
    // this.setData({
    //   disableComment: app.globalData.apiLoginInfo.DisableComment === 1
    // })
  },
  methods: {
    upMoment(n) {
      const { HasLiked, Likes, Comments = [] } = n;
      this.setData({
        hasLiked: HasLiked === 1,
        likes: Likes || 0,
        count: Comments.length
      })

    },
    onLike(e) {
      const { moment } = this.properties
      const { hasLiked, likes } = this.data;
      const model = { GroupGuid: moment.Guid };
      (hasLiked ? webapi.RemoveLike(model) : webapi.AddNewLike(model)).then(res => {
        if (res.Success) {
          this.setData({
            hasLiked: !hasLiked,
            likes: res.Data
          })
          this.triggerEvent('updataMoment', {
            ...moment,
            HasLiked: !hasLiked ? 1 : 0,
            Likes: res.Data
          })
        }
      })
    },
    onShare(e) {
      const { moment } = this.properties
      wx.navigateTo({
        url: '/pages/share/index',
        events: {
          getImage: (callback) => {
            webapi.GetDQMomentSharePicture(moment.Guid)
              .then(res => {
                callback(res.Data)
              });
          }
        }
      });
    },
    onSetTop(e) {
      const { moment } = this.properties
      const { value } = e.currentTarget.dataset;
      const homePage = app.getHomePage();
      const { moments } = homePage.data
      const count = moments.filter(item => item.AtTheTop === 1).length;
      this.popover.onChange()
      if (count < 3) {
        webapi.SetMomentAtTop({
          Guid: moment.Guid,
          AtTheTop: value
        }).then(res => {
          if (res.Success) {
            homePage.momentsSearch({ detail: {} })
          } else {
            wx.showToast({
              title: res.Message,
              icon: "none",
            });
          }
        })
      } else {
        wx.showToast({
          title: '最多只能置顶3条推荐',
          icon: "none",
        });
      }
    },
    onRemoveMoment() {
      const { moment } = this.properties
      this.popover.onChange()
      const homePage = app.getHomePage();
      wx.showModal({
        title: '提示',
        content: '您确定删除此内容吗？',
        success: (res) => {
          if (res.confirm) {
            webapi.removeMoment({ Guid: moment.Guid }).then((res) => {
              homePage.removeMoment(moment.Guid)
            });
          } else if (res.cancel) {
          }
        }
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
    onShowPopover() {
      Popover.close()
      Popover.add(this.popover)
    }
  }
});

