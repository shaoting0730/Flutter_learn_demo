import webapi from "../../utils/webapi"
import Config from '../../utils/config.js'
import cloudApi from "../../utils/cloudapi"
import Request from "../../utils/request";
import Util from "../../utils/util.js";
const app = getApp()

Page({
  data: {
    show: false,
    maxCount: 9, // 最大9张图片
    prefixTopic: "#我的话题# ",
    moment: "",
    vendorproduct: {},
    vendorguid: '',
    progress: {
      percent: 0,
      show: false
    },
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onLoad: function (options) {
    var self = this;
    this.setData({ vendorguid: options.vendorguid });
    if (options.vendorproduct) {
      webapi.GetVendorProduct4Publish(options.vendorproduct).then(res => {
        if (res && res.Success) {
          res.Data.PriceType = 0;
          // if (res.Data.TagList.length > 0)
          //     self.setData({vendorproduct: res.Data, moment: '#' + res.Data.TagList[0] + '#' + res.Data.ProductName});
          // else
          self.setData({ vendorproduct: res.Data, moment: res.Data.ProductName ? `#我的话题# ${res.Data.ProductName}` : '' });
        }
      });
    }
  },
  // 添加动态，获取焦点事件
  bindAddMomentFocus: function (event) {
    const text = event.detail.value;
    if (text === "") {
      this.setData({ moment: this.data.prefixTopic });
    }
  },
  // 添加动态
  bindAddMoment: function (event) {
    this.setData({ moment: event.detail.value });
  },
  // 添加
  onAddImage: function () {
    wx.chooseImage({
      count: this.data.maxCount,
      sourceType: ['album', 'camera'],
      success: res => {
        const tempFileList = res.tempFilePaths;
        const progress = {};
        Promise.all(tempFileList.map((fullPath, index) => {
          return cloudApi.webapiUploadFiles(fullPath, null, (res) => {
            progress[index] = res.progress;
            this.setData({
              progress: {
                percent: (Object.values(progress).reduce((a, b) => a + b) / tempFileList.length).toFixed(2),
                show: true
              }
            });
          });
        })).then(result => {
          var vendorproduct = this.data.vendorproduct;
          result.forEach((data, index) => {
            vendorproduct.PictureList.push(Object.values(data.Data)[0]);
          })
          this.setData({
            vendorproduct: vendorproduct,
            progress: { percent: 0, show: false }
          });
        })
      }
    });
  },
  // 选择图片
  onChooseImage: function (event) {
    const index = event.target.dataset.index;
    wx.chooseImage({
      count: 1,
      sourceType: ['album', 'camera'],
      success: res => {
        // 上传图片
        cloudApi.webapiUploadFiles(res.tempFilePaths[0], (data) => {
          const vendorproduct = this.data.vendorproduct;
          vendorproduct.PictureList[index] = Object.values(data.Data)[0];
          this.setData({
            vendorproduct: vendorproduct,
            progress: { percent: 0, show: false }
          });
        }, (res) => {
          this.setData({ progress: { percent: res.progress, show: true } });
        });
      }
    });
  },
  // 添加商品描述
  bindAddProductDesc: function (event) {
    const index = event.target.dataset.index;
    this.data.vendorproduct.description = event.detail.value;
  },
  onOpenPriceClick: function (event) {
    const index = event.currentTarget.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    vendorproduct.PriceType = 0;
    this.setData({ vendorproduct: vendorproduct });
  },
  onFixPriceClick: function (event) {
    const index = event.currentTarget.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    vendorproduct.PriceType = 1;
    this.setData({ vendorproduct: vendorproduct });
  },
  onRangePriceClick: function (event) {
    const index = event.currentTarget.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    vendorproduct.PriceType = 2;
    this.setData({ vendorproduct: vendorproduct });
  },
  // 待确认价格商品
  onChange: function (event) {
    const index = event.currentTarget.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    vendorproduct.ConfirmPriceRequired = !vendorproduct.ConfirmPriceRequired;
    this.setData({ vendorproduct: vendorproduct });
  },
  // 价格
  bindKeyPriceInput: function (event) {
    const index = event.target.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    const { value } = event.detail;
    if(Util.isNumber(value)){
      vendorproduct.Price = value;
    }
    this.setData({ vendorproduct: vendorproduct });
  },
  bindKeyMinPriceInput: function (event) {
    const index = event.target.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    const { value } = event.detail;
    if(Util.isNumber(value)){
      vendorproduct.MinPrice = value;
    }
    this.setData({ vendorproduct: vendorproduct });
  },
  bindKeyMaxPriceInput: function (event) {
    const index = event.target.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    const { value } = event.detail;
    if(Util.isNumber(value)){
      vendorproduct.MaxPrice = value;
    }
    this.setData({ vendorproduct: vendorproduct });
  },
  // 发布Moment
  onPushMoment: function (event) {
    let vendorproduct = this.data.vendorproduct;
    let moment = this.data.moment;
    // 截取出话题
    let groupName = moment !== "" ? moment.trim().substring(moment.indexOf("#") + 1, moment.indexOf("#", 1)) : moment;
    let model = {
      "groupName": groupName, // 话题
      "description": groupName.length > 0 ? moment.substring(groupName.length + 2, moment.length) : this.data.moment.trim(),
      "status": 1,  // default 1
      "displayOrder": 0,  // default 0
      "productList": []
    }

    model.productList.push({
      "VendorProductGuid": vendorproduct.Guid,
      "VendorGuid": this.data.vendorguid,
      "productName": vendorproduct.ProductName,
      "description": vendorproduct.description,
      "myprice": vendorproduct.PriceType == 1 ? (vendorproduct.Price == "" ? 0 : vendorproduct.Price) : 0,
      "confirmPriceRequired": vendorproduct.ConfirmPriceRequired,
      "RangePriceRequired": vendorproduct.PriceType == 2,
      "myminprice": vendorproduct.PriceType == 2 ? (vendorproduct.MinPrice == "" ? 0 : vendorproduct.MinPrice) : 0,
      "mymaxprice": vendorproduct.PriceType == 2 ? (vendorproduct.MaxPrice == "" ? 0 : vendorproduct.MaxPrice) : 0,
      "status": 1,
      "displayOnHomePage": 1,
      "displayOrder": 0,
      "pictureList": vendorproduct.PictureList,
      "tagList": vendorproduct.TagList
    });
    // 保存商品
    webapi.PublishVendorProduct(model).then((res) => {
      console.log(res, "--->LoginInfo");
      if (res.Success) {
        app.globalData.productTagList = res.Data;
        const pages = getCurrentPages();
        if (pages.length > 0) {
          var previousPage = pages[pages.length - 2];
          if (previousPage.data.selectedProducts) {
            if (previousPage.data.selectedProducts.length > 0) {
              previousPage.setData({ selectedProducts: [] });
            }
          }
        }
        wx.showToast({
          title: '发布成功！',
          duration: 2000,
        });
        wx.navigateBack({});
      } else {
        console.log(res, "数据状态");
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
  },
  toTags(e) {
    wx.navigateTo({
      url: '/pages/tags/index',
      events: {
        getTag: (callback) => {
          callback(this.data.vendorproduct.TagList)
        },
        setTage: (tags) => {
          this.setData({
            vendorproduct: {
              ...this.data.vendorproduct,
              TagList: tags
            }
          })
        }
      }
    });
  }
})
