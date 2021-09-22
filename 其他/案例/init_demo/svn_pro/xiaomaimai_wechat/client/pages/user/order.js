//获取应用实例
var app = getApp();
var webapi = require('../../utils/webapi');
const util = require('../../utils/util');
Page({
    data: {
        tabData: {
          list: [{
            id: -1,
            title: '全部'
          },  {
                id: 1,
                title: '等候付款'
              }, {
                id: 2,
                title: '已支付'
              }, {
                id: 3,
                title: '打包中'
            }, {
              id: 4,
              title: '已发货'
            }],
            scroll: false,
            height: '90rpx'
        },
        currentTab: -1,
        seller: false,
        shareGuid:'',
    },
  initPage: function (options){
      this.setData({
        userInfo: app.globalData.userInfo,
      });
      var currentTab = options.currentTab === undefined ? -1 : options.currentTab;
      if (currentTab=='0')
        currentTab = '-1';
      this.setData({
          currentTab: parseInt(currentTab),
          seller: app.globalData.seller,
        });
      if (options.ShareGuid)
        this.setData({ shareGuid: options.ShareGuid })
      this.loadCurrentTabBody();
    },
    onLoad: function (options) {
      var self = this;
      self.setData({
        needAuthor: app.globalData.storeName == null,
      });
      if (app.globalData.storeName == null || app.globalData.storeGuid == null)
      {
        app.globalData.storeName = options.storeName;
        app.globalData.storeGuid = options.storeGuid;
        wx.getSetting({
          success: (res) => {
            if (res.authSetting['scope.userInfo']) {
              self.setData({
                needAuthor: false,
              });
              // 已经授权，可以直接调用 getUserInfo 获取头像昵称
              app.getUserInfo((userInfo) => {
                console.log(userInfo, "---->userInfo");
                self.initPage(options);
              });
            } else {
              self.setData({
                needAuthor: true,
              });
            }
          }
        });
      }
      else
      {
        self.initPage(options);
      }

    },
    getCurrentTabBody:function(){
        const {currentTab} = this.data;
        let currTabBody = this.selectComponent('#order-tab-body-'+this.getOrderStatus());
        return currTabBody;
    },
    loadCurrentTabBody:function(){
        console.log("--->loadCurrentTabBody");
        let currTabBody = this.getCurrentTabBody();
        if(currTabBody){
          currTabBody.loadTabData(this.data.shareGuid);
        }
    },
    onReachBottom:function(){
        console.log("----->onReachBottom");
        this.loadCurrentTabBody();
    },
    getOrderStatus: function () {
        switch (this.data.currentTab) {
            case -1:
                return 'All';
            case 0:
                return 'Unpaid';
            case 1:
              return 'Unpaid';
              //return 'WaitAction';
            case 2:
                return 'ReadyForShip';
            case 3:
                return 'Packing';
            case 4:
              return 'Shipped';
            default:
                return 'Unpaid';
        }
    },
    onTabChange: function (e) {
        console.log("onTabChange--->", e)
        const currentTabIndex = e.detail;

        this.setData({
            currentTab: currentTabIndex,
        }, () => {
            this.loadCurrentTabBody();
        });
    },
    onShareAppMessage: function () {
      let currTabBody = this.getCurrentTabBody();
      currTabBody.setData({ showModal:false});
      var subject = app.globalData.storeInfo.StoreName + ' 又有新的订单';
      if (!currTabBody.data.displayPrice)
        subject = app.globalData.storeInfo.StoreName + ' 又有下家发来新的发货订单';
      else if (currTabBody.data.totalPayment>0)
        subject = app.globalData.storeInfo.StoreName + ' 又有价值￥' + currTabBody.data.totalPayment+'的新订单';
      return util.shareOrders(subject, currTabBody.data.shareImageUrl, currTabBody.data.shareGuid);
    },
})
