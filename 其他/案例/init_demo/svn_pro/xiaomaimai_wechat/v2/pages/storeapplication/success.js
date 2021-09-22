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
    store: {},
    userInfo: {},
    progress: {
      percent: 0,
      show: false
    },
    step: 1,
    status: '',
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({ status: options.status });
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
      count: 1,
      success: res => {
        const tmpFileList = res.tempFilePaths;
        const progress = {}
        Promise.all(tmpFileList.map((fullPath, index) => {
          return cloudApi.webapiUploadFiles(fullPath, null, (res) => {
            progress[index] = res.progress;
            this.setData({
              progress: {
                percent: (Object.values(progress).reduce((a, b) => a + b) / tmpFileList.length).toFixed(2),
                show: true
              }
            });
          });
        })).then(result => {
          result.forEach((data, index) => {
            const fileName = Object.keys(data.Data)[0];
            if (Request.getToken() == "") {
              appStore.WechatPaymentQRCode = config.serverFileRoot + "Default/" + fileName;
            } else {
              appStore.WechatPaymentQRCode = data.Data[fileName];
            }
          })
          this.setData({
            store: appStore,
            progress: { percent: 0, show: false }
          });
        })
      }
    });
  },

  formSubmit: function (e) {
    var adds = e.detail.value;
    if (this.data.step === 1) {
      this.data.store.Name = adds.name;
      this.data.store.PhoneNumber = adds.phone;
      this.data.store.Email = adds.email;
      this.data.store.IDCardNumber = adds.idcardnumber;
    }
    this.data.store.ApplicationName = adds.applicationname;
    this.data.store.WechatId = adds.wechatid;
    this.data.store.VendorRefCode = adds.VendorRefCode;
    if (!this.data.store.Name) {
      wx.showToast({
        title: '姓名不能为空',
        icon: "none"
      });
      return;
    }
    if (!this.data.store.PhoneNumber) {
      wx.showToast({
        title: '联系电话不能为空',
        icon: "none"
      });
      return;
    }
    // if (!this.data.store.IDCardNumber) {
    //   wx.showToast({
    //     title: '身份证号不能为空',
    //     icon: "none"
    //   });
    //   return;
    // }

    if (this.data.step === 1) {
      this.setData({ step: 2 });
      return;
    }

    // if (!this.data.store.Email) {
    //     wx.showToast({
    //         title: '联系邮箱不能为空',
    //         icon: "none"
    //     });
    //     return;
    // }
    if (!this.data.store.ApplicationName) {
      wx.showToast({
        title: '店铺名称不能为空',
        icon: "none"
      });
      return;
    }

    if (!this.data.store.WechatId) {
      wx.showToast({
        title: '微信号不能为空',
        icon: "none"
      });
      return;
    }

    if (!this.data.store.WechatPaymentQRCode) {
      wx.showToast({
        title: '收款码不能为空',
        icon: "none"
      });
      return;
    }

    app.getUserInfo({
      success: (userInfo) => {
        this.data.userInfo = userInfo;
        webapi.AddNewStoreApplication({
          WechatPaymentQRCode: this.data.store.WechatPaymentQRCode,
          ApplicationAvatar: '',
          ApplicationName: this.data.store.ApplicationName,
          Description: '',
          Email: this.data.store.Email,
          FullName: this.data.store.Name,
          WechatId: this.data.store.WechatId,
          PhoneNumber: this.data.store.PhoneNumber,
          IDCardNumber: this.data.store.IDCardNumber,
          VendorRefCode: this.data.store.VendorRefCode,
          Status: 0,
          WechatName: this.data.userInfo.nickName,
          WechatQRCode: ''
        }).then((res) => {
          if (res.Success) {
            wx.showModal({
              title: '提交成功',
              content: '您的申请已经成功提交，正在审理中，如果审核通过，您将收到邮件通知请扫码登录！',
              showCancel: false,
              success(res) {
                wx.navigateBack({});
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
          app.hideLoading();
        });
      }
    });
  },
})
