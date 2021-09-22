import Util from '../../utils/util';

var app = getApp();
var webapi = require('../../utils/webapi');

Component({
  properties: {
    storeInfo: {
      type: Object,
      value: {},
      observer: 'onUpStoreInfo'
    },
  },
  data: {
    page: 1,
    total: '0.00',
    carts: [],
    showLoading: false,
    productMin: 0,
    productMax: 99,
    showChooseShipmentWay: false,
    totalQuantity: 0,
    tabContentHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight - 60 - 44,
    footerBottom: 50 + app.getSafeAreaBottom(),
    isRangePrice: false,
    showNoticeBar: true,
    noticeText: '',

  },
  ready() {
    this.refresher = this.selectComponent("#refresher");
    this.refresher.setParent(this);


  },


  methods: {
    onLoad(options) {
      this.refresher.triggerRefresh();
    },
    copyOwnerWechatId() {
      Util.setClipboard(this.properties.storeInfo.OwnerWechatId, "店主微信已复制");
    },
    onCloneNoticeBar() {
      this.setData({
        showNoticeBar: false,
        tabContentHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight - 60 - 44,
      })
    },
    onUpStoreInfo: function (n, o) {
      if (n.OwnerGuid !== o.OwnerGuid) {
        this.setData({
          showNoticeBar: true,
          noticeText: `点击复制店主微信号：${n.OwnerWechatId}，添加店主好友，以便提交订单后线下付款及售后服务`,
          showNoticeBar: !n.WechatMPPayEnabled,
          tabContentHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight - 60 - 44 - (n.WechatMPPayEnabled ? 0 : 64),
        });
      }
    },
    onRemoveCart: function (event) {
      const carts = this.data.carts;
      let selectedProduct = [];
      carts.forEach(p => {
        if (p.selected)
          selectedProduct.push(p.ProductCode);
      });
      if (selectedProduct.length <= 0)
        wx.showToast({
          title: '请先勾选要删除的商品',
        });
      else {
        const self = this;
        wx.showModal({
          title: '提示',
          content: '确定从购物车删除选中的商品吗？',
          success(res) {
            if (res.confirm) {
              let promiseList = [];
              selectedProduct.forEach(p => {
                promiseList.push(webapi.updateShoppingCart(p, 0));
              });
              Promise.all(promiseList).then(function (values) {
                console.log(values);
                self.onLoad();
              });
            } else if (res.cancel) {
              console.log('用户点击取消')
            }
          }
        });
      }
    },
    bindScanProductQRCode: function () {
      Util.scanProductQRCode();
    },
    bindStepperChange: function (e) {
      const { productcode, stockquantity, item } = e.currentTarget.dataset;
      const num = e.detail;
      if (Number.isInteger(num)) {
        if (num === 0) {
          wx.showModal({
            title: '提示',
            content: '你确认移除吗',
            success: (res) => {
              if (res.confirm) {
                this._upCartQuantity(productcode, num)
              } else {
                this.setData({
                  carts: this.data.carts
                })
              }
            },
            fail: function () {
              wx.showToast({
                title: '网络异常！',
                duration: 2000
              });
            }
          });
        } else if (item.LimitPerPerson !== 0 && item.LimitPerPerson < num) {
          wx.showToast({
            title: `该商品每人限购${item.LimitPerPerson}件`,
            duration: 2000
          });
        } else if (num > stockquantity) {
          //this._upCartQuantity(productcode, stockquantity)
        } else {
          this._upCartQuantity(productcode, num)
        }
      }
    },
    _upCartQuantity(productCode, num) {
      const cloneCart = [...this.data.carts];
      let newCarts;
      if (num === 0) {
        newCarts = this.data.carts.filter(item => item.ProductCode !== productCode)
        this.setData({
          carts: newCarts
        })
      } else {
        this.data.carts.find(item => item.ProductCode === productCode).Quantity = num
        newCarts = [...this.data.carts]
      }
      app.getHomePage().setData({
        shoppingCart: newCarts
      })
      this.calcSumPrice();
      webapi.updateShoppingCart(productCode, num)
        .then((res) => {
          if (!res.Success) {
            this.setData({
              carts: newCarts
            })
            app.getHomePage().setData({
              shoppingCart: cloneCart
            })
            this.calcSumPrice();
            wx.showToast({
              title: '添加失败',
              icon: 'none'
            });
          }
        });
    },
    bindItemCheckbox: function (e) {
      console.log("----->bindItemCheckbox", e);
      const checked = e.detail;
      const index = e.currentTarget.dataset.index;
      console.log("bindItemCheckbox", checked, index);

      this.setCartChecked(index, checked);

      this.updateAllCartsChecked();
      this.calcSumPrice();
    },
    setCartChecked(index, isChecked) {
      var carts = this.data.carts;
      carts[index].selected = isChecked;
      this.setData({
        carts: carts
      });
    },
    setAllCartsChecked(isAllChecked) {
      let carts = this.data.carts;
      console.log(carts, "====>carts")
      for (let i = 0; i < carts.length; i++) {
        //if (carts[i].StockQuantity > 0) {
        carts[i].selected = isAllChecked;
        // }
        // else {
        //   carts[i].selected = false;
        // }
      }
      this.setData({
        carts: carts,
        selectedAllStatus: isAllChecked,
      });
    },
    updateAllCartsChecked: function () {
      let selectedAllStatus = true;

      let carts = this.data.carts;
      for (var i = 0; i < carts.length; i++) {
        if (carts[i].StockQuantity > 0)
          if (!carts[i].selected) {
            selectedAllStatus = false;
            break;
          }
      }
      this.setData({
        selectedAllStatus: selectedAllStatus,
      });
    },
    bindToggleSelectAll: function (e) {
      const selectedAllStatus = e.detail;
      this.setAllCartsChecked(selectedAllStatus);
      this.updateAllCartsChecked();
      this.calcSumPrice();
    },
    bindSelectAll: function () {
      // 环境中目前已选状态
      var selectedAllStatus = this.data.selectedAllStatus;
      // 取反操作
      selectedAllStatus = !selectedAllStatus;
      // 购物车数据，关键是处理selected值
      var carts = this.data.carts;
      // 遍历
      for (var i = 0; i < carts.length; i++) {
        carts[i].selected = selectedAllStatus;
      }
      this.setData({
        selectedAllStatus: selectedAllStatus,
        carts: carts
      });
      this.calcSumPrice();
    },

    bindCheckout() {
      const products = this.getSelectedProducts();
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
            callback({ products })
          },
        }
      });
    },
    bindToastChange() {
      this.setData({
        toastHidden: true
      });
    },
    calcSumPrice: function () {
      var carts = this.data.carts;
      // 计算总金额
      var total = 0;
      let totalQuantity = 0;
      var isRangePrice = false;
      carts.forEach(item => {
        if (item.selected) {
          if (!isRangePrice) {
            isRangePrice = item.ProductPrice === 0 || (item.ProductMinPrice > 0 || item.ProductMaxPrice > 0)
          }
          total += parseInt(item.Quantity) * parseFloat(item.ProductOnSalePrice)
          totalQuantity += item.Quantity;
        }
      })
      this.setData({
        carts: carts,
        total: total.toFixed(2),
        totalQuantity: totalQuantity,
        isRangePrice: isRangePrice
      });
    },
    getSelectedProducts() {
      const { carts } = this.data;
      return carts.filter(item => item.selected).map(item => {
        return {
          ProductCode: item.ProductCode,
          Quantity: item.Quantity
        }
      })
    },
    removeShopCard: function (e) {
      var that = this;
      wx.showModal({
        title: '提示',
        content: '你确认移除吗',
        success: function (res) {
          res.confirm && webapi.UpdateShoppingCart(e.currentTarget.dataset.productcode, 0, function () {
            //更新数据
            that.loadProductData();
          });
        },
        fail: function () {
          // fail
          wx.showToast({
            title: '网络异常！',
            duration: 2000
          });
        }
      });
    },
    setShowLoading: function (isShow) {
      this.setData({
        showLoading: isShow,
      });
    },
    //数据案例
    loadProductData: function (isShowLoading) {

      if (isShowLoading) {
        this.setShowLoading(true);
      }
      return webapi.loadShoppingCart().then(res => {
        console.log(res, "---->loadProductData");
        //更新数据
        var productList = res.Data;
        app.getHomePage().setData({
          shoppingCart: productList
        })
        this.setData({
          carts: productList,
          showLoading: false,
        });
        this.calcSumPrice();
        this.updateAllCartsChecked();
      }).catch(() => {
        this.setShowLoading(false);
      });
    },
    onRefresh() {
      this.loadProductData(true).then(data => {
        this.refresher.finishPullToRefresh();
        this.refresher.finishLoadmore(true);
      });
    },
    refresherScroll({ detail }) {
      this.setData({
        scrollTop: detail.scrollTop
      });
    },
  },


});
