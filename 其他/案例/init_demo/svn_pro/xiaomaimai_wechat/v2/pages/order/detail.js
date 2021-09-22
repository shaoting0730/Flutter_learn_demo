import Request from "../../utils/request";

var app = getApp();
var webapi = require('../../utils/webapi');
var util = require('../../utils/util');

Page({
  data: {
    orderGuid: '',
    orderInfo: {},
    orderItems: [],
    myOwnStores: [],
    orderAttributes: [],
    total: 0,
    totalQuantity: 0,
    collapse: false,
    seller: false,
    showDialog: false,
    shareImageUrl: '',
    sharedGuid: '',
    isForVendor: false,
    scrollHeight: app.getClientAreaHeight(),
    safeAreaBottom: app.getSafeAreaBottom(),
    isRangePrice: false,
    WechatMPPayEnabled: false,
  },
  onLoad(options) {
    console.log(options);
    this.setData({
      options: options,
      seller: app.globalData.seller,
      orderGuid: options.orderGuid,
      sharedGuid: options.sharedGuid,
      WechatMPPayEnabled: app.globalData.storeInfo.WechatMPPayEnabled
    });
    this.loadProductDetail();

  },
  onChooseStore(e) {
    var storeGuid = e.currentTarget.dataset.storeguid;
    this.updateOrderStatus(10, storeGuid);
    this.setData({
      collapse: false,
    });
  },
  updateOrderStatus(OrderStatusId, CopyToStoreGuid) {

    var listOrderStatus = [{
      Guid: this.data.orderGuid,
      ReferenceOrderGuid: '',
      OrderStatusId: OrderStatusId,
      CopyToStoreGuid: CopyToStoreGuid
    }];
    webapi.BatchUpdateOrderStatus(listOrderStatus).then((res) => {
      if (res.Success) {
        if (CopyToStoreGuid.length > 0)
          wx.reLaunch({
            url: '/pages/home/choosestore',
          });
        else
          wx.redirectTo({
            url: '/pages/user/order?currentTab=2',
          });
      } else {
        wx.showModal({
          title: '提示',
          content: res.Message,
          showCancel: false,
        });
      }
    }).catch((err) => {
      wx.showModal({
        title: '更新失败',
        content: err.Message,
      });
    });
  },
  onMarkAsShipped(event) {
    this.updateOrderStatus(29, '');
  },
  onMarkAsPaid(e) {
    var CopyToStoreGuid = '';
    if (!this.data.seller) {
      webapi.getMyAccessStores('', '', '')
        .then((res) => {
          if (res.Success) {
            var myAccessStores = res.Data;
            var myOwnStores = [];
            for (var index = 0; index < myAccessStores.length; index++) {
              if (myAccessStores[index].IsOwner == true) {
                myOwnStores.push(myAccessStores[index]);
              }
            }
            if (myOwnStores.length == 0) {
              wx.showModal({
                title: '提示',
                content: '您目前没有自己的店铺，请到www.xiaomaimaiquan.com申请您自己的店铺之后，才可以把订单复制到您店铺中并且代发货！',
                showCancel: false,
              })
            } else if (myOwnStores.length == 1) {
              this.updateOrderStatus(10, CopyToStoreGuid);
            } else {
              this.setData({
                myOwnStores: myOwnStores,
                collapse: true,
              });
            }
          } else {
            wx.showToast({
              title: "网络异常",
              icon: 'none',
              duration: 2000,
            });
          }
        }).catch((res) => {
          console.log("网络异常", res);
          app.hideLoading();
        });
    } else {
      this.updateOrderStatus(10, CopyToStoreGuid);
    }
  },
  //取消订单
  removeOrder(e) {
    var orderGuid = e.currentTarget.dataset.orderguid;
    wx.showModal({
      title: '提示',
      content: '你确定要取消订单吗？',
      success: (res) => {
        res.confirm && webapi.deleteOrder(orderGuid).then(() => {
          this.loadOrderList(this.getOrderStatus());
        });
      }
    });
  },
  //申请退款
  applyDrawBack(e) {
    const jumpUrl = e.target.dataset.url;
    wx.navigateTo({
      url: jumpUrl
    });
  },
  //确认收货
  recOrder(e) {
    var orderGuid = e.currentTarget.dataset.orderguid;
    wx.showModal({
      title: '提示',
      content: '你确定已收到宝贝吗？',
      success: (res) => {
        res.confirm && webapi.updateOrderStatus({
          Guid: orderGuid,
          OrderStatusId: 200
        }).then(() => {
          this.loadOrderList(this.getOrderStatus());
        });
      }
    });
  },
  payOrderByWechat(e) {
    var order_id = e.currentTarget.dataset.orderId;
    var order_sn = e.currentTarget.dataset.ordersn;
    console.log(e, "----->payOrderByWechat");
    if (!order_sn) {
      wx.showToast({
        title: "订单异常!",
        duration: 2000,
      });
      return false;
    }
    var orderPayment = {
      storeGuid: app.globalData.apiLoginInfo.StoreGuid,
      ReferenceOrderGuid: res.Data,
      PaymentMethod: this.data.paymentmethod
    };
    webapi.wechatPay(orderPayment, '/pages/user/order?currentTab=2');
  },
  previewImage(e) {
    var imageUrl = e.currentTarget.dataset.src;
    var imageList = [];
    this.data.orderAttributes.forEach(o => {
      if (o.NoteName == "ShippingLabel")
        imageList.push(o.NoteValue);
    });
    this.data.orderItems.forEach(o => {
      if (o.ProductImageUrl)
        imageList.push(o.ProductImageUrl);
      else if (imageList.length == 0)
        imageList.push('http://resource.xlwonder.wang/DQ_Product_Default.png');
    });
    wx.previewImage({
      current: imageUrl,
      urls: imageList,
    })
  },
  loadProductDetail() {
    let isRangePrice = false
    var orderSearch = {
      Guid: this.data.orderGuid,
      OrderShareGuid: this.data.sharedGuid || '',
      ///StoreGuid: app.globalData.apiLoginInfo.StoreGuid,
      OrderStatusBatch: 'all',
      PageIndex: 0,
      PageSize: 1
    };
    webapi.searchOrder(orderSearch).then((res) => {
      if (res.Success) {
        if (res.Data.ListObjects.length > 0) {
          res.Data.ListObjects[0].OrderInfo.CreatedOn = util.timeStampToDateTime(res.Data.ListObjects[0].OrderInfo.CreatedOn, 'Y-M-D h:m:s')
          let total = 0;
          let totalQuantity = 0;
          res.Data.ListObjects[0].OrderItems.forEach(o => {
            total += o.SubTotal;
            totalQuantity += o.Quantity;
            if (!isRangePrice) {
              isRangePrice = o.PriceType === 2
            }
          });
          console.log('OrderInfo', res.Data.ListObjects[0].OrderInfo)
          this.setData({
            orderInfo: res.Data.ListObjects[0].OrderInfo,
            orderItems: res.Data.ListObjects[0].OrderItems,
            orderAttributes: res.Data.ListObjects[0].OrderAttributes,
            isRangePrice,
            total: total,
            totalQuantity: totalQuantity,
            isForVendor: res.Data.ListObjects[0].OrderInfo.StoreCustomerGuid != app.globalData.apiLoginInfo.StoreCustomerGuid,
          });
        }
      }
    }).catch((err) => {
      app.hideLoading();
      wx.showToast({
        title: '获取订单失败',
      });
    });
  },
  onCollapse() {
    this.setData({
      collapse: !this.data.collapse
    });
  },
  onOpenDialog() {
    this.setData({
      showDialog: true
    });
  },
  onModifyOrderPrice(event) {
    this.setData({
      showDialog: false
    });
    let order = {
      orderInfo: this.data.orderInfo,
      orderItems: this.data.orderItems
    };
    if (this.data.value === undefined) {
      order.orderInfo.OrderTotal = this.data.total;
    } else {
      order.orderInfo.OrderReceivable = this.data.value;
    }
    order.orderInfo.CreatedOn = 0;
    order.orderInfo.OrderStatusId = 0;
    webapi.updateOrder(order.orderInfo).then(res => {
      if (res.Success) {
        wx.showToast({
          title: '修改成功',
        });
        wx.redirectTo({
          url: '/pages/user/order?currentTab=0',
        });
      } else {
        wx.showModal({
          title: '提示',
          content: res.Message,
          showCancel: false,
        });
      }
    });
  },
  onInputPrice({ detail }) {
    this.setData({
      value: detail.value
    });
  },

  onCloseOwn() {
    this.setData({
      collapse: false
    })
  },
  changeStore(e) {
    app.changeStoreEx(e.currentTarget.dataset.storeguid)
  },
  onUpCopyOrderAndPay() {
    const { orderInfo } = this.data;
    webapi.UpCopyOrder({
      StoreCustomerGuid: orderInfo.StoreCustomerGuid,
      ReferenceOrderGuid: orderInfo.ReferenceOrderGuid,
      PaymentMethod: 6,
    }).then((orderData) => {
      const { storeGuid, storeCustomerGuid, referenceOrderGuid, orderReceivable } = orderData.Data;
      webapi.PlaceUnifyOrder({
        storeGuid,
        storeCustomerGuid,
        orders: [{
          guid: referenceOrderGuid,
          price: parseFloat(orderReceivable)
        }]
      }).then((json) => this.onWechatPay(json))
        .catch((err) => {
          console.error(err);
          wx.showToast({
            title: '获取支付信息失败',
          });
        });
    }).catch((err) => {
      console.error(err);
      wx.showToast({
        title: '获取供应商订单信息失败',
      });
    });
  },
  onRequestPayment() {
    const globalData = Request.getGlobalData();
    const { ReferenceOrderGuid, OrderReceivable } = this.data.orderInfo;
    webapi.PlaceUnifyOrder({
      storeGuid: globalData.apiLoginInfo.StoreGuid,
      storeCustomerGuid: globalData.apiLoginInfo.StoreCustomerGuid,
      orders: [{
        guid: ReferenceOrderGuid,
        price: OrderReceivable
      }]
    }).then((json) => this.onWechatPay(json))
      .catch((err) => {
        console.error(err);
        wx.showToast({
          title: '获取支付信息失败',
        });
      });
  },
  onWechatPay(json) {
    console.log(json);
    const data = json.Data;
    wx.requestPayment({
      timeStamp: data.WechatJSAPI.TimeStamp,
      nonceStr: data.WechatJSAPI.NonceStr,
      package: `prepay_id=${data.WechatJSAPI.PrepayGuid}`,
      signType: data.WechatJSAPI.SignType,
      paySign: data.WechatJSAPI.PaySign,
      success(res) {
        console.log(res);
        self.onLoad(self.data.options);
      },
      fail(res) {
        console.log(res);
      }
    });
  },
  onShare() {
    const { storeInfo } = app.globalData;
    const { seller, orderInfo } = this.data;
    const displayPrice = !(this.data.seller && (this.data.orderInfo.OrderStatusCategory == 'ReadyForShip'));
    let navTitle = '分享给供货商发货';
    let title = storeInfo.StoreName + ' 又有新的订单';
    if (seller && orderInfo.OrderStatusCategory === 'ReadyForShip') {
      title = storeInfo.StoreName + ' 又有下家发来新的发货订单';
    } else if (orderInfo.OrderReceivable > 0) {
      title = storeInfo.StoreName + ' 又有价值¥' + orderInfo.OrderReceivable + '的新订单';
    }
    if (seller && orderInfo.OrderStatusCategory === 'Unpaid') {
      navTitle = '分享给买家提醒付款'
      title = '你有一张未付款订单，点击查看～'
    }
    if (!seller && orderInfo.OrderStatusCategory === 'Unpaid' && orderInfo.VendorWechatMPPayEnabled) {
      navTitle = '分享给店主付款'
    }
    wx.navigateTo({
      url: '/pages/share/index',
      events: {
        getShare: (callback) => {
          callback({
            navTitle,
          })
        },
        getImage: (callback) => {
          webapi.GetDQOrderSharePictureEx([this.data.orderGuid], displayPrice, "加载数据").then(res => {
            callback({
              ...res.Data,
              share: {
                title: title,
                path: `/pages/user/order?ShareGuid=${res.Data.ShareGuid}&storeGuid=${Request.getStoreGuid()}`
              }
            })
          }).catch((err) => {
            wx.showToast({
              title: '获取分享信息失败',
            });
          });
        }
      }
    });
  }
});
