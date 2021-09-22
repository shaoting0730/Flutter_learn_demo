const computedBehavior = require('miniprogram-computed')

const app = getApp();
Component({
  behaviors: [computedBehavior],
  properties: {
    badge: {
      type: String,
      value: "",
    },
    active: {
      type: String,
      value: "home",
      observer: 'upActive'
    },
    seller: {
      type: Boolean,
      value: false,
    },
    cartList: {
      type: Array,
      value: [],
      observer: "watchCartList"
    },
    status: {
      type: String
    },
    showCartBar: {
      type: Boolean,
      value: false,
    }
  },
  data: {
    safeAreaBottom: app.getSafeAreaBottom(),
    active: 1,
    cartCount: 0,
    isRangePrice: 0,
    total: 0,
  },
  methods: {
    upActive(n) {
      this.setData({
        active: n
      });
    },
    watchCartList(cartList) {
      let count = 0;
      let total = 0;
      let isRangePrice = false;
      cartList.forEach(cart => {
        if (cart.StockQuantity <= 0) return;
        if (!isRangePrice) {
          isRangePrice = cart.ProductPrice === 0 || (cart.ProductMinPrice > 0 || cart.ProductMaxPrice > 0)
        }
        total += parseInt(cart.Quantity) * parseFloat(cart.ProductOnSalePrice)
        count += cart.Quantity
      });
      this.setData({
        cartCount: count === 0 ? '' : count,
        total: total.toFixed(2),
        isRangePrice,
      })

    },
    onChange(event) {
      switch (event.detail) {
        case 'home':
          this.setData({
            active: event.detail
          });
          app.currentPage().gotoShopping();
          break;
        case 'products':
          this.setData({
            active: event.detail
          });
          app.currentPage().gotoProducts();
          break;
        case 'messages':
          this.setData({
            active: event.detail
          });
          app.currentPage().gotoMessages();
          break;
        case 'cart':
          this.setData({
            active: event.detail
          });
          app.currentPage().gotoCart();
          break;
        case 'aboutme':
          this.setData({
            active: event.detail
          });
          app.currentPage().gotoAboutMe();
          break;
      }
    },
    onPay() {
      const { cartList } = this.properties;
      const products = cartList.filter(item => item.StockQuantity > 0).map(item => {
        return {
          ProductCode: item.ProductCode,
          Quantity: item.Quantity
        }
      });
      if (products.length == 0) {
        wx.showToast({
          title: '请选择要结算的商品！',
          duration: 2000
        });
        return false;
      }
      wx.navigateTo({
        url: '/pages/order/pay',
        events: {
          getData: (callback) => {
            callback({products})
          },
        }
      });

    },
  }
})
