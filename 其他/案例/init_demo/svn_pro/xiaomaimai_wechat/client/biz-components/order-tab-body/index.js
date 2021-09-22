/**
 * 订单状态Tab页面Body 组件
 */

var app = getApp();
import Config from '../../utils/config.js'
import Request from '../../utils/request.js'
var webapi = require('../../utils/webapi');
const util = require('../../utils/util');
import cloudApi from "../../utils/cloudapi"

Component({
    /**
     * 组件的属性列表
     */
    properties: {
      seller:{
        type:Boolean,
        value:false,
      },
      fromShareOrder: {
        type: Boolean,
        value: false,
      },
      currentTab: {
          type: Number,
          value: -1,
      }
    },

    /**
     * 组件的初始数据
     */
    data: {
        collapse: false,
        myOwnStores:[],
        storeCustomerGuid:'',
        orderList: [],
        firstLoad: true,
        pageIndex: 0,
        pageSize: 10,
        totalSize: -1,
        hasMore: true,
        loading: false,
        selectedList:[],
        qrCodeimageUrl: '',
        totalPayment: 0,
        displayPrice:false,
        isForVendor:false,
        progress: {
          percent: 0,
          show: false
        },
        shareGuid:'',
        shareImageUrl:'',
        showModal: false,
    },
    attached: function () {
      console.log('-----attachedloadtabdata----');
      ///this.loadTabData('');
    },
    /**
     * 组件的方法列表
     */
    methods: {
      onSelectAll:function()
      {
        if (this.data.selectedList.length==this.data.orderList.length)
        {
          const orderList = this.data.orderList;
          orderList.forEach(o => {
            o.OrderInfo.selected = false;
          });
          this.setData({ selectedList: [], orderList: orderList, totalPayment:0 });
        }
        else
        {
          const orderList = this.data.orderList;
          var isForVendor = true;
          var list = [];
          var totalPayment = 0;
          orderList.forEach(o => {
            o.OrderInfo.selected = true;
            totalPayment += o.OrderInfo.OrderReceivable;
            list.push(o.OrderInfo.Guid);
            isForVendor &= o.OrderInfo.StoreCustomerGuid != app.globalData.apiLoginInfo.StoreCustomerGuid;
            this.setData({ selectedList: list });
          });
          this.setData({ orderList: orderList, isForVendor: isForVendor, totalPayment: totalPayment });
        }
      },
      onPreOperation: function (event){
        const guid = event.currentTarget.dataset.guid;
        const orderList = this.data.orderList;
        var isForVendor = true;
        var totalPayment = this.data.totalPayment;
        orderList.forEach(o => {
            if (o.OrderInfo.Guid === guid) {
              o.OrderInfo.selected = !o.OrderInfo.selected;
              let list = this.data.selectedList;
              if (o.OrderInfo.selected) {
                totalPayment += o.OrderInfo.OrderReceivable;
                list.push(guid);
                isForVendor &= o.OrderInfo.StoreCustomerGuid!=app.globalData.apiLoginInfo.StoreCustomerGuid;
              } else {
                totalPayment -= o.OrderInfo.OrderReceivable;
                list = list.filter(item => item !== guid);
              }
              this.setData({ selectedList: list });
            }
          });
        this.setData({ orderList: orderList, isForVendor: isForVendor, totalPayment: totalPayment});
      },
      getOrderStatus: function () {
          switch (this.properties.currentTab) {
              case -1:
                  return 'All';
              case 0:
                  return 'Unpaid';
              case 1:
                  return 'Unpaid';//'WaitAction';
              case 2:
                  return 'ReadyForShip';
              case 3:
                  return 'Packing';
              case 4:
                return 'Shipped';
              default:
                  return 'Unpaid';
          }
      },
      //查询订单详情
      detailOrder: function (e) {
          console.log(e, "---->detailOrder");
          const jumpUrl = e.target.dataset.url;
          wx.navigateTo({url: jumpUrl});
      },
      //取消订单
      removeOrder: function (e) {
          var orderGuid = e.currentTarget.dataset.orderguid;
          wx.showModal({
              title: '提示',
              content: '你确定要取消订单吗？',
              success: (res) => {
                  res.confirm && webapi.deleteOrder(orderGuid).then((res) => {
                      this.setData({
                          firstLoad: true,
                          hasMore: true,
                          pageIndex: 0,
                          orderList: [],
                      }, () => {
                          this.loadTabData('');
                      });

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
                      this.setData({
                          firstLoad: true,
                          hasMore: true,
                          pageIndex: 0,
                          orderList: [],
                      }, () => {
                          this.loadTabData('');
                      });
                  });
              }
          });
      },
      loadOrderList: function (orderStatus, sharedGuid) {
        console.log(orderStatus);
            const {pageIndex, pageSize, totalSize, hasMore, firstLoad} = this.data;
            if (!hasMore) {
                return;
            }
            const orderSearch = {
              OrderStatusBatch: orderStatus,
              OrderShareGuid: sharedGuid,
              StoreGuid: app.globalData.apiLoginInfo.StoreGuid,
              PageIndex: pageIndex,
              PageSize: pageSize,
            };
            this.setData({
                loading: true,
            });
            webapi.searchOrder(orderSearch).then((res) => {
                const nextPageIndex = pageIndex + 1;
                //检测 是否后续还有数据要加载
                let nextHasMore = false;
                const curPageIndex = res.Data.PageIndex + 1;
                const curTotalCount = res.Data.TotalCount;
                if (curTotalCount > -1 && (curPageIndex) * pageSize < curTotalCount) {
                    nextHasMore = true;
                }
                let orderList = [];
                if (firstLoad) {
                    orderList = res.Data.ListObjects;
                } else {
                    orderList = [...this.data.orderList, ...res.Data.ListObjects];
                }
                let list = [];
                orderList.forEach(o => {
                    o.OrderInfo.CreatedOnFMT = util.timeStampToDateTime(o.OrderInfo.CreatedOn, 'Y-M-D h:m:s');
                    let total = 0;
                    let totalQuantity = 0;
                    o.OrderItems.forEach(item => {
                        total += item.SubTotal;
                        totalQuantity += item.Quantity;
                    });
                    o.OrderInfo.OrderTotal = total;
                    o.OrderInfo.TotalQuantity = totalQuantity;
                    list.push(o);
                });

                this.setData({
                    orderList: orderList,
                    firstLoad: false,
                    pageIndex: nextPageIndex,
                    totalSize: curTotalCount,
                    hasMore: nextHasMore,
                    loading: false,
                });
            });
        },
        loadTabData: function (sharedGuid) {
          console.log("---->loadTabData-->" + sharedGuid);          
          this.setData({
            storeCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid, shareGuid: '',
            shareImageUrl: ''});
            //没有数据就进行加载
            switch (this.properties.currentTab) {
                case -1:
                  this.loadOrderList('All', sharedGuid);
                    break;
                case 0:
                  this.loadOrderList('Unpaid', sharedGuid);
                    break;
                case 1:
                  this.loadOrderList('Unpaid', sharedGuid);
                  //this.loadOrderList('WaitAction', sharedGuid);
                  break;
                case 2:
                  this.loadOrderList('ReadyForShip', sharedGuid);
                    break;
                case 3:
                  this.loadOrderList('Packing', sharedGuid);
                    break;
                case 4:
                  this.loadOrderList('Shipped', sharedGuid);
                    break;
            }
        },
        payOrderByWechat: function (e) {
            var orderGuid = e.currentTarget.dataset.orderguid;
            var orderPayment = {
                StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
                ReferenceOrderGuid: orderGuid,
                PaymentMethod: 6    //微信支付
            };

            wx.showLoading({
                title: '准备支付',
                icon: 'loading',
                mask: true,
            });
            webapi.wechatPay(orderPayment).then((res) => {
                console.log(res, "---->wechatPay-->success");
                wx.hideLoading();
                const orderGuid = "12343434";
                wx.redirectTo({
                    url: '/pages/user/order?currentTab=2',
                });
                wx.showToast({
                    title: "支付成功",
                    icon: "none",
                });
            }).catch((res) => {
                console.log(res, "---->wechatPay-->fail");
                wx.showToast({
                    title: "支付失败",
                    icon: "none",
                });
                wx.hideLoading();
            });

        },

        onOrderDetail: function (event) {
            wx.navigateTo({
              url: '/pages/order/detail?orderGuid=' + event.currentTarget.dataset.guid
            });
        },
      uploadTracking:function(e){
        var orderGuid = e.currentTarget.dataset.orderguid;
        const self = this;
        wx.chooseImage({
          count: 1, // 默认9  
          sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有  
          sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有  
          success: function (res) {
            // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
            var fullPath = res.tempFilePaths[0];
            var arr = fullPath.split('/');
            var fileName = arr[arr.length - 1];
            // 上传图片
            var uploadTask = cloudApi.webapiUploadFiles(res.tempFilePaths[0]);
            uploadTask.onProgressUpdate((res) => {
              self.setData({ progress: { percent: res.progress, show: true } });
              if(res.progress>=100)
              {
                setTimeout(function () {
                  self.setData({ progress: { percent: 0, show: false } });
                  webapi.updateOrderImage({ OrderGuid: orderGuid, StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid, OrderImageType: 1, ImageUrl: Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName }).then((res) => {
                    wx.redirectTo({
                      url: '/pages/user/order?currentTab=4',
                    });
                  });
                }, 2000);
              }
            });            
          }
        });
      },
      onChooseStore: function (e) {
        var storeGuid = e.currentTarget.dataset.storeguid;
        this.updateOrderStatus(10, storeGuid);
        this.setData({
          collapse: false,
        });
      },
      updateOrderStatus: function (OrderStatusId, CopyToStoreGuid)
      {
        var self = this;
        var listOrderStatus = [];
        this.data.selectedList.forEach(o => {
          listOrderStatus.push({ Guid: o, ReferenceOrderGuid: '', OrderStatusId: OrderStatusId, CopyToStoreGuid: CopyToStoreGuid })
        });
        wx.showLoading({
          title: '正在更新',
          icon: 'loading',
          mask: true,
        })
        webapi.BatchUpdateOrderStatus(listOrderStatus).then((res) => {
          wx.hideLoading();
          if (res.Success) {
            if (CopyToStoreGuid.length > 0)
              wx.reLaunch({
                url: '/pages/home/choosestore',
              });
            else
              wx.redirectTo({
                url: '/pages/user/order?currentTab=' + self.properties.currentTab,
              });
          }
          else {
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
      onMarkAsPaid: function(event){
        var CopyToStoreGuid = '';
        var self = this;
        wx.showLoading({
          title: '获取数据',
          icon: 'loading',
          mask: true,
        });
        if(!this.data.seller)
        {
          webapi.getMyAccessStores('','','').then((res)=>{
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
                  showCancel:false,
                })
              else if (myOwnStores.length==1)
                self.updateOrderStatus(10, myOwnStores[0].StoreGuid);
              else
                self.setData({
                  myOwnStores: myOwnStores,
                  collapse:true,
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
      onMarkAsShipped: function (event) {
        this.updateOrderStatus(29, '');
      },
      onShareToPay: function (event) {
        var self = this;
        wx.showLoading({
          title: '生成分享内容',
        });
        webapi.GetDQOrderSharePictureEx(this.data.selectedList, true).then(json => {
          wx.hideLoading();
          self.setData({
            shareGuid: json.Data.ShareGuid,
            shareImageUrl: json.Data.ImageUrl,
            displayPrice:true,
            showModal: true
          });
        }).catch((err) => {
          wx.hideLoading();
          wx.showToast({
            title: '生成失败！',
          });
        });
      },
      onMarkAsPacking: function (event) {
        var self = this;
        wx.showLoading({
          title: '生成分享内容',
        });
        webapi.GetDQOrderSharePictureEx(this.data.selectedList, false).then(json => {
          wx.hideLoading();
          console.log(json, "---->onShareAppMessage");
          self.setData({
            shareGuid: json.Data.ShareGuid,
            shareImageUrl: json.Data.ImageUrl,
            displayPrice:false,
            showModal: true});
        }).catch((err)=>{
          wx.hideLoading();
          wx.showToast({
            title: '生成失败！',
          });
        });
      },
    }
})
