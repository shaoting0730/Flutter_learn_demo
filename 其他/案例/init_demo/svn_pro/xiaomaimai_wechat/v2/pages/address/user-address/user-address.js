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
    addressValue: '',
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onPullDownRefresh: function () {
    wx.showNavigationBarLoading()
    this.DataonLoad().then(() => {
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
    })
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
    var addressGuid = e.detail;
    const address = this.data.address.find(item => item.Guid === addressGuid);
    if (address) {
      address.AddressType = 2;
      webapi.updateStoreCustomerAddress(address).then(() => {
        this.setData({
          addressValue: addressGuid
        })
      })
    }
    // webapi.setDefaultAddress(addressGuid).then(() => {

    // });
  },
  findAddress: function (addressGuid) {
    let result = null;
    for (let index in this.data.address) {
      if (this.data.address[index].Guid === addressGuid) {
        result = this.data.address[index]
        break;
      }
    }
    return result;
  },
  selectAddress: function (e) {
    var item = e.currentTarget.dataset.item;

    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('chooseAddress', item)
    wx.navigateBack({
      delta: 1
    });
  },
  delAddress: function (e) {
    var addressGuid = e.currentTarget.dataset.guid;
    wx.showModal({
      title: '提示',
      content: '你确认移除吗',
      success: (res) => {
        res.confirm && webapi.deleteStoreCustomerAddress(addressGuid).then((res) => {
          if (res.Success) {
            this.setData({
              address: this.data.address.filter(item => item.Guid !== addressGuid)
            })
          }
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
  gotoNewAddress(e) {
    const address = e.currentTarget.dataset.address;
    wx.navigateTo({
      url: '/pages/address/new-address/address',
      events: {
        getAddress: (callback) => {
          callback(address)
        },
        onLoadAddress: (address) => {
          if (address.Guid === '') {
            this.DataonLoad();
          } else {
            var addressList = this.data.address;
            addressList.forEach((item, i) => {
              if (item.Guid === address.Guid) {
                addressList[i] = address
                return false
              }
            })
            this.setData({
              address: addressList,
              addressValue: address.AddressType === 2 ? address.Guid : this.data.addressValue
            })
          }
        }
      }
    });
  },
  DataonLoad: function () {
    var addressSearch = {
      StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
      PageIndex: 0,
      PageSize: 100
    };
    wx.showLoading({
      title: '正在加载中',
    })
    return webapi.searchStoreCustomerAddress(addressSearch).then((res) => {
      const addressValue = (res.Data.ListObjects.find(item => item.AddressType === 2) || {}).Guid;
      this.setData({
        address: res.Data.ListObjects,
        addressValue: addressValue || '',
        loading: false,
      });
      wx.hideLoading()
    });
  },
})

