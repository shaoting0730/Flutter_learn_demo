var app = getApp();
import Config from '../../utils/config.js'
var webapi = require('../../utils/webapi');
var util = require('../../utils/util');

Page({
    data: {
      paymentmethod: 6,//2=alipay; 6=wechat;
      remark: '',
      btnDisabled: false,
      productData: [],
      address: {},
      orderPrice: { TotalPrice: 0, ShippingFee: 0, SubTotal:0},
      discountPrice: 0,
      couponguid: '',
      validcoupons: [],
      loadingPrice:true,
      totalQuantity: 0,
      collapse: false,
      totalPrice: 0,
      shippingCost: 0,
      qrCodeimageUrl:'',
      shareImageUrl:'',
      sharedGuid:'',
      storeGuid:'',
      showModal:false,
    },
    onShow: function () {
        var that = this;
        this.setData({
          storeGuid: Config.StoreGuid,
        });
        wx.getStorage({
            key: 'address',
            success: function (res) {
              console.log(res);
                that.setData({address: res.data});
            }
        })
        console.log(this.data.address);
        if(!this.data.address)
        {
          var addressSearch = {
            StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
            AddressType: 2,
          };
          webapi.searchStoreCustomerAddress(addressSearch).then((res) => {
            console.log(res);
            this.setData({
              address: res.Data.ListObjects[0],
            });
          });

        }
      console.log(this.data.address);
    },
    onLoad: function (options) {
        var that = this;
        if (options.address) {
            this.setData({
                address: options.address,
                couponguid: options.couponguid,
                remark: options.remark,
            });
        }
      wx.showLoading({
        title: '获取订单信息',
        icon: 'loading',
        mask: true,
      });
      webapi.loadShoppingCart().then((res) => {
          console.log(res, "loadShoppingCart--->res")
          if(res && res.Success) {
              let productList = [];
              res.Data.forEach(p => {
                  if(options.productData.includes(p.ProductCode)) {
                      productList.push(p);
                  }
              })
              let totalQuantity = 0;
              let totalPrice = 0;
              productList.forEach(p => {
                totalQuantity += p.Quantity;
                totalPrice += p.ProductOnSalePrice * p.Quantity;
              });
              that.setData({
                productData: productList,
                totalQuantity: totalQuantity,
                totalPrice: totalPrice,
                shippingCost: app.globalData.shippingCost,
              });
              wx.hideLoading();
              that.calculatePrice();
          }
        else {
          wx.hideLoading();
          wx.showToast({
            title: res.Message,
            icon: "none",
          });
        }
      }).catch(() => {
        wx.hideLoading();
        wx.showToast({
          title: "获取订单详情失败",
          icon: "none",
        });
      });
    },
    calculatePrice: function () {
      wx.showLoading({
        title: '计算订单价格',
        icon: 'loading',
        mask: true,
      });
      this.setData({
          loadingPrice:true,
      })
      webapi.calculateOrderPrice(this.data.productData).then((res) => {
          //更新数据
          const orderPrice = res.Data;
          this.setData({
              orderPrice: orderPrice,
              loadingPrice:false,
          });
          wx.hideLoading();
      }).catch(() => {
        wx.hideLoading();
        this.setData({
          loadingPrice: false,
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
    this.setData({ showModal: false });
    wx.redirectTo({
      url: '/pages/user/order?currentTab=1',
    });
  },
  onShareAppMessage:function(){
    this.setData({ showModal: false});
    wx.redirectTo({
      url: '/pages/user/order?currentTab=1',
    });
    var subject = app.globalData.storeInfo.StoreName + ' 又有新的订单';
    var totalPrice = this.data.totalPrice + this.data.shippingCost;
    if (totalPrice > 0)
      subject = app.globalData.storeInfo.StoreName + ' 又有价值￥' + totalPrice + '的新订单';
    return util.shareOrders(subject, this.data.shareImageUrl, this.data.sharedGuid);
  },
    //微信支付
  createProductOrderByWX: function (event) {
      this.setData({
          paymentmethod: 6,
      });
      let formId = event.detail.formId;
    this.createProductOrder(formId);
    },

    //确认订单
  createProductOrder: function (formId) {
        this.setData({
            btnDisabled: false,
        });
        if(!this.data.address)
        {
          wx.showToast({
            title: '请选择收货地址',
          });
          return;
        }
        if (!this.data.address.AddressLine)
        {
          wx.showToast({
            title: '请选择收货地址',
          });
          return;
        }
        if (this.data.address.AddressLine.length<=0) {
          wx.showToast({
            title: '请选择收货地址',
          });
          return;
        }
        //创建订单
        var that = this;
        var usedcouponcode = '';
        /*for (var index in that.data.validcoupons) {
            if (that.data.validcoupons[index].Guid == that.data.couponguid)
                usedcouponcode = that.data.validcoupons[index].Code;
        }*/
        var city = that.data.address.City;
        var address = that.data.address.AddressLine;
        if (that.data.address.Town) {
          if (city == that.data.address.Province) {
            city = that.data.address.Town;
            address = that.data.address.AddressLine
          }
          else {
            address == that.data.address.Town + address;
          }
        }
        
        var orderInfo = {
            OrderType: 'Product',
            StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
            ShipToName: that.data.address.FullName,
            ShipToAddress: address,
            ShipToCity: city,
            ShipToProvince: that.data.address.Province,
            ShipToPostalCode: that.data.address.PostCode,
            ShipToAreaCode: '',
            ShipToCountry: that.data.address.Country,
            ShipToIDCardType: that.data.address.IDCardType,
            ShipToIDCardNumber: that.data.address.IDCardNumber,
            ShipToEmail: that.data.address.Email,
            ShipToPhone: that.data.address.PhoneNumber,
            OrderCouponCode: usedcouponcode,
            OrderShipping: 0,
            OrderTotal: that.data.orderPrice.TotalPrice,
            OrderReceivable: that.data.orderPrice.TotalPrice - that.data.discountPrice,
            Notes: that.data.remark,
        };
    var orderPlace = { OrderInfo: orderInfo, OrderItems: that.data.productData, StoreCustomerKey: '', MerchantGuid: '', PaymentSignMD5Key: formId, TradeType:'XMMQ'};
      var allFixedPrice = true;
      that.data.productData.forEach(p => {
        if(p.ProductOnSalePrice==0)
          allFixedPrice = false;
      });
        wx.showLoading({
            title: '生成订单',
            icon: 'loading',
            mask: true,
        });
        webapi.placeOrder(orderPlace).then((res) => {
            if(res.Success)
            {
              wx.hideLoading();
              /*
              wx.redirectTo({
                url: '/pages/user/order?currentTab=1',
              });
              */
              ///*
              webapi.GetDQOrderSharePictureEx([res.Data["OrderGuid"]], true).then(json => {
                that.setData({
                  shareImageUrl: json.Data.ImageUrl,
                  sharedGuid: json.Data.ShareGuid,
                });
                if (!allFixedPrice)// || app.globalData.storeInfo.PaymentQRCodeUrl.length<=0)
                {
                  wx.showModal({
                    title: '下单成功',
                    content: '您的订单已经生成，由于您的商品中含有未确定价格商品，请在‘等候付款’页面勾选订单，分享给卖家微信聊天，沟通最终价格并付款',
                    showCancel: false,
                    success: function (res) {
                      wx.redirectTo({
                        url: '/pages/user/order?currentTab=1',
                      });
                    }
                  });
                }
                else
                  that.setData({
                    showModal: true,
                  });
              });
              //*/
            }
            else
            {
              wx.hideLoading();
              wx.showToast({
                title: res.Message,
                icon: "none",
              });
            }
        }).catch((err)=>{
          wx.hideLoading();
          console.log(err);
          wx.showToast({
              title:"生成订单失败",
              icon:"none",
          });
        });
    },
    onCollapse: function () {
        this.setData({ collapse: !this.data.collapse });
    },
});
