


import util from "../../../utils/util";
import webapi from '../../../utils/webapi';
Page({
  data: {
    orderType: 0,
  },
  onLoad(options) {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('getData', ({ address, orderType }) => {
      let navTitle = '';
      switch (orderType) {
        case 1:
          navTitle = '填写收件人身份信息'
          break;
        case 2:
          navTitle = '填写支付人身份信息'
          break;
        case 3:
          navTitle = '填写收件人和支付人身份信息'
          break;
      }

      this.setData({
        navTitle,
        orderType,
        address,
        ShipName: address.FullName
      });
    });
  },
  validate(data) {
    const { orderType } = this.data;
    const errors = {}
    let inValid = false

    if ((orderType & 1) === 1) {
      if (!(data.ShipCrad || '').trim()) {
        errors.ShipCrad = '请输入收件人身份证号'
        inValid = true;
      } else if (!util.isCardId(data.ShipCrad)) {
        errors.ShipCrad = '请输入正确的身份证号'
        inValid = true;
      }
    }
    if ((orderType & 2) === 2) {
      if (!(data.BuyerName || '').trim()) {
        errors.BuyerName = '请填写支付人真实姓名'
        inValid = true;
      }
      if (!(data.BuyerIdCard || '').trim()) {
        errors.BuyerIdCard = '请输入支付人身份证号'
        inValid = true;
      } else if (!util.isCardId(data.BuyerIdCard)) {
        errors.BuyerIdCard = '请输入正确的身份证号'
        inValid = true;
      }
    }
    if (inValid) {
      this.setData({
        errors
      })
    }
    return inValid
  },
  formSubmit({ detail }) {
    const eventChannel = this.getOpenerEventChannel()
    const { address, orderType } = this.data;
    const { value } = detail;
    address.IDCardNumber = !!(value.ShipCrad || '').trim() ? value.ShipCrad : address.IDCardNumber
    if (!this.validate(value)) {
      if ((orderType & 2) === 2) {
        webapi.UpdateBuyerInfo({
          BuyerName: value.BuyerName,
          BuyerIdCard: value.BuyerIdCard
        })
      }
      if ((orderType & 1) === 1) {
        webapi.updateStoreCustomerAddress(address)
      }

      eventChannel.emit('onComplete', {
        address,
        buyerInfo: {
          BuyerName: value.BuyerName,
          BuyerIdCard: value.BuyerIdCard
        }
      })
      wx.navigateBack({
        delta: 1
      });
    }
  },

  onClickEdit() {
    const { address } = this.data;
    wx.navigateTo({
      url: '/pages/address/new-address/address',
      events: {
        getAddress: (callback) => {
          callback(address)
        },
        onLoadAddress: (address) => {
          this.setData({
            address,
            ShipName: address.FullName
          })
        }
      }
    });
  }

});
