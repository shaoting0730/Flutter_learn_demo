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
      addedVideos:0,
      maxCount: 8, // 最大九张图片
      prefixTopic: "#我的话题# ",
      moment: "",
      products: [],
      pictures: [],
      progress: {
        percent: 0,
        show: false
      },
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
      const pages = getCurrentPages();
      var self = this;
      if(pages.length>0)
      {
        var previousPage = pages[pages.length-2];
        if (previousPage.data.selectedProducts)
        {
          if (previousPage.data.selectedProducts.length>0)
          {
            webApi.searchDQProduct({ ProductGuid: previousPage.data.selectedProducts }).then(res => {
              console.log("moment res:", res);
              if (res && res.Success) {
                res.Data.ListObjects.forEach(o=>{
                  o.PriceType = 0;
                });
                self.setData({ products: res.Data.ListObjects });
              }
            });
          }
        }
      }
    },
    // 添加动态，获取焦点事件
    bindAddMomentFocus: function (event) {
        const text = event.detail.value;
        if (text === "") {
            this.setData({moment: this.data.prefixTopic});
        }
    },
    // 添加动态
    bindAddMoment: function (event) {
        this.setData({moment: event.detail.value});
    },
    onAddVideoProduct: function () {
      let data = this.data.products;
      var self = this;
      wx.chooseVideo({
        sourceType: ['album', 'camera'],
        maxDuration: 60,
        camera: 'back',
        success: res1 => {
          var uploadTask = cloudApi.webapiUploadFiles(res1.tempFilePath);
            uploadTask.onProgressUpdate((res) => {
            self.setData({ progress: { percent: res.progress, show: true } });
            if (res.progress >= 100) {
              let productList = [];
              var fullPath = res1.tempFilePath;
              var arr = fullPath.split('/');
              var fileName = arr[arr.length - 1];
              productList.push({
                description: "",
                price: "",
                fileName: fileName,
                PriceType: 0,
                ConfirmPriceRequired: true,
                RangePriceRequired: false,
                MinPrice: "",
                MaxPrice: "",
                Status: 1,
                DisplayOnHomePage: 1,
                DisplayOrder: 0,
                PictureList:[],
                VideoUrl: Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName,
                TagList: []
              });
              setTimeout(function () {
                self.setData({ progress: { percent: 0, show: false } });
                data = [...data, ...productList];
                self.setData({ products: data, addedVideos:1 });
              }, 2000);
            }
          });
        }
      });
    },
    // 添加商品
    onAddProduct: function () {
        let data = this.data.products;
        var self = this;
        wx.chooseImage({
            count: this.data.maxCount,
            sourceType: ['album', 'camera'],
            success: res => {
              var tempFileList = res.tempFilePaths;
              tempFileList.forEach((o, index)=>{
                var uploadTask = cloudApi.webapiUploadFiles(o);
                uploadTask.onProgressUpdate((res) => {
                  self.setData({ progress: { percent: res.progress, show: true } });
                  if (res.progress >= 100) {
                    let productList = [];
                    var fullPath = o;
                    var arr = fullPath.split('/');
                    var fileName = arr[arr.length - 1];
                    productList.push({
                      description: "",
                      price: "",
                      fileName: fileName,
                      PriceType: 0,
                      ConfirmPriceRequired: true,
                      RangePriceRequired: false,
                      MinPrice: "",
                      MaxPrice: "",
                      Status: 1,
                      DisplayOnHomePage: 1,
                      DisplayOrder: 0,
                      PictureList: [Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName],
                      TagList: []
                    });
                    setTimeout(function () {
                      self.setData({ progress: { percent: 0, show: false } });
                      data = [...data, ...productList];
                      self.setData({ products: data });                      
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
              let productList = this.data.products;
              var fullPath = res.tempFilePaths[0];
              var arr = fullPath.split('/');
              var fileName = arr[arr.length - 1];
              // 上传图片
              var uploadTask = cloudApi.webapiUploadFiles(res.tempFilePaths[0]);
              uploadTask.onProgressUpdate((res) => {
                self.setData({ progress: { percent: res.progress, show: true } });
                if (res.progress >= 100) {
                  productList[index].imagePath = Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName;
                  productList[index].fileName = fileName,
                  setTimeout(function () {
                    self.setData({ progress: { percent: 0, show: false } });
                    self.setData({ products: productList });
                  }, 2000);
                }
              });

            }
        });
    },
    // 添加商品描述
    bindAddProductDesc: function (event) {
      const index = event.target.dataset.index;
      this.data.products[index].description = event.detail.value;
    },
  onOpenPriceClick: function (event) {
    const index = event.currentTarget.dataset.index;
    let productList = this.data.products;
    productList[index].PriceType = 0;
    this.setData({ products: productList });
  },
  onFixPriceClick: function (event) {
    const index = event.currentTarget.dataset.index;
    let productList = this.data.products;
    productList[index].PriceType = 1;
    this.setData({ products: productList });
  },
  onRangePriceClick: function (event) {
    const index = event.currentTarget.dataset.index;
    let productList = this.data.products;
    productList[index].PriceType = 2;
    this.setData({ products: productList });
  },
    // 待确认价格商品
    onChange: function (event) {
      const index = event.currentTarget.dataset.index;
      let productList = this.data.products;
      productList[index].ConfirmPriceRequired = !productList[index].ConfirmPriceRequired;
      this.setData({ products: productList });
    },
    // 价格
    bindKeyPriceInput: function (event) {
      const index = event.target.dataset.index;
      let productList = this.data.products;
      productList[index].Price = event.detail.value;
      this.setData({ products: productList });
    },
    bindKeyMinPriceInput: function (event) {
      const index = event.target.dataset.index;
      let productList = this.data.products;
      productList[index].MinPrice = event.detail.value;
      this.setData({ products: productList });
    },
    bindKeyMaxPriceInput: function (event) {
      const index = event.target.dataset.index;
      let productList = this.data.products;
      productList[index].MaxPrice = event.detail.value;
      this.setData({ products: productList });
    },
    // 发布Moment
    onPushMoment: function (event) {
        let productList = this.data.products;
        let moment = this.data.moment;
        // 截取出话题
        let groupName = moment !== "" ? moment.trim().substring(moment.indexOf("#") + 1, moment.indexOf("#", 1)) : moment;
        let model = {
            "groupName": groupName, // 话题
            "description": groupName.length > 0 ? moment.substring(groupName.length+2,moment.length):this.data.moment.trim(),
            "status": 1,  // default 1
            "displayOrder": 0,  // default 0
            "productList": []
        }

        for (let i = 0; i < productList.length; i++) {
            model.productList.push({
              "guid": productList[i].guid,
              "productName": "",
              "description": productList[i].description,
              "price": productList[i].PriceType == 1 ? (productList[i].Price == "" ? 0 : productList[i].Price) : 0,
              "RangePriceRequired": productList[i].PriceType == 2,
              "minprice": productList[i].PriceType == 2 ? (productList[i].MinPrice == "" ? 0 : productList[i].MinPrice) : 0,
              "maxprice": productList[i].PriceType == 2 ? (productList[i].MaxPrice == "" ? 0 : productList[i].MaxPrice) : 0,
              "confirmPriceRequired": productList[i].ConfirmPriceRequired,
              "status": 1,
              "displayOnHomePage": 1,
              "displayOrder": i,
              "pictureList": productList[i].PictureList,
              "VideoUrl": productList[i].VideoUrl,
              "tagList": productList[i].tagList
            })
        }
        // 保存商品
        wx.showLoading({
            title: '正在发布',
            icon: 'loading',
            mask: true,
        });
        webApi.addNewMoment(model).then((res) => {
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
                app.globalData.moments = [];
                app.globalData.productGroupNames = [];
                app.globalData.photoWallList = [];
                wx.redirectTo({
                    url: '/pages/home/index',
                })
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