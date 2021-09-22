import webApi from "../../utils/webapi"
import Config from '../../utils/config.js'
import cloudApi from "../../utils/cloudapi"
import Request from "../../utils/request";

const app = getApp()

// pages/moments/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    show: false,
    maxCount: 8, // 最大8张图片
    prefixTopic: "#我的话题# ",
    moment: "",
    vendorproduct: {},
    vendorguid:'',
    progress: {
      percent: 0,
      show: false
    },
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var self = this;
    this.setData({ vendorguid: options.vendorguid});
    if (options.vendorproduct) {
      webApi.GetVendorProduct4Publish(options.vendorproduct).then(res => {
          if (res && res.Success) {
            res.Data.PriceType = 0;
            if (res.Data.TagList.length>0)
              self.setData({ vendorproduct: res.Data, moment:'#'+res.Data.TagList[0]+'#'+res.Data.ProductName });
            else
              self.setData({ vendorproduct: res.Data, moment: res.Data.ProductName });
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
    var self = this;
    wx.chooseImage({
      count: this.data.maxCount,
      sourceType: ['album', 'camera'],
      success: res => {
        var tempFileList = res.tempFilePaths;
        tempFileList.forEach((o, index) => {
          var uploadTask = cloudApi.webapiUploadFiles(o);
          uploadTask.onProgressUpdate((res) => {
            self.setData({ progress: { percent: res.progress, show: true } });
            if (res.progress >= 100) {
              var vendorproduct = self.data.vendorproduct;
              var fullPath = o;
              var arr = fullPath.split('/');
              var fileName = arr[arr.length - 1];
              vendorproduct.PictureList.push(Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName);
              setTimeout(function () {
                self.setData({ progress: { percent: 0, show: false } });
                self.setData({ vendorproduct: vendorproduct });
              }, 2000);
            }
          });
        });
      }
    });
  },
  // 选择图片
  onChooseImage: function (event) {
    const index = event.target.dataset.index;
    var self = this;
    wx.chooseImage({
      count: 1,
      sourceType: ['album', 'camera'],
      success: res => {
        var fullPath = res.tempFilePaths[0];
        var arr = fullPath.split('/');
        var fileName = arr[arr.length - 1];
        // 上传图片
        var uploadTask = cloudApi.webapiUploadFiles(res.tempFilePaths[0]);
        uploadTask.onProgressUpdate((res) => {
          self.setData({ progress: { percent: res.progress, show: true } });
          if (res.progress >= 100) {
            var vendorproduct = self.data.vendorproduct;
            vendorproduct.PictureList[index] = Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName;
            setTimeout(function () {
              self.setData({ vendorproduct: vendorproduct });
              self.setData({ progress: { percent: 0, show: false } });
            }, 2000);
          }
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
    vendorproduct.Price = event.detail.value;
    this.setData({ vendorproduct: vendorproduct });
  },
  bindKeyMinPriceInput: function (event) {
    const index = event.target.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    vendorproduct.MinPrice = event.detail.value;
    this.setData({ vendorproduct: vendorproduct });
  },
  bindKeyMaxPriceInput: function (event) {
    const index = event.target.dataset.index;
    let vendorproduct = this.data.vendorproduct;
    vendorproduct.MaxPrice = event.detail.value;
    this.setData({ vendorproduct: vendorproduct });
  },
  // 发布Moment
  onPushMoment: function (event) {
    let vendorproduct = this.data.vendorproduct;
    let moment = this.data.moment;
    // 截取出话题
    let groupName = moment !== "" ? moment.trim ().substring(moment.indexOf("#") + 1, moment.indexOf("#", 1)) : moment;
    let model = {
      "groupName": groupName, // 话题
      "description": groupName.length > 0 ? moment.substring(groupName.length+2, moment.length) : this.data.moment.trim(),
      "status": 1,  // default 1
      "displayOrder": 0,  // default 0
      "productList": []
    }

    model.productList.push({
      "VendorProductGuid": vendorproduct.Guid,
      "VendorGuid": this.data.vendorguid,
      "productName": vendorproduct.ProductName,
      "description": vendorproduct.ProductName,
      "price": vendorproduct.PriceType == 1 ? (vendorproduct.Price == "" ? 0 : vendorproduct.Price) : 0,
      "confirmPriceRequired": vendorproduct.ConfirmPriceRequired,
      "RangePriceRequired": vendorproduct.PriceType == 2,
      "minprice": vendorproduct.PriceType == 2?(vendorproduct.MinPrice == "" ? 0 : vendorproduct.MinPrice):0,
      "maxprice": vendorproduct.PriceType == 2 ?(vendorproduct.MaxPrice == "" ? 0 : vendorproduct.MaxPrice):0,
      "status": 1,
      "displayOnHomePage": 1,
      "displayOrder": 0,
      "pictureList": vendorproduct.PictureList,
      "tagList": vendorproduct.TagList
    });
    // 保存商品
    wx.showLoading({
      title: '正在发布',
      icon: 'loading',
      mask: true,
    });
    webApi.PublishVendorProduct(model).then((res) => {
      console.log(res, "--->LoginInfo");
      wx.hideLoading();
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
        wx.navigateBack({
        });
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
      wx.hideLoading();
    });
  }
})