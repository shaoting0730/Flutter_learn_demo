//获取应用实例
var app = getApp();
var webapi = require('../../utils/webapi');
Page({
    data: {
        needAuthor: true,
        tabData: {
            list: [{
                id: -1,
                title: '全部'
            }, {
                id: 0,
                title: '未支付'
            }, {
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
        currentTab: 0,
        seller: false,
        shareGuid: '',
    },
    btnBackToHome: function () {
        this.setData({shareGuid: ''});
        wx.redirectTo({
            url: '/pages/home/index',
        });
    },
    initPage: function (options) {
        this.setData({
            userInfo: app.globalData.userInfo,
        });
        const currentTab = -1;
        this.setData({
            currentTab: parseInt(currentTab),
            seller: app.globalData.seller,
        });
        if (options.ShareGuid)
            this.setData({shareGuid: options.ShareGuid})
        this.loadCurrentTabBody();
    },
    onLoad: function (options) {
        console.log(options);
        console.log(app.globalData);
        var self = this;
        if (app.globalData.storeHost != options.storeHost || app.globalData.storeGuid != options.storeGuid) {
            app.globalData.storeHost = options.storeHost;
            app.globalData.storeGuid = options.storeGuid;
            app.globalData.userInfo = null;
            app.globalData.apiLoginInfo = null;
            app.globalData.storeInfo = null;
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
        } else {
            self.setData({
                needAuthor: false,
            });
            self.initPage(options);
        }
    },
    getCurrentTabBody: function () {
        const {currentTab} = this.data;
        let currTabBody = this.selectComponent('#order-tab-body-' + this.getOrderStatus());
        return currTabBody;
    },
    loadCurrentTabBody: function () {
        console.log("--->loadCurrentTabBody");
        let currTabBody = this.getCurrentTabBody();
        if (currTabBody) {
            currTabBody.loadTabData(this.data.shareGuid);
        }
    },
    onReachBottom: function () {
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
            ///return 'WaitAction';
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
})
