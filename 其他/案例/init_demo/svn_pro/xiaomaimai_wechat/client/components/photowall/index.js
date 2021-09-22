import webApi from '../../utils/webapi'
import cloudApi from "../../utils/cloudapi";
import Config from "../../utils/config";
import Request from "../../utils/request";

const app = getApp()
// components/photowall/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        photoWallList: {
            type: Array,
            value: []
        },
        wishList: {
            type: Array,
            value: []
        },
        shoppingCart: {
            type: Array,
            value: []
        },
        total: {
            type: Number,
            value: 0
        },
        totalQuantity: {
            type: Number,
            value: 0
        },
        seller: {
            type: Boolean,
            value: false
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        select: false,
        collapse: false,
        wishList: [],
        uploadMaxCount: 100,
        progress: {
            percent: 0,
            show: false
        },
        mergeList: []
    },

    /**
     * 组件的方法列表
     */
    methods: {
        onSelect: function (event) {
          const pages = getCurrentPages();
          const homePage = pages[pages.length-1];
          homePage.setData({ showFooter: this.data.select, selecting: !this.data.select });
          this.setData({ select: !this.data.select, mergeList:[] });
          this.onCleanupSelection();
          this.reloadPhotoWall();
        },
        onPreviewPhoto: function (event) {
            const guid = event.target.dataset.guid;
            wx.navigateTo({
              url: '/pages/showdetails/index?pid=' + guid
            })
        },
        onAddToCart: function (event) {
          const guid = event.currentTarget.dataset.guid;
          const pages = getCurrentPages();
          const homePage = pages[pages.length - 1];
          homePage.refreshProductStatus(guid, 1, true);
          let quantity = 1;
          webApi.addToShoppingCart(guid, quantity).then(res => {
              if(res && res.Success) {
                  wx.showToast({
                    title: '添加购物车成功！',
                  });
                homePage.onLoadShoppingCart();
              }
              else
              {
                wx.showToast({
                  title: '添加购物车失败！',
                });
                this.reloadPhotoWall();
              }
          }).catch((res) => {
            wx.showToast({
              title: '添加购物车失败！',
            });
            this.reloadPhotoWall();
          });
        },
        onAddToWishList: function (event) {
            const guid = event.currentTarget.dataset.guid;
            let wishList = app.globalData.wishList;
            wishList = wishList.concat(guid);
            app.globalData.wishList = wishList;
            const pages = getCurrentPages();
            const homePage = pages[pages.length - 1];
            homePage.refreshProductStatus(guid, 2, true);
            webApi.addToWishList(guid).then(res => {
                if(res && res.Success) {
                  wx.showToast({
                    title: '添加收藏成功！',
                  });                  
                }
                else
                {
                  wx.showToast({
                    title: '添加收藏失败！',
                  });
                }
            }).catch((res) => {
              wx.showToast({
                title: '添加收藏失败！',
              });                  
            });
          ///this.reloadPhotoWall();
        },
        onRemoveFromWishList: function (event) {
          const guid = event.currentTarget.dataset.guid;
          let wishList = app.globalData.wishList;
          app.globalData.wishList = wishList.filter(item => item !== guid);
          const pages = getCurrentPages();
          const homePage = pages[pages.length - 1];
          homePage.refreshProductStatus(guid, 2, true);
          webApi.removeProductFromWishList(guid).then(res => {
          });
        },
        onChangeCart: function (event) {
            const guid = event.currentTarget.dataset.guid;
            const quantity = event.detail;
            this.UpdateCart(guid, quantity);
        },
        UpdateCart: function(guid, quantity) {
          webApi.updateShoppingCart(app.globalData.userInfo, guid, quantity).then(res => {
              if(res && res.Success) {
                const pages = getCurrentPages();
                const homePage = pages[pages.length - 1];
                homePage.onLoadShoppingCart();
              }
          });
        },
        onCheckout: function(event) {
            const list = this.properties.shoppingCart;
            let productCodeList = [];
            list.forEach(s => productCodeList.push(s.ProductCode));
            if (productCodeList.length == 0) {
                wx.showToast({
                    title: '请选择要结算的商品！',
                    duration: 2000
                });
                return false;
            } else {
                wx.navigateTo({
                    url: '/pages/order/pay?productData=' + JSON.stringify(productCodeList)
                })
            }

        },
        reloadPhotoWall: function() {
          const pages = getCurrentPages();
          const homePage = pages[pages.length-1];
          homePage.onLoadPhotoWall();
        },
        onToggleCart: function () {
          const pages = getCurrentPages();
          const homePage = pages[pages.length-1];
          homePage.setData({ showFooter: !this.data.collapse })
          this.setData({ collapse: !this.data.collapse })
        },
        onClickBackDrop: function () {
            this.onToggleCart();
        },
        onClearCart: function (event) {
          const carts = this.properties.shoppingCart;
          const pages = getCurrentPages();
          const homePage = pages[pages.length - 1];
          carts.forEach(p => {
            webApi.updateShoppingCart(app.globalData.userInfo, p.ProductCode, 0);
            homePage.refreshProductStatus(p.ProductCode,1,false);
          });
          this.properties.shoppingCart = [];
          homePage.onLoadShoppingCart();
        },
        onUploadProducts: function (event) {
          var self = this;
            wx.chooseImage({
                count: this.data.uploadMaxCount,
                sourceType: ['album', 'camera'],
                success: res => {
                  // upload
                  var tmpFileList = res.tempFilePaths;
                  var countdown = tmpFileList.length;
                  tmpFileList.forEach((item, index) => {
                    const uploadTask = cloudApi.webapiUploadFiles(item);
                    uploadTask.onProgressUpdate((res) => {
                      self.setData({ progress: { percent: res.progress, show: true } });
                      if (res.progress >= 100) {
                        let productList = [];
                        var fullPath = item;
                        var arr = fullPath.split('/');
                        var fileName = arr[arr.length - 1];
                        productList.push({
                          "ProductName": "上传产品",
                          "Description": "",
                          "Price": 0,
                          "ConfirmPriceRequired": true,
                          "Status": 1,
                          "DisplayOnHomePage": 1,
                          "DisplayOrder": index,
                          "PictureList": [Config.serverFileRoot + Request.getStoreGuid() + "/" + fileName],
                          "TagList": []
                        });
                        setTimeout(function () {
                          self.setData({ progress: { percent: 0, show: false } });
                          countdown--;
                          webApi.addNewDQProduct(productList).then(res => {
                            console.log("add product: ", res);
                          });
                        }, 2000);
                      }
                    });
                  });
                  var id = setInterval(function () {
                    //定时执行的代码
                    if (countdown==0)
                    {
                      wx.redirectTo({
                        url: '/pages/home/index?active=1'
                      });
                      clearInterval(id);//关闭定时器  
                    }
                  }, 1000);
                }
            });
        },
        onCleanupSelection:function(){
          const pages = getCurrentPages();
          this.setData({ mergeList: [] });
          pages[pages.length - 1].setData({ selectedProducts: [] });
        },
        onPreMerge: function(event) {
          const pages = getCurrentPages();
          const guid = event.currentTarget.dataset.guid;
          const photowallList = this.properties.photoWallList;
          photowallList.forEach(pw => {
              pw[1].forEach(p => {
                  if(p.product.Guid === guid) {
                    p.merge = !p.merge;
                    let list = this.data.mergeList;
                    if(p.merge) {
                        list.push(guid);
                    } else {
                        list = list.filter(item => item !== guid);
                    }
                    this.setData({ mergeList: list });
                    pages[pages.length - 1].setData({ selectedProducts: list});
                  }
              })
          });
          const homePage = pages[pages.length - 1];
          homePage.setData({ photoWallList: photowallList });
        },
        onMerge: function (event) {
          webApi.mergeDQProducts(this.data.mergeList).then(res => {
              console.log("merge list: ", res);
          });
          this.onCleanupSelection();
          app.globalData.moments = [];
          app.globalData.productGroupNames = [];
          app.globalData.photoWallList = [];
          wx.redirectTo({
            url: '/pages/home/index?active=1'
          });
      },
      onUnPublish: function (event) {
         webApi.removeDQProduct(this.data.mergeList).then(res => {
          console.log("remove list: ", res);
        });
        this.onCleanupSelection();
        app.globalData.moments = [];
        app.globalData.productGroupNames = [];
        app.globalData.photoWallList = [];
        wx.redirectTo({
          url: '/pages/home/index?active=1'
        });
      },
      onGroupPublish: function (event) {
        wx.navigateTo({
          url: '/pages/moments/index',
        });
      },
    }
})
