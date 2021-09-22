//获取应用实例
import cloudApi from "../../utils/cloudapi";
import Config from "../../utils/config";
import Request from "../../utils/request";

var app = getApp();
var webapi = require('../../utils/webapi');
const util = require('../../utils/util');
Page({
  data: {
    seller: false,
    fromShareOrder: false,
    shareGuid: '',
    selectedUnpaid: false,
    selectedWaitAction: false,
    selectedPaid: false,
    selectedPacking: false,
    selectedShipped: false,
    filterActive: false,
    collapse: false,
    myOwnStores: [],
    storeCustomerGuid: '',
    orderList: [],
    qrCodeimageUrl: '',
    totalPayment: 0,
    displayPrice: false,
    isForVendor: false,
    progress: {
      percent: 0,
      show: false
    },
    shareImageUrl: '',
    showModal: false,
    selectedStatusDesc: "全部",
    selectedAllOrders: false,
    selectedList: [],
    selectedStatusCode: '',
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    status: 'ready',
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
    searchModel: {
      OrderStatusBatchList: [],
      OrderShareGuid: '',
      pageIndex: 0,
      pageSize: 10,
    }
  },

  initPage: function (options) {
    const { searchModel } = this.data;
    this.setData({
      userInfo: app.globalData.userInfo,
      seller: app.globalData.seller,
      sharedGuid: options.ShareGuid || '',
      fromShareOrder: !!options.ShareGuid,
      storeCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
      shareGuid: '',
      shareImageUrl: ''
    });
    searchModel.StoreGuid = app.globalData.apiLoginInfo.StoreGuid;
    this.refresher.triggerRefresh();
  },
  onLoad: function (options) {
    this.setData({ options });
    const self = this;
    console.log(options);
    this.refresher = this.selectComponent("#refresher");
    webapi.logOnLoad(options);
    if (app.globalData.apiLoginInfo && (!options.storeGuid || app.globalData.apiLoginInfo.storeGuid === options.storeGuid)) {
      if (app.globalData.seller) {
        wx.setNavigationBarTitle({ title: "我的销售订单" });
      }
      self.initPage(options);
    } else {
      app.getUserInfo({
        storeGuid: options.storeGuid,
        success: () => {
          app.clearStoreInfo();
          webapi.loadUserBind(options.storeGuid).then((res) => {
            if (res.Success) {
              app.onLoggedIn(res.Data, {
                success: () => {
                  self.initPage(options);
                }
              });
            } else {
            }
          });
        },
        fail: () => {
          this.setData({ status: 'need-author' });
        }
      });
    }
  },
  onFilter: function () {
    if (!this.data.filterActive) {
      this.data.selectionBackup = {
        selectedUnpaid: this.data.selectedUnpaid,
        selectedWaitAction: this.data.selectedWaitAction,
        selectedPaid: this.data.selectedPaid,
        selectedPacking: this.data.selectedPacking,
        selectedShipped: this.data.selectedShipped
      }
      this.setData({ filterActive: !this.data.filterActive });
    } else {
      this.setData({
        filterActive: !this.data.filterActive,
        selectedUnpaid: this.data.selectionBackup.selectedUnpaid,
        selectedWaitAction: this.data.selectionBackup.selectedWaitAction,
        selectedPaid: this.data.selectionBackup.selectedPaid,
        selectedPacking: this.data.selectionBackup.selectedPacking,
        selectedShipped: this.data.selectionBackup.selectedShipped
      });
      this.updateSelectedAllStatus();
    }
  },

  updateSelectedAllStatus() {
    const { seller, selectedUnpaid, selectedWaitAction, selectedPaid, selectedPacking, selectedShipped } = this.data;
    let status = [];
    let statusCode = '';
    if (selectedUnpaid) {
      status.push("未付款");
      statusCode = "Unpaid";
    }
    if (selectedWaitAction) {
      status.push("等待卖家确认");
      statusCode = "WaitAction";
    }
    if (selectedPaid) {
      status.push("已支付");
      statusCode = "Paid";
    }
    if (selectedPacking) {
      status.push("打包中");
      statusCode = "Packing";
    }
    if (selectedShipped) {
      status.push("已发货");
      statusCode = "Shipped";
    }
    let isShowAllCheckBox = [
      selectedUnpaid,
      selectedWaitAction,
      selectedPaid,
      selectedPacking,
      selectedShipped]
      .filter(item => item)
      .length === 1;


    if (isShowAllCheckBox && !seller) {
      isShowAllCheckBox = selectedUnpaid || selectedWaitAction
    }



    this.setData({
      selectedAllStatus: this.data.selectedUnpaid && this.data.selectedWaitAction && this.data.selectedPaid && this.data.selectedPacking && this.data.selectedShipped,
      selectedStatusDesc: (status.length === 0 || status.length === 5) ? "全部" : status.join("/"),
      isShowAllCheckBox,
      selectedList: [],
    });
  },
  selectUnpaid: function () {
    this.setData({
      selectedUnpaid: !this.data.selectedUnpaid,
    });
    this.updateSelectedAllStatus();
  },
  selectWaitAction: function () {
    this.setData({
      selectedWaitAction: !this.data.selectedWaitAction,
    });
    this.updateSelectedAllStatus();
  },
  selectPaid: function () {
    this.setData({
      selectedPaid: !this.data.selectedPaid,
    });
    this.updateSelectedAllStatus();
  },
  selectPacking: function () {
    this.setData({
      selectedPacking: !this.data.selectedPacking,
    });
    this.updateSelectedAllStatus();
  },
  selectShipped: function () {
    this.setData({
      selectedShipped: !this.data.selectedShipped,
    });
    this.updateSelectedAllStatus();
  },
  getSelectedOrders: function () {
    let list = [];
    let selectedStatusCode = '';
    this.data.orderList.forEach(o => {
      if (o.OrderInfo.selected) {
        list.push(o.OrderInfo.Guid);
        if (selectedStatusCode === '' || selectedStatusCode === o.OrderInfo.OrderStatusCategory) {
          selectedStatusCode = o.OrderInfo.OrderStatusCategory;
        }
        else {
          selectedStatusCode = '-';
        }
      }
    });

    if (this.data.selectedStatusCode !== selectedStatusCode) this.setData({ selectedStatusCode });

    return list;
  },
  selectAllOrders: function () {
    if (this.data.selectedAllOrders) {
      const orderList = this.data.orderList;
      orderList.forEach(o => {
        o.OrderInfo.selected = false;
      });
      this.setData({ selectedAllOrders: false, orderList: orderList, totalPayment: 0 });
    } else {
      const orderList = this.data.orderList;
      let totalPayment = 0;
      orderList.forEach(o => {
        o.OrderInfo.selected = true;
        if (!o.isRangePrice) {
          totalPayment += o.OrderInfo.OrderReceivable;
        }
      });
      this.setData({ selectedAllOrders: true, orderList: orderList, totalPayment: totalPayment });
      this.updateIsForVendor();
    }

    this.setData({ selectedList: this.getSelectedOrders() });
  },
  updateIsForVendor() {
    const orderList = this.data.orderList;
    let isForVendor = true;
    orderList.forEach(o => {
      if (o.OrderInfo.selected) {
        isForVendor &= (o.OrderInfo.StoreCustomerGuid !== app.globalData.apiLoginInfo.StoreCustomerGuid &&
          o.OrderInfo.OrderStatusCategory === "ReadyForShip"
        );
      }
    });
    this.setData({ isForVendor: isForVendor });
  },
  bindToggleSelectAll: function () {
    this.setData({
      selectedUnpaid: !this.data.selectedAllStatus,
      selectedWaitAction: !this.data.selectedAllStatus,
      selectedPaid: !this.data.selectedAllStatus,
      selectedPacking: !this.data.selectedAllStatus,
      selectedShipped: !this.data.selectedAllStatus,
      selectedAllStatus: !this.data.selectedAllStatus,
    });
    this.updateSelectedAllStatus();
  },
  onFilterClear: function () {
    this.setData({
      selectedUnpaid: false,
      selectedWaitAction: false,
      selectedPaid: false,
      selectedPacking: false,
      selectedShipped: false,
      selectedAllStatus: false,
    });
    this.updateSelectedAllStatus();
  },
  onFilterSubmit: function () {
    this.setData({
      filterActive: false,
    });
    this.refresher.triggerRefresh();
  },
  isAllEqual(array) {
    if (array.length > 0) {
      return !array.some(function (value, index) {
        return value !== array[0];
      });
    } else {
      return true;
    }
  },
  onPreOperation: function (event) {
    const guid = event.currentTarget.dataset.guid;
    const orderList = this.data.orderList;
    const list = this.getSelectedOrders();
    let totalPayment = 0;
    let storeGuids = [];
    orderList.forEach(o => {
      if (o.OrderInfo.Guid === guid) {
        o.OrderInfo.selected = !o.OrderInfo.selected;

        if (o.OrderInfo.selected && !o.isRangePrice) {
          totalPayment += o.OrderInfo.OrderReceivable;
          list.push(guid);
          storeGuids.push(o.OrderInfo.StoreGuid)
        }
        // else {
        //   totalPayment -= o.OrderInfo.OrderReceivable;
        //   list = list.filter(item => item !== guid);
        // }
      }
    });

    this.setData({
      orderList: orderList,
      totalPayment: totalPayment,
      selectedList: this.getSelectedOrders(),
      isShowsharebtn: this.isAllEqual(storeGuids),
      selectedAllOrders: orderList.length === this.getSelectedOrders().length,
    });
    this.updateIsForVendor();
  },
  //查询订单详情
  detailOrder: function (e) {
    console.log(e, "---->detailOrder");
    const jumpUrl = e.target.dataset.url;
    wx.navigateTo({ url: jumpUrl });
  },
  //取消订单
  removeOrder: function (e) {
    const { item } = e.currentTarget.dataset;
    const { orderList } = this.data;
    wx.showModal({
      title: '提示',
      content: '你确定要取消订单吗？',
      success: (res) => {
        res.confirm && webapi.deleteOrder(item.Guid).then((res) => {
          if (res.Success) {
            const index = orderList.findIndex(order => order.guid === item.Guid);
            orderList.splice(index, 1);
            this.setData({ orderList })
          } else {
            wx.showToast({
              title: "网络异常",
              icon: 'none',
            });
          }
        });
      }
    });
  },
  //申请退款
  applyDrawBack: function (e) {
    const jumpUrl = e.target.dataset.url;
    wx.navigateTo({ url: jumpUrl });
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
          this.refresher.triggerRefresh();
        });
      }
    });
  },
  getOrderList: function () {
    const { searchModel, orderList } = this.data;
    const batchList = [];
    if (this.data.selectedUnpaid && this.data.selectedWaitAction && this.data.selectedPaid && this.data.selectedPacking && this.data.selectedShipped) {
      batchList.push("All");
    } else if (!this.data.selectedUnpaid && !this.data.selectedWaitAction && !this.data.selectedPaid && !this.data.selectedPacking && !this.data.selectedShipped) {
      batchList.push("All");
    } else {
      if (this.data.selectedUnpaid) batchList.push("Unpaid");
      if (this.data.selectedWaitAction) batchList.push("WaitAction");
      if (this.data.selectedPaid) batchList.push("ReadyForShip");
      if (this.data.selectedPacking) batchList.push("Packing");
      if (this.data.selectedShipped) batchList.push("Shipped");
    }
    searchModel.OrderStatusBatchList = batchList;
    searchModel.OrderShareGuid = this.data.sharedGuid;
    searchModel.StoreGuid = app.globalData.apiLoginInfo.StoreGuid;

    return webapi.searchOrder(searchModel).then((res) => {
      if (res.Success) {
        const { ListObjects } = res.Data;
        const list = ListObjects.map(item => {
          const { OrderInfo, OrderItems } = item;
          item.guid = OrderInfo.Guid;
          OrderInfo.OrderTotal = 0;
          OrderInfo.TotalQuantity = 0;
          OrderInfo.CreatedOnFMT = util.timeStampToDateTime(OrderInfo.CreatedOn, 'Y-M-D h:m:s');
          item.isRangePrice = false;
          OrderItems.forEach(i => {
            OrderInfo.OrderTotal += i.SubTotal;
            OrderInfo.TotalQuantity += i.Quantity;
            if (!item.isRangePrice) {
              item.isRangePrice = i.PriceType === 2
            }
          });

          if (searchModel.OrderShareGuid && OrderInfo.OrderStatusCategory === "Unpaid") {
            OrderInfo.selected = true;
          }

          return item
        })
        if (searchModel.pageIndex === 0) {
          this.setData({
            orderList: list,
          });
        } else {
          this.setData({
            orderList: orderList.concat(list),
          });
        }

        return res.Data
      } else {
        wx.showToast({
          title: "网络异常",
          icon: 'none',
        });
      }
    }).catch((res) => {
      console.log("网络异常", res);
      app.hideLoading();
    });
  },
  payOrderByWechat: function (e) {
    var orderGuid = e.currentTarget.dataset.orderguid;
    var orderPayment = {
      StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
      ReferenceOrderGuid: orderGuid,
      PaymentMethod: 6    //微信支付
    };

    webapi.wechatPay(orderPayment).then((res) => {
      console.log(res, "---->wechatPay-->success");
      const orderGuid = "12343434";
      this.refresher.triggerRefresh();
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
      app.hideLoading();
    });

  },
  onOrderDetail: function (event) {
    wx.navigateTo({
      url: this.data.sharedGuid
        ? `/pages/order/detail?orderGuid=${event.currentTarget.dataset.guid}&sharedGuid=${this.data.sharedGuid}`
        : `/pages/order/detail?orderGuid=${event.currentTarget.dataset.guid}`
    });
  },
  uploadTracking: function (e) {
    var orderGuid = e.currentTarget.dataset.orderguid;
    const self = this;
    wx.chooseImage({
      count: 1, // 默认9
      sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
      sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
      success: (res) => {
        // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
        var fullPath = res.tempFilePaths[0];
        var arr = fullPath.split('/');
        var fileName = arr[arr.length - 1];
        // 上传图片
        cloudApi.webapiUploadFiles(res.tempFilePaths[0], data => {
          self.setData({ progress: { percent: 0, show: false } });
          webapi.updateOrderImage({
            OrderGuid: orderGuid,
            StoreCustomerGuid: app.globalData.apiLoginInfo.StoreCustomerGuid,
            OrderImageType: 1,
            ImageUrl: Object.values(data.Data)[0]
          }).then((res) => {
            if (res.Success) this.refresher.triggerRefresh();
            else wx.showToast({
              title: res.Message,
              icon: "none",
              duration: 4000,
            });
          });
        }, res => {
          self.setData({ progress: { percent: res.progress, show: true } });
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
  updateOrderStatus: function (OrderStatusId, CopyToStoreGuid) {
    var self = this;
    var listOrderStatus = [];
    this.getSelectedOrders().forEach(o => {
      listOrderStatus.push({ Guid: o, ReferenceOrderGuid: '', OrderStatusId: OrderStatusId, CopyToStoreGuid: CopyToStoreGuid })
    });
    webapi.BatchUpdateOrderStatus(listOrderStatus).then((res) => {
      if (res.Success) {
        if (CopyToStoreGuid.length > 0)
          wx.reLaunch({
            url: `/pages/home/index?storeGuid=${CopyToStoreGuid}`,
          });
        else {
          this.refresher.triggerRefresh();
        }
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
  onMarkAsPaid: function (event) {
    var CopyToStoreGuid = '';
    var self = this;
    if (!this.data.seller) {
      webapi.getMyAccessStores('', '', '').then((res) => {
        if (res.Success) {
          var myAccessStores = res.Data;
          var myOwnStores = [];
          for (var index = 0; index < myAccessStores.length; index++) {
            if (myAccessStores[index].IsOwner === true) {
              myOwnStores.push(myAccessStores[index]);
            }
          }
          if (myOwnStores.length === 0)
            wx.showModal({
              title: '提示',
              content: '您目前没有自己的店铺，请到www.xiaomaimaiquan.com申请您自己的店铺之后，才可以把订单复制到您店铺中并且代发货！',
              showCancel: false,
            })
          else if (myOwnStores.length === 1)
            self.updateOrderStatus(10, myOwnStores[0].StoreGuid);
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
        app.hideLoading();
      });
    } else
      this.updateOrderStatus(10, CopyToStoreGuid);
  },
  onMarkAsShipped: function (event) {
    this.updateOrderStatus(29, '');
  },
  onShareToPay() {
    const { storeInfo } = app.globalData;
    const { displayPrice, totalPayment, seller, selectedStatusCode, fromShareOrder } = this.data;
    let title = storeInfo.StoreName + ' 又有新的订单';
    let navTitle = '分享给供货商发货';
    if (!displayPrice) {
      title = storeInfo.StoreName + ' 又有新的订单了';
    } else if (totalPayment > 0) {
      title = storeInfo.StoreName + ' 又有价值¥' + totalPayment + '的新订单';
    }

    if (seller && selectedStatusCode === 'Unpaid') {
      navTitle = '分享给买家提醒付款'
      title = '你有一张未付款订单，点击查看～'
    }
    if (!seller && selectedStatusCode === 'Unpaid' && !fromShareOrder) {
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
          webapi.GetDQOrderSharePictureEx(this.getSelectedOrders(), true, "加载数据").then(res => {
            callback({
              ...res.Data,
              share: {
                title: title,
                path: `/pages/user/order?ShareGuid=${res.Data.ShareGuid}&storeGuid=${Request.getStoreGuid()}`
              }
            })
          }).catch((err) => {
            wx.showToast({
              title: '生成失败！',
            });
          });
        }
      }
    });
  },
  onMarkAsPacking: function (event) {
    var self = this;
    webapi.GetDQOrderSharePictureEx(this.getSelectedOrders(), false).then(json => {
      console.log(json, "---->onShareAppMessage");
      self.setData({
        shareGuid: json.Data.ShareGuid,
        shareImageUrl: json.Data.ImageUrl,
        displayPrice: false,
        showModal: true
      });
    }).catch((err) => {
      app.hideLoading();
      wx.showToast({
        title: '生成失败！',
      });
    });
  },
  bindGetUserInfo(event) {
    if (event && event.detail && event.detail.userInfo) {
      this.setData({ status: 'ready' });
      this.onLoad(this.data.options);
    }
  },
  changeStore(e) {
    app.changeStoreEx(e.currentTarget.dataset.storeguid)
  },
  refresherScroll(e) {
    this.setData({
      refresherScrollTop: e.detail.scrollTop
    });
  },
  onRefresh() {
    const { searchModel } = this.data;
    console.log(this.data);
    searchModel.pageIndex = 0;
    this.getOrderList().then(data => {
      this.refresher.finishPullToRefresh();
      this.getSelectedOrders(); // 更新this.data.selectedStatusCode
    });
  },
  onLoadmore() {
    const { searchModel, orderList } = this.data;
    searchModel.pageIndex += 1;
    this.getOrderList().then(data => {
      const isEnd = data.TotalCount === orderList.length || orderList.length < data.PageSize;
      this.refresher.finishLoadmore(isEnd);
    });
  },
  onSearch(e) {
    const { searchModel } = this.data;
    this.setData({
      scrollTop: 0,
      searchModel: {
        ...searchModel,
      }
    });
    this.refresher.triggerRefresh();
  },
  onCloseModal() {
    this.setData({ showModal: false });
  }
})

