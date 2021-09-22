var app = getApp();
import Config from '../../utils/config.js'
var webapi = require('../../utils/webapi');
var util = require('../../utils/util');

Page({
    data: {
      orderGuid: '',
      orderInfo: {},
      orderItems: [],
      myOwnStores:[],
      orderAttributes:[],
      total: 0,
      totalQuantity: 0,
      collapse: false,
      seller: false,
      showDialog: false,
      shareImageUrl:'',
      sharedGuid:'',
      shippingCost: 0,
      isForVendor: false,
    },
    onLoad: function (options) {
      console.log(options);
      this.setData({
        seller: app.globalData.seller,
        orderGuid: options.orderGuid,
        shippingCost: app.globalData.shippingCost,
      });
      var that = this;
      wx.showLoading({
        title: '获取订单详情',
      });
      var displayPrice = !(this.data.seller && (this.data.orderInfo.OrderStatus == '发货中'));
      webapi.GetDQOrderSharePictureEx([this.data.orderGuid], displayPrice).then(json => {
        wx.hideLoading();
        that.setData({
          shareImageUrl: json.Data.ImageUrl,
          sharedGuid: json.Data.ShareGuid
        });
        this.loadProductDetail();
      }).catch((err)=>{
        wx.showToast({
          title: '获取分享信息失败',
        });
      });
    },
  onChooseStore: function (e) {
    var storeGuid = e.currentTarget.dataset.storeguid;
    this.updateOrderStatus(10, storeGuid);
    this.setData({
      collapse: false,
    });
  },
  updateOrderStatus: function (OrderStatusId, CopyToStoreGuid) {
    var self = this;
    var listOrderStatus = [{ Guid: this.data.orderGuid, ReferenceOrderGuid: '', OrderStatusId: OrderStatusId, CopyToStoreGuid: CopyToStoreGuid }];
    wx.showLoading({
      title: '正在更新',
      icon: 'loading',
      mask: true,
    })
    webapi.BatchUpdateOrderStatus(listOrderStatus).then((res) => {
      wx.hideLoading();
      if(res.Success)
      {
        if (CopyToStoreGuid.length > 0)
          wx.reLaunch({
            url: '/pages/home/choosestore',
          });
        else
          wx.redirectTo({
            url: '/pages/user/order?currentTab=2',
          });
      }
      else
      {
        wx.showModal({
          title: '提示',
          content: res.Message,
          showCancel: false,
        });
      }
    }).catch((err)=>{
      wx.showModal({
        title: '更新失败',
        content: err.Message,
      });
    });
  },
  onMarkAsShipped: function (event) {
    this.updateOrderStatus(29, '');
  },
  onMarkAsPaid:function(e){
    var CopyToStoreGuid = '';
    var self = this;
    wx.showLoading({
      title: '获取数据',
      icon: 'loading',
      mask: true,
    });
    if (!this.data.seller) {
      webapi.getMyAccessStores('', '', '').then((res) => {
        wx.hideLoading();
        if (res.Success) {
          var myAccessStores = res.Data;
          var myOwnStores = [];
          for (var index = 0; index < myAccessStores.length; index++) {
            if (myAccessStores[index].IsOwner == true) {
              myOwnStores.push(myAccessStores[index]);
            }
          }
          if (myOwnStores.length == 0)
            wx.showModal({
              title: '提示',
              content: '您目前没有自己的店铺，请到www.xiaomaimaiquan.com申请您自己的店铺之后，才可以把订单复制到您店铺中并且代发货！',
              showCancel: false,
            })
          else if (myOwnStores.length == 1)
            self.updateOrderStatus(10, CopyToStoreGuid);
          else
            self.setData({
              myOwnStores: myOwnStores,
              collapse: true,
            });
        } else {
          wx.showToast({
            title: "网络异常",
            icon: 'none',
            duration: 2000,
          });
        }
      }).catch((res) => {
        console.log("网络异常", res);
        wx.hideLoading();
      });
    }
    else
      this.updateOrderStatus(10, CopyToStoreGuid);
  },
  //取消订单
  removeOrder: function (e) {
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
  applyDrawBack: function (e) {
      const jumpUrl = e.target.dataset.url;
      wx.navigateTo({url: jumpUrl});
  },
  //确认收货
  recOrder: function (e) {
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
  payOrderByWechat: function (e) {
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
  previewImage:function(e)
  {
    var imageUrl = e.currentTarget.dataset.src;
    var imageList = [];
    this.data.orderAttributes.forEach(o => {
      if (o.NoteName =="ShippingLabel")
        imageList.push(o.NoteValue);
    });
    this.data.orderItems.forEach(o=>{
      if(o.ProductImageUrl)
        imageList.push(o.ProductImageUrl);
      else if(imageList.length==0)
        imageList.push('http://resource.xlwonder.wang/DQ_Product_Default.png');
    });
    wx.previewImage({
      current: imageUrl,
      urls: imageList,
    })
  },
  loadProductDetail: function () {
    wx.showLoading({
      title: '获取订单详情',
    });
    var self = this;
      var orderSearch = {
          Guid: this.data.orderGuid,
          OrderShareGuid: this.data.sharedGuid,
          ///StoreGuid: app.globalData.apiLoginInfo.StoreGuid,
          OrderStatusBatch:'all',
          PageIndex: 0,
          PageSize: 20
      };
      webapi.searchOrder(orderSearch).then((res) => {
        wx.hideLoading();
          if (res.Success) {
              if (res.Data.ListObjects.length > 0) {
                  res.Data.ListObjects[0].OrderInfo.CreatedOn = util.timeStampToDateTime(res.Data.ListObjects[0].OrderInfo.CreatedOn, 'Y-M-D h:m:s')
                  let total = 0;
                  let totalQuantity = 0;
                  res.Data.ListObjects[0].OrderItems.forEach(o => {
                      total += o.SubTotal;
                      totalQuantity += o.Quantity;
                  });
                self.setData({
                  orderInfo: res.Data.ListObjects[0].OrderInfo,
                  orderItems: res.Data.ListObjects[0].OrderItems,
                  orderAttributes: res.Data.ListObjects[0].OrderAttributes,
                  total: total,
                  totalQuantity: totalQuantity,
                  isForVendor: res.Data.ListObjects[0].OrderInfo.StoreCustomerGuid != app.globalData.apiLoginInfo.StoreCustomerGuid,
                  });
              }
          }
      }).catch((err)=>{
        wx.hideLoading();
        wx.showToast({
          title: '获取订单失败',
        });
      });
  },
  onCollapse: function () {
      this.setData({collapse: !this.data.collapse});
  },
  onOpenDialog: function () {
      this.setData({ showDialog: true });
  },
  onModifyOrderPrice: function (event) {
      this.setData({ showDialog: false });
      let order = {orderInfo: this.data.orderInfo, orderItems: this.data.orderItems};
      if(this.data.value === undefined) {
          order.orderInfo.OrderTotal = this.data.total;
      } else {
          order.orderInfo.OrderReceivable = this.data.value;
      }
    order.orderInfo.CreatedOn = 0;
    order.orderInfo.OrderStatusId = 0;
    webapi.updateOrder(order.orderInfo).then(res => {
          if(res.Success)
          {
            wx.showToast({
              title: '修改成功',
            });
            wx.redirectTo({
              url: '/pages/user/order?currentTab=0',
            });
          }
          else
          {
            wx.showModal({
              title: '提示',
              content: res.Message,
              showCancel: false,
            });
          }
      });
  },
  onInputPrice: function (event) {
      this.setData({ value: event.detail.value });
  },
  onShareAppMessage:function(){
    var subject = app.globalData.storeInfo.StoreName + ' 又有新的订单';
    if (this.data.seller && this.data.orderInfo.OrderStatus == '发货中')
      subject = app.globalData.storeInfo.StoreName + ' 又有下家发来新的发货订单';
    else if (this.data.orderInfo.OrderReceivable > 0)
      subject = app.globalData.storeInfo.StoreName + ' 又有价值￥' + this.data.orderInfo.OrderReceivable + '的新订单';
    return util.shareOrders(subject, this.data.shareImageUrl, this.data.sharedGuid);
  },
})
