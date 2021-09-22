const app = getApp()
import config from "../../utils/config"
import webapi from "../../utils/webapi"
import cloudApi from "../../utils/cloudapi"
import Request from "../../utils/request";

Page({

  /**
   * 页面的初始数据
   */
  data: {
    store:{},
    userInfo:{},
    progress: {
      percent: 0,
      show: false
    },
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

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
  onAddImage: function () {
    let appStore = this.data.store;
    var self = this;
    wx.chooseImage({
      sourceType: ['album', 'camera'],
      count:1,
      success: res => {
        var tempFileList = res.tempFilePaths;
        var countdown = tempFileList.length;
        tempFileList.forEach((o, index) => {
          var uploadTask = cloudApi.webapiUploadFiles(o);
          uploadTask.onProgressUpdate((res) => {
            self.setData({ progress: { percent: res.progress, show: true } });
            if (res.progress >= 100) {
              var fullPath = o;
              var arr = fullPath.split('/');
              var fileName = arr[arr.length - 1];
              if (Request.getToken()=="")
                appStore.WechatPaymentQRCode = config.serverFileRoot + "Default/" + fileName;
              else
                appStore.WechatPaymentQRCode = config.serverFileRoot + Request.getStoreGuid() + "/" + fileName;
              setTimeout(function () {
                self.setData({ progress: { percent: 0, show: false } });
                countdown--;
                if (countdown == 0)
                  self.setData({ store: appStore });
              }, 5000);
            }
          });
        });
      }
    });
  },

  formSubmit: function (e) {
    var adds = e.detail.value;
    this.data.store.Name = adds.name;
    this.data.store.PhoneNumber = adds.phone;
    this.data.store.Email = adds.email;
    this.data.store.IDCardNumber = '';
    this.data.store.ApplicationName = adds.applicationname;
    if (this.data.store.Name == null || this.data.store.Name=="")
    {
      wx.showToast({
        title: '姓名不能为空',
      });
      return;
    }
    if (this.data.store.PhoneNumber == null || this.data.store.PhoneNumber == "") {
      wx.showToast({
        title: '联系电话不能为空',
      });
      return;
    }
    if (this.data.store.Email == null || this.data.store.Email == "") {
      wx.showToast({
        title: '联系邮箱不能为空',
      });
      return;
    }
    if (this.data.store.ApplicationName == null || this.data.store.ApplicationName == "") {
      wx.showToast({
        title: '店铺名称不能为空',
      });
      return;
    }
    wx.showLoading({
      title: '提交申请中...',
    });
    app.getUserInfo((userInfo)=>{
      this.data.userInfo = userInfo;
      webapi.AddNewStoreApplication({ WechatPaymentQRCode: this.data.store.WechatPaymentQRCode, ApplicationAvatar: '', ApplicationName: this.data.store.ApplicationName, Description: '', Email: this.data.store.Email, FullName: this.data.store.Name, PhoneNumber: this.data.store.PhoneNumber, Status: 0, WechatName: this.data.userInfo.nickName, WechatQRCode: '' }).then((res) => {
        wx.hideLoading();
        if (res.Success) {
          wx.showModal({
            title: '提交成功',
            content: '您的申请已经成功提交，正在审理中，如果审核通过，您将收到邮件通知请扫码登录！',
            showCancel:false,
            success(res){
              wx.navigateBack({
              });
            },
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
        wx.hideLoading();
      });
    });
    
  },
})