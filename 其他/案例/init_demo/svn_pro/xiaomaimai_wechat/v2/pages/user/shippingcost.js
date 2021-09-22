import Util from "../../utils/util.js";

var app = getApp();
var webapi = require('../../utils/webapi');

Page({
  data: {
    shippingCost: 0,
  },
  onShow: function () {
    this.setData({
      cost: app.globalData.shippingCost,
      shippingCost: app.globalData.shippingCost
    });
  },
  onInputCost({ detail }) {
    const { value } = detail
    let cost = this.data;
    if (Util.isNumber(value) || value === '') {
      cost = value
    }
    this.setData({ cost });
  },
  onSave() {
    const { cost } = this.data;
    webapi.SetBasicShippingFee(cost).then((res) => {
      if (res.Success) {
        app.globalData.shippingCost = cost;
      }
      wx.navigateBack({});
    });
  },
})
