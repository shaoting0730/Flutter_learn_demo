
import webapi from "../../utils/webapi"
import Dialog from '/@vant/weapp/dialog/dialog';

const app = getApp();
const REG = /^(回复@)[\s\S]*(：)([\s\S]*)$/g;

Page({
  data: {
    moment: {},
    commentText: '',
    disableComment: false,
    seller: false,
    replie: {}
  },
  onLoad(options) {
    wx.setNavigationBarTitle({ title: "店主推荐详情" });
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.emit("getMoment", moment => {
      this.setData({
        moment,
        seller: app.globalData.seller,
        disableComment: app.globalData.apiLoginInfo.DisableComment === 1
      })
    });
  },
  onCommentChange({ detail }) {
    this.setData({
      commentText: detail
    })
  },
  onCommit(e) {
    const eventChannel = this.getOpenerEventChannel();
    const { commentText, moment, replie } = this.data;
    let content = commentText.trim()
    const postData = {
      GroupGuid: moment.Guid,
    }
    if (commentText.search(REG) > -1) {
      content = commentText.replace(REG, '$3')
      postData.ReplyToGuid = replie.Guid
    }
    postData.Content = content;

    if( postData.Content.length >0 ){
      webapi.AddNewComment(postData).then(res => {
        if (res.Success) {
          moment.Comments = res.Data;
          this.setData({
            moment,
            commentText: ''
          })
          if (!postData.ReplyToGuid) {
            eventChannel.emit('updataMoment', moment)
          }
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
    }else{
      wx.showToast({
        title: "请填写评论！",
        icon: "none",
      });
    }


  },
  onReplieUser(e) {
    const { item } = e.currentTarget.dataset;
    let { commentText, seller } = this.data;
    if (seller){
      if (commentText.search(REG) > -1) {
        commentText = commentText.replace(REG, '$1' + item.StoreCustomerName + '$2$3')
      } else {
        commentText = `回复@${item.StoreCustomerName}：${commentText}`
      }
      this.setData({
        commentText,
        replie: item
      })
    }
  },
  onUpdataMoment({ detail }) {
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.emit('updataMoment', detail)
  },
  onSetTop(e) {
    const { value, item } = e.currentTarget.dataset;
    if (value === '1') {
      Dialog.confirm({
        zIndex: 1000,
        title: '是否确定设置该评论置顶？',
        message: ' '
      }).then(() => {
        this.setCommentAtTop({ Guid: item.Guid, "AtTheTop": value })
      }).catch(() => {
      });
    } else {
      this.setCommentAtTop({ Guid: item.Guid, "AtTheTop": value })
    }
  },
  setCommentAtTop(model) {
    const eventChannel = this.getOpenerEventChannel();
    const { moment } = this.data;
    webapi.SetCommentAtTop(model).then(res => {
      if (res.Success) {
        moment.Comments = res.Data;
        this.setData({ moment })
        eventChannel.emit('updataMoment', moment)
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
});
