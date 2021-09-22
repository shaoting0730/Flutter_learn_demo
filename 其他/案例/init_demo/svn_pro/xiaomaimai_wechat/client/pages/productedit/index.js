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
      products: [],
      progress: {
        percent: 0,
        show: false
      },
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
      var that = this;
        const productId = options.productId;
        let productGuid = [];
        productGuid.push(productId);
        webApi.searchDQProduct({ProductGuid: productGuid}).then(res => {
            console.log("moment res:", res);
            if(res && res.Success) {
              if (res.Data.ListObjects[0].Price == 0 && res.Data.ListObjects[0].MinPrice == 0 && res.Data.ListObjects[0].MaxPrice==0)
                res.Data.ListObjects[0].PriceType = 0;
              else if (res.Data.ListObjects[0].MinPrice > 0 && res.Data.ListObjects[0].MaxPrice > 0)
                res.Data.ListObjects[0].PriceType = 2;
              else if (res.Data.ListObjects[0].Price>0)
                res.Data.ListObjects[0].PriceType = 1;
              else
                res.Data.ListObjects[0].PriceType = 0;
              this.setData({ products: res.Data.ListObjects,
             });
            }
        });
    },
    // 添加商品图片
    onAddImage: function () {
        let data = this.data.products;
        var self = this;
        wx.chooseImage({
            sourceType: ['album', 'camera'],
            success: res => {
              var tempFileList = res.tempFilePaths;
              var countdown = tempFileList.length;
              tempFileList.forEach((o, index) => {
                var uploadTask = cloudApi.webapiUploadFiles(o);
                uploadTask.onProgressUpdate((res) => {
                  self.setData({ progress: { percent: res.progress, show: true } });
                  if (res.progress >= 100) {
                    let productList = [];
                    var fullPath = o;
                    var arr = fullPath.split('/');
                    var fileName = arr[arr.length - 1];
                    data[0].PictureList.push(Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName);
                    setTimeout(function () {
                      self.setData({ progress: { percent: 0, show: false } });
                      countdown--;
                      if(countdown==0)
                        self.setData({ products: data });
                    }, 2000);
                  }
                });
              });
            }
        });
    },
  onRemovePicture: function (event) {
    var products = this.data.products;
    const index = event.currentTarget.dataset.index;
    webApi.RemoveDQProductPicture({ ProductGuid: this.data.products[0].Guid, PictureUrl: this.data.products[0].PictureList[index]}).then((res)=>{
      if(res.Success)
      {
        products[0].PictureList.splice(index, 1);
        this.setData({ products: products});
      }
      else
      {
        wx.showToast({
          title: res.Data.Message,
          content
        })
      }
    }).catch((res)=>{
      wx.showToast({
        title: JSON.stringify(res),
        content
      })

    });
  },
    // 预览
  onPreviewImage: function (event) {
    var self = this;
    const index = event.currentTarget.dataset.index;
    wx.previewImage({
      current: this.data.products[0].PictureList[index],
      urls: this.data.products[0].PictureList,
    });
  },
    // 添加商品描述
    bindAddProductDesc: function (event) {
      var products = this.data.products;
      products[0].Description = event.detail.value;
      this.setData({ products: products});
    },
  onOpenPriceClick: function (event) {
    var products = this.data.products;
    products[0].PriceType = 0;
    this.setData({ products: products });
  },
  onFixPriceClick: function (event) {
    var products = this.data.products;
    products[0].PriceType = 1;
    this.setData({ products: products });
  },
  onRangePriceClick: function (event) {
    var products = this.data.products;
    products[0].PriceType = 2;
    this.setData({ products: products });
  },
  
    // 隐藏价格商品
    onChange: function (event) {
      var products = this.data.products;
      products[0].ConfirmPriceRequired = !products[0].ConfirmPriceRequired;
      this.setData({ products: products });
    },
    // 价格
    bindKeyPriceInput: function (event) {
      var products = this.data.products;
      products[0].Price = event.detail.value;
      this.setData({ products: products });
    },
    bindKeyMinPriceInput: function (event) {
      var products = this.data.products;
      products[0].MinPrice = event.detail.value;
      this.setData({ products: products });
    },
    bindKeyMaxPriceInput: function (event) {
      var products = this.data.products;
      products[0].MaxPrice = event.detail.value;
      this.setData({ products: products });
    },
    // 发布Moment
    onSaveProduct: function (event) {
        wx.showLoading({
            title: '正在保存',
            icon: 'loading',
            mask: true,
        });
      this.data.products[0].Price = this.data.products[0].PriceType == 1 ? (this.data.products[0].Price == "" ? 0 : this.data.products[0].Price) : 0;
      this.data.products[0].RangePriceRequired = this.data.products[0].PriceType == 2;
      this.data.products[0].Minprice = this.data.products[0].PriceType == 2 ? (this.data.products[0].MinPrice == "" ? 0 : this.data.products[0].MinPrice) : 0;
      this.data.products[0].Maxprice = this.data.products[0].PriceType == 2 ? (this.data.products[0].Maxprice == "" ? 0 : this.data.products[0].Maxprice) : 0;
        webApi.updateDQProduct(this.data.products[0]).then((res) => {
            console.log(res, "--->LoginInfo");
            wx.hideLoading();
            if (res.Success) {
                app.globalData.productTagList = res.Data;
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
    /* 预览图片 */
    /*onPreviewImage: function(event) {
        let index = event.target.dataset.index;
        let products = this.data.products;
        let previewData = [];
        products.forEach(value => {
           previewData.push(value.imagePath);
        });

        wx.previewImage({
            current: previewData[index],
            urls: previewData
        })
    }*/
})