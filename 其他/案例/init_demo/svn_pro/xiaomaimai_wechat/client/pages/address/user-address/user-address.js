// pages/address/user-address/user-address.js
var app = getApp()
var webapi = require('../../../utils/webapi');
Page({
    data: {
        address: [],
        allowSelect: false,
        requestPage: '',
        remark: '',
        couponguid: '',
        productData: [],
    },
  onShow: function (options) {
    this.DataonLoad();
  },
    onLoad: function (options) {
        if (options.allowSelect) {
            this.setData({
                allowSelect: options.allowSelect
            });
        }
        this.DataonLoad();
    },
    onReady: function () {
        // 页面渲染完成
    },
    setDefault: function (e) {
        var addressGuid = e.currentTarget.dataset.guid;
        webapi.setDefaultAddress(addressGuid).then(() => {
            console.log("---->setDefaultAddress")
            this.DataonLoad();
        });
    },
    findAddress:function(addressGuid){
        let result = null;
        for (let index in this.data.address) {
            if (this.data.address[index].Guid == addressGuid) {
                result = this.data.address[index]
                break;
            }
        }
        return result;
    },
    selectAddress: function (e) {
        var addressGuid = e.currentTarget.dataset.guid;
        let address = this.findAddress(addressGuid);
        if (address) {
            wx.setStorage({
                key: "address",
                data: address
            });
        }
        wx.navigateBack({
            delta: 1
        });
    },
    editAddress: function (e) {
        var addressGuid = e.currentTarget.dataset.guid;
        let address = this.findAddress(addressGuid);
        if(address){
            wx.navigateTo({url:`/pages/address/new-address/address?address=${JSON.stringify(address)}`});
        }
    },
    delAddress: function (e) {
        var addressGuid = e.currentTarget.dataset.guid;
        wx.showModal({
            title: '提示',
            content: '你确认移除吗',
            success: (res) => {
                res.confirm && webapi.deleteStoreCustomerAddress(addressGuid).then(() => {
                    this.DataonLoad();
                });
            },
            fail: () => {
                // fail
                wx.showToast({
                    title: '网络异常！',
                    duration: 2000
                });
            }
        });
    },
    DataonLoad: function () {
        var addressSearch = {
            StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
            PageIndex: 0,
            PageSize: 100
        };
        this.setData({
            loading:true,
        });
        webapi.searchStoreCustomerAddress(addressSearch).then((res) => {
            this.setData({
                address: res.Data.ListObjects,
                loading:false,
            });
        });
    },
})
