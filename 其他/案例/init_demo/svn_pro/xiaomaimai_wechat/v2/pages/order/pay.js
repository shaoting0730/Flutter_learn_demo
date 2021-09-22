import Request from "../../utils/request";
import Config from '../../utils/config.js'
import webapi from '../../utils/webapi';
import util from '../../utils/util';

import Dialog from '@vant/weapp/dialog/dialog';

const app = getApp();

Page({
  data: {
    paymentmethod: 6, //2=alipay; 6=wechat;
    remark: '',
    btnDisabled: false,
    productData: [],
    address: {},
    checkAddress: "1",
    orderPrice: {
      TotalPrice: 0,
      ShippingFee: 0,
      SubTotal: 0
    },
    discountPrice: 0,
    couponguid: '',
    validcoupons: [],
    loadingPrice: true,
    totalQuantity: 0,
    collapse: false,
    totalPrice: 0,
    shippingCost: 0,
    qrCodeimageUrl: '',
    shareImageUrl: '',
    sharedGuid: '',
    isShowChoose: true,
    storeGuid: Config.StoreGuid,
    showModal: false,
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight - 124,
    safeAreaBottom: app.getSafeAreaBottom(),
    WechatMPPayEnabled: false,
    buyerInfo: {}
  },
  onLoad(options) {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('getData', ({ products, delta = 1 }) => {
      this.setData({
        delta,
        loadingPrice: true,
        WechatMPPayEnabled: app.globalData.storeInfo.WechatMPPayEnabled,
        buyerInfo: app.globalData.buyerInfo
      });
      this._getDefaultAddress();

      webapi.calculateOrderPrice(products)
        .then((res) => {
          const { scrollHeight } = this.data;
          const orderPrice = res.Data;
          const isShowChoose = orderPrice.Orders.findIndex(order => order.RequireShipToIdCard || order.RequireBuyerIdCard) === -1;
          this.setData({
            orderPrice: orderPrice,
            isShowChoose,
            scrollHeight: isShowChoose ? scrollHeight : scrollHeight + 40,
            loadingPrice: false,
          });
        }).catch(() => {
          app.hideLoading();
          this.setData({
            loadingPrice: false,
          });
        });
    });
  },
  _getDefaultAddress() {
    var addressSearch = {
      StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
      AddressType: 2,
      PageIndex: 0,
      PageSize: 1
    };
    webapi.searchStoreCustomerAddress(addressSearch).then((res) => {
      this.setData({
        address: res.Data.ListObjects[0] || {},
      });
    });
  },
  remarkInput: function (e) {
    this.setData({
      remark: e.detail.value,
    })
  },
  getvou: function (e) {
    var couponguid = e.currentTarget.dataset.couponguid;
    var price = e.currentTarget.dataset.price;
    this.setData({
      discountPrice: parseFloat(price),
      couponguid: couponguid
    })
  },
  btnPaymentDone: function () {
    this.setData({
      showModal: false
    });
    wx.redirectTo({
      url: '/pages/user/order?currentTab=1',
    });
  },
  //微信支付
  createProductOrderByWX(event) {
    this.setData({
      paymentmethod: 6,
    });
    let formId = event.detail.formId;
    this.createProductOrder(formId);
  },
  checkOrderExtra() {
    const { orderPrice, address, buyerInfo } = this.data;
    let orderType = 0;
    orderPrice.Orders.forEach(order => {
      const { OrderInfo } = order;
      orderType = orderType | (OrderInfo.RequireShipToIdCard && !!!address.IDCardNumber.length ? 1 : 0);
      orderType = orderType | (OrderInfo.RequireBuyerIdCard && !!!buyerInfo.BuyerIdCard && !!!buyerInfo.BuyerName ? 2 : 0);
    })

    if (orderType > 0) {
      let message = '';
      switch (orderType) {
        case 1:
          message = '直邮商品需要提供收件人身份证号码'
          break;
        case 2:
          message = '保税商品需要提供支付人姓名及身份证号码'
          break;
        case 3:
          message = '您的订单包含直邮和保税商品需要提供支付人姓名及身份证号码'
          break;
      }
      Dialog.confirm({
        customStyle: 'border-radius: 16px !important',
        title: '重要提醒',
        confirmButtonText: '立即填写',
        cancelButtonText: '暂不',
        message
      }).then(() => {
        wx.navigateTo({
          url: '/pages/order/extra-info/index',
          events: {
            getData(callback) {
              callback({ address, orderType })
            },
            onComplete: ({ address, buyerInfo }) => {
              this.setData({
                address,
                buyerInfo
              })
            }
          }
        })
      }).catch(() => {
        Dialog.close();
      });;
      return true;
    } else {
      return false;
    }
  },

  //确认订单
  createProductOrder(formId) {
    this.setData({
      btnDisabled: false,
    });
    const homePage = app.getHomePage();
    const { orderPrice, address, checkAddress, remark, discountPrice } = this.data;
    const orderItems = [];

    let allFixedPrice = true;
    let usedcouponcode = '';

    if (checkAddress === '1' && (!address || !address.AddressLine || address.AddressLine.length <= 0)) {
      wx.showToast({
        title: '请选择收货地址',
      });
      return;
    }
    if (this.checkOrderExtra()) {
      return;
    }
    orderPrice.Orders.forEach(order => {
      order.OrderItems.forEach(item => {
        if (item.ProductOnSalePrice === 0) {
          allFixedPrice = false;
        }
        orderItems.push(item);
      })
    })
    const orderInfo = {
      OrderType: 'Product',
      StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
      ShipToAreaCode: '',
      OrderCouponCode: usedcouponcode,
      OrderShipping: 0,
      OrderTotal: orderPrice.TotalPrice,
      OrderReceivable: orderPrice.TotalPrice - discountPrice,
      Notes: remark,
    }
    if (checkAddress === '1') {
      orderInfo.ShipToName = address.FullName;
      orderInfo.ShipToAddress = address.AddressLine;
      orderInfo.ShipToCity = address.City;
      orderInfo.ShipToTown = address.Town;
      orderInfo.ShipToProvince = address.Province;
      orderInfo.ShipToPostalCode = address.PostCode;
      orderInfo.ShipToCountry = address.Country;
      orderInfo.ShipToIDCardType = address.IDCardType;
      orderInfo.ShipToIDCardNumber = address.IDCardNumber;
      orderInfo.ShipToEmail = address.Email;
      orderInfo.ShipToPhone = address.PhoneNumber;
    }
    var postData = {
      orderInfo,
      orderItems,
      storeCustomerKey: '',
      merchantGuid: '',
      paymentSignMD5Key: formId,
      tradeType: 'JSAPI'
    };
    webapi.placeOrder(postData)
      .then((res) => {
        if (res.Success) {
          if (!allFixedPrice) { // || app.globalData.storeInfo.PaymentQRCodeUrl.length<=0)
            wx.showModal({
              title: '下单成功',
              content: '您的订单已经生成，由于您的商品中含有未确定价格商品，请在‘等候付款’页面勾选订单，分享给卖家微信聊天，沟通最终价格并付款',
              showCancel: false,
              success: function (res) {
                wx.redirectTo({
                  url: `/pages/user/order`,
                });
              }
            });
          } else {
            this.setData({
              orderInfos: res.Data,
              isScan: !!res.Data.find(item => item.OrderPrice),
              showModal: true,
            });
          }
          homePage.selectComponent("#cart").onLoad();
        } else {
          app.showToast({
            title: res.Message,
            icon: "none",
            duration: 6000,
          });
        }
      }).catch((err) => {
        app.hideLoading();
        console.log(err);
        wx.showToast({
          title: "生成订单失败",
          icon: "none",
        });
      });
  },
  onCollapse: function () {
    this.setData({
      collapse: !this.data.collapse
    });
  },
  chooseAddress: function (e) {
    this.setData({
      address: e.detail
    });
  },
  checkAddress: function (e) {
    this.setData({
      scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight - (e.detail === '1' ? 124 : 40),
      checkAddress: e.detail
    });
  },
  onRequestPayment: function () {
    const { orderInfos } = this.data;
    const globalData = Request.getGlobalData();
    webapi.PlaceUnifyOrder({
      storeGuid: globalData.apiLoginInfo.StoreGuid,
      storeCustomerGuid: globalData.apiLoginInfo.StoreCustomerGuid,
      orders: orderInfos.map(item => {
        return {
          guid: item.ReferenceOrderGuid,
          price: item.OrderPrice
        }
      })
    }).then(json => {
      console.log(json);
      const data = json.Data;
      wx.requestPayment({
        timeStamp: data.WechatJSAPI.TimeStamp,
        nonceStr: data.WechatJSAPI.NonceStr,
        package: `prepay_id=${data.WechatJSAPI.PrepayGuid}`,
        signType: data.WechatJSAPI.SignType,
        paySign: data.WechatJSAPI.PaySign,
        success: (res) => {
          console.log(res);
          wx.redirectTo({
            url: '/pages/user/order'
          });
        },
        fail(res) {
          console.log(res);
        }
      });
    }).catch((err) => {
      console.error(err);
      wx.showToast({
        title: '获取支付信息失败',
      });
    });
  },
});
