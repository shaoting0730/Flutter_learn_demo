import webApi from "../../utils/webapi"
import util from "../../utils/util"
const app = getApp()

//index.js
//获取应用实例

Page({
    data: {
        userInfo: {},
        storeInfo:{},
        hasUserInfo: false,
        canIUse: wx.canIUse('button.open-type.getUserInfo'),
        active: 0,
        tabBar_active: 0,
        value: "",
        moments: [],
        productGroupNames: [],
        productTags: [],
        photoWallList: [],
        queryModel: {},
        search_inline: false,
        showFooter: true,
        shoppingCart: [],
        totalForCart: 0,
        totalQuantity: 0,
        seller: false,
        selecting:false,
        selectedProducts:[],
    },
    //事件处理函数
    bindViewTap: function () {
        wx.navigateTo({
            url: '../logs/logs'
        })
    },
  btnShare: function(){
    wx.navigateTo({
      url: '/pages/share-to-friend/index',
    });
  },
    onShow: function () {
        this.selectComponent('#searchbox').onInit();
        this.setData({
          tabBar_active:0,
        });
        this.setData({
          totalQuantity:app.globalData.shoppingCartCount,
        });
    },
    initPage: function (options){
      var self = this;
      self.setData({
        seller: app.globalData.seller, storeInfo: app.globalData.storeInfo, userInfo: app.globalData.userInfo,
      });
      if (options.OwnerRegister) {
        webApi.RegisterAsOwner(options.OwnerRegister).then((res) => {
          if (res.Success) {
            webApi.retrieveStoreInfo().then((res2) => {
              if (res2.Success) {
                app.globalData.storeInfo = res2.Data;
                app.globalData.seller = app.globalData.storeInfo == null ? false : app.globalData.storeInfo.OwnerGuid == app.globalData.apiLoginInfo.StoreCustomerGuid;
              }
              self.setData({
                seller: app.globalData.seller, storeInfo: app.globalData.storeInfo,
              });
            });
          }
          else {
            wx.showModal({
              title: '提示',
              content: res.Message,
            })
          }
        });
      }
      if(app.globalData.moments.length==0)
      {
        wx.showLoading({
          title: '刷新中。。。',
        });
        this.onLoadProductGroupList();
      }
      else
      {
        let productTags = new Set();
        if (app.globalData.productTagList) {
          app.globalData.productTagList.forEach(t => productTags.add({
            tagName: t.ProductTag,
            active: false
          }))
        }
        this.setData({ productTags: Array.from(productTags), moments: app.globalData.moments, productGroupNames: app.globalData.productGroupNames, photoWallList: app.globalData.photoWallList });

      }
      if (app.globalData.hometimerId != null)
        clearInterval(app.globalData.hometimerId)
      var id = setInterval(function () {
        if (!self.data.selecting)
          self.onLoadProductGroupList();
      }, 10000);
      app.globalData.hometimerId = id;      
    },
    onLoad: function (options) {
      if (options.active) {
        this.trigerChange(parseInt(options.active));
        if (options.ShareProductGuid)
          this.setData({ queryModel: { ShareGroupKey: options.ShareProductGuid } });
        this.setData({ active: options.active });
      }
      if(options.storeGuid && options.storeName)
      {
        app.globalData.storeName = options.storeName;
        app.globalData.storeGuid = options.storeGuid;
        app.globalData.userInfo = null;
        app.globalData.apiLoginInfo = null;
        app.globalData.productTagList = null;
        app.globalData.wishList = [];
        app.globalData.shippingCost = 0;
        app.globalData.storeInfo = null;
      }
      if (app.globalData.storeName == null || app.globalData.storeGuid==null)
      {
        wx.redirectTo({
          url: '/pages/home/choosestore',
        });
        return;
      }
      if (app.globalData.userInfo)
      {
        this.setData({
          needAuthor: false,
        });
        this.initPage(options);
      }
      else
      {
        var self = this;
        //调用应用实例的方法获取全局数据
        wx.getSetting({
          success: (res) => {
            if (res.authSetting['scope.userInfo']) {
              self.setData({
                needAuthor: false,
              });
              // 已经授权，可以直接调用 getUserInfo 获取头像昵称
              app.getUserInfo((userInfo) => {
                self.initPage(options);
              });
            } else {
              this.setData({
                needAuthor: true
              });
            }
          }
        });
      }
    },
    onLoadProductGroupList: function (event) {
        // 加载首页动态
        let queryModel = this.data.queryModel;
        console.log(queryModel);
        webApi.searchDQProductGroup(queryModel)
            .then(res => {
              wx.hideLoading();
                if (res && res.Success) {
                    let list = res.Data.ListObjects;
                    list.forEach((val, key) => {
                      if(val.Advertisement)
                      {
                        val.GroupName = '广告';
                        val.Description = val.Advertisement.Description;
                        val.UpdatedOn = util.timeStampToDateTime(val.UpdatedOn, 'M-D');
                      }
                      else
                      {
                        val.Description = val.Description.substring(val.Description.indexOf(" ") + 1);
                        val.UpdatedOn = util.timeStampToDateTime(val.UpdatedOn, 'M-D');
                      }
                    });
                    /*for (let i = 0; i < list.length; i++) {
                        list[i].Description = list[i].Description.substring(list[i].Description.indexOf(" ") + 1);
                    }*/
                    this.setData({moments: list});
                    app.globalData.moments = list;
                    this.onLoadMomentTopics();

                    let productTags = new Set();
                    if (app.globalData.productTagList) {
                        app.globalData.productTagList.forEach(t => productTags.add({
                            tagName: t.ProductTag,
                            active: false
                        }))
                    }
                    this.setData({productTags: Array.from(productTags)});
                    this.onLoadPhotoWall();
                }
            });
    },
    refreshProductStatus: function(productGuid, isForCartOrWishList, isAdd){
      var photoWallList = this.data.photoWallList;
      switch (isForCartOrWishList)
      {
        case 1:///forCart
        {
            var foundProduct = false;
            for (var i = 0; i < photoWallList.length;i++)
            {
              for(var j=0;j<photoWallList[i][1].length;j++)
              {
                if (photoWallList[i][1][j].product.Guid == productGuid) {
                  foundProduct = true;
                  photoWallList[i][1][j].addedToCart = isAdd;
                  break; 
                }
              }
              if (foundProduct)
                break;
            }
            this.setData({ photoWallList: photoWallList });
            app.globalData.photoWallList = this.data.photoWallList;
        }
        break;
        case 2:///for WishList
        {
            var foundProduct = false;
            for (var i = 0; i < photoWallList.length; i++) {
              for (var j = 0; j < photoWallList[i][1].length; j++) {
                if (photoWallList[i][1][j].product.Guid == productGuid) {
                  foundProduct = true;
                  photoWallList[i][1][j].favorite = app.globalData.wishList.includes(productGuid);
                  break;
                }
              }
              if (foundProduct)
                break;
            }
            this.setData({ photoWallList: photoWallList });
            app.globalData.photoWallList = this.data.photoWallList;
        }
        break;
      }
    },
    onLoadPhotoWall: function () {
      this.onLoadShoppingCart();
      if (this.data.selecting && app.globalData.seller)
        return;
      webApi.searchDQProduct(this.data.queryModel)
          .then(res => {
              if (res && res.Success) {
                  let wishList = app.globalData.wishList;
                  let cartList = [];
                  this.data.shoppingCart.forEach(c => cartList.push(c.ProductCode));
                  let list = res.Data.ListObjects;
                  let productList = [];
                  list.forEach(p => productList.push({
                      date: util.timeStampToDateTime(p.UpdatedOn, 'Y-M-D'),
                      product: p,
                      favorite: wishList.includes(p.Guid),
                      addedToCart: cartList.includes(p.Guid)
                  }))

                  let result = util.groupBy(productList, 'date');
                  this.setData({photoWallList: Object.entries(result)});
                  app.globalData.photoWallList = this.data.photoWallList;
              }
          });
    },
    onLoadMomentTopics: function () {
        let list = new Set();
        webApi.loadMomentTopics().then(res => {
            if (res && res.Success) {
                res.Data.forEach(d => list.add({
                    groupName: d.TopicName,
                    active: false
                }));
              this.setData({productGroupNames: Array.from(list)});
              app.globalData.productGroupNames = this.data.productGroupNames;
            }
        });
    },
    onLoadShoppingCart: function () {
        let list = [];
        let total = 0;
        let quantity = 0;
        webApi.loadShoppingCart().then(res => {
            if (res && res.Success) {
                res.Data.forEach(p => {
                    p.SubTotal = (p.ProductOnSalePrice * p.Quantity).toFixed(1);
                    list.push(p);
                    total += parseFloat(p.SubTotal);
                    quantity += parseInt(p.Quantity);
                });
                this.setData({
                    totalQuantity: quantity,
                    totalForCart: total.toFixed(1),
                    shoppingCart: list
                });
                app.globalData.shoppingCartCount = quantity;
            }
        })
    },
    bindGetUserInfo: function () {
        wx.showLoading({
            title: '正在登录',
            icon: 'loading',
            mask: true,
        });
        app.getUserInfo((userInfo) => {
            console.log(userInfo, "---->userInfo");
            //更新数据
            this.setData({
                userInfo: userInfo,
                needAuthor: false,
              seller: app.globalData.seller,
              storeInfo: app.globalData.storeInfo,
            });
          this.initPage({});
        });
    },
    trigerChange: function(index)
    {
      this.setData({ queryModel:{}});
      if (index === 1) {
        this.setData({ showFooter: false, search_inline: true, active: index });
      } else {
        this.setData({ search_inline: false, showFooter: true, active: index });
      }
      // 初始化搜索框状态
      this.selectComponent('#searchbox').onInit();
    },
    onChange(event) {
      let index = event.detail.index;
      this.trigerChange(index);
    }
})
