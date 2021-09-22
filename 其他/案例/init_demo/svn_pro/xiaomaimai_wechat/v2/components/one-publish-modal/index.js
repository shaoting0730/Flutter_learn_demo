import Util from "../../utils/util.js";

const computedBehavior = require('miniprogram-computed')

const app = getApp();
function getProfit(aPrice, cPrice) {
  return cPrice > 0 ? `¥ ${cPrice - aPrice}` : '待议';
}


Component({
  behaviors: [computedBehavior],
  properties: {
    show: {
      type: Boolean,
      value: false
    },
    product: {
      type: Object,
      value: {},
      observer: 'getPrice',
    },
    publishSuccess: {
      type: Boolean,
      value: false
    }
  },

  data: {
    productPrice: 0,
    price: 0,
    minPrice: 0,
    maxPrice: 0,
    radio: '1',
    productName: ''
  },
  computed: {
    profit(data) {
      const { price, minPrice, maxPrice, radio, productPrice } = data;
      if (radio === '1') {
        return getProfit(productPrice, price);
      } else {
        const min = getProfit(productPrice, minPrice);
        const max = getProfit(productPrice, maxPrice);
        return `${min} ~ ${max}`;
      }
    },
  },
  lifetimes: {
    attached: function () {
      // 在组件实例进入页面节点树时执行
      this.setData({
        AllowOnlySinglePrice: app.globalData.storeInfo.StoreType < 10,
      });
    },
  },
  methods: {
    getPrice(n) {
      this.setData({
        productPrice: n.VendorPrice || 0,
        price: n.MyPrice || n.VendorPrice || 0,
        minPrice: n.MyMinPrice || 0,
        maxPrice: n.MyMaxPrice || 0,
        radio: n.MyPrice === 0 && (n.MyMinPrice > 0 || n.MyMaxPrice > 0) ? '2' : '1',
        productName: n.MyDescription ? n.MyDescription : (n.ProductName ? n.ProductName : ''),
      })
    },
    onChange(e) {
      this.setData({
        radio: e.detail
      })
    },
    onClose(e) {
      this.triggerEvent('onClose');
    },
    onPublish(e) {

      this.triggerEvent('onPublish', e.detail)
    },
    onRangePrice(e) {
      const { name } = e.currentTarget.dataset
      const { value } = e.detail;
      let v = this.data[name];
      if (Util.isNumber(value)) {
        v = value
      }
      this.setData({ [name]: v })
    },
  }
})
