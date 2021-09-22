import webapi from "../../utils/webapi";
import util from "../../utils/util";
import Request from "../../utils/request";
import cloudApi from "../../utils/cloudapi";
import Config from "../../utils/config";

const app = getApp();

//index.js
//获取应用实例

Page({
  data: {
    storeInfo: {},
    status: "",
    canIUse: wx.canIUse("button.open-type.getUserInfo"),
    tabFooterActive: "wall",
    tabFooterBarActive: "home",
    value: "",
    moments: [],
    wallTopics: [],
    wallTags: [],
    queryModel: {
      pageIndex: 0,
      pageSize: 10,
      ProductName:[],
      TagList:[],
    },
    search_inline: false,
    showFooter: true,
    shoppingCart: [],
    favorite: [],
    totalForCart: 0,
    seller: false,
    selecting: false,
    safeAreaTop: app.getSafeAreaTop(),
    tabContentHeight:
      app.getClientAreaHeight() - app.globalData.bottomTabBarHeight, // 50: bottom tab-bar height
    tabBarHeight: app.globalData.topTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
    isShowTeachBar: true,
    scrollHeight:
      app.getClientAreaHeight() - (app.globalData.bottomTabBarHeight + 54 + 40),
    options: {},
    changeStore: true,
    isHome: true,
    showEdituserDialog: false,
    isSeller: false,
    apiLoginInfo: {},
    progress: {},
    scrollTop: 0,
    scrollMomentsTop: 0,
    isPhotoWallLoad: false,
    disabledWechat: true,
    disclaimerShow: false,
    commentShow: false,
    commentMoment: {},
    commentText: '',
    disableComment: false,
    scrollAnimation: false,
  },
  onWechatEdit() {
    this.setData({ disabledWechat: false })
  },
  bindViewTap: function () {
    wx.navigateTo({
      url: "../logs/logs"
    });
  },
  btnShare: function () {
    wx.navigateTo({
      url: "/pages/share-to-friend/index"
    });
  },
  onShareAppMessage: function () {
    return {
      title: "快来看看这个小买卖，这里有你想要的~",
      path: util.getShareUrl(),
      imageUrl: this.data.shareImageUrl
    };
  },
  getShareImage: function () {
    webapi.GetMySharePicture(false).then(result => {
      if (result.Success) {
        this.setData({
          shareImageUrl: result.Data.ImageUrl
        });
      }
    });
  },
  onLoad: function (options) {
    // options = {
    //     "ShareProductGuid": "edb8e6f1-9c0b-43ce-94ab-7606d5bcd249",
    //     "active": "1",
    //     "storeGuid": "d2b325cd-ae98-46e5-95c8-a9ba8d2709ca",
    //     "storeHost": "wanglihongweb"
    // };

    this.momentsRefresher = this.selectComponent("#moments-refresher");
    this.photowall = this.selectComponent("#photowall");
    //this.myfooter = this.selectComponent("#myfooter");
    // 以下登录流程非常复杂，涉及各种不同场景的情况，以及同一个场景首次和再次进入的情况，需要修改先联系张浩
    console.log("onload------>", this.data);
    console.log(options);
    this.setData({ options });
    webapi.logOnLoad(options);
    if (options.active) {
      this.setData({
        tabFooterActive: options.active
      });
    }
    const currentStoreInfo = app.globalData.storeInfo;
    if (currentStoreInfo) {
      if (
        currentStoreInfo.StoreGuid !== Config.StoreGuid &&
        (!options.storeGuid || currentStoreInfo.StoreGuid === options.storeGuid)
      ) {
        console.log("reuse--->" + currentStoreInfo.StoreGuid);
        console.log("status:" + this.data.status);
        if (options.ShareProductGuid) {
          this.setData({
            queryModel: {
              ShareGroupKey: options.ShareProductGuid
            }
          });
        }
        this.reload();
        return;
      }
    }
    this.setData({ status: "loading" });
    const self = this;
    app.GetMyStoreList({
      storeGuid: options.storeGuid,
      success: myAccessStores => {
        app.globalData.storeInfo = null;

        if (myAccessStores.length === 1) {
          app.globalData.storeInfo = myAccessStores[0];
        }

        // debug
        const debugStore = myAccessStores.find(
          o => o.StoreGuid === "d2b325cd-ae98-46e5-95c8-a9ba8d2709ca"
        );
        // if (debugStore) {
        //     app.globalData.storeInfo = debugStore;
        //     setTimeout(() => {
        //         wx.navigateTo({
        //             url: '/pages/order/detail?orderGuid=e5c23af0-e647-4762-a4c6-4c27a7d98d91'
        //         });
        //     }, 300);
        // }

        if (options.storeGuid) {
          app.globalData.storeInfo = myAccessStores.find(
            o => o.StoreGuid === options.storeGuid
          );
          if (app.globalData.storeInfo) {
            if (options.ShareProductGuid) {
              this.setData({
                queryModel: {
                  ShareGroupKey: options.ShareProductGuid
                }
              });
            }
          } else {
            console.log(options.storeGuid + " 找不到用户");
          }
        }

        if (!app.globalData.storeInfo) {
          if (myAccessStores.length > 0) {
            this.setData({
              status: "choose-store",
              myAccessStores
            });
          } else {
            // 申请开店
          }
        } else {
          app.changeStore(app.globalData.storeInfo.StoreGuid);
        }
      },
      fail: err => {
        this.setData({
          status: "need-author",
          options
        });
      }
    });
  },
  searchDQProduct() {
    const { queryModel, moments, status, tabFooterBarActive } = this.data;
    return webapi.searchDQProductGroup(queryModel).then(res => {
      if (res && res.Success) {
        let list = res.Data.ListObjects;
        list.forEach((val, key) => {
          if (val.Advertisement) {
            val.GroupName = "广告";
            val.Description = val.Advertisement.Description;
            val.UpdatedOn = util.timeStampToDateTime(val.UpdatedOn, "M-D");
          } else {
            // val.Description = val.Description.substring(
            //   val.Description.indexOf(" ") + 1
            // ); ??? 啥意思
            val.UpdatedOn = util.timeStampToDateTime(val.UpdatedOn, "M-D");
          }
        });
        if (queryModel.pageIndex > 0) {
          list = moments.concat(list)
        }
        this.setData({
          moments: list
        }, () => {
          if (status === 'shopping' && tabFooterBarActive === "home") {
            this.getNewMomentScrollTop().then(top => {
              console.log('getNewMomentScrollTop', top)
              this.newMomentScrollTop = top
            })
          }
        });
        return res.Data;
      }
    });
  },
  getNewMomentScrollTop() {
    const { moments } = this.data;
    const tops = moments.filter(item => item.AtTheTop === 1);
    return new Promise((resolve) => {
      if (tops.length > 0) {
        Promise.all(tops.map(item => {
          return getClientRec(`#moment-${item.Guid}`)
        })).then(result => {
          let top = 0
          result.forEach(item => {
            top += item.height;
          })
          resolve(top)
        })
      } else {
        resolve(0);
      }
    })
    function getClientRec(id) {
      return new Promise((resolve) => {
        wx.createSelectorQuery()
          .select(id)
          .boundingClientRect((res) => {
            resolve(res)
          }).exec()
      })
    }
  },
  onLoadMomentTopics: function () {
    return webapi.loadMomentTopics().then(res => {
      if (res && res.Success) {
        const { Data } = res;
        this.setData({
          momentTopics: Data.map(d => {
            return {
              name: d.TopicName,
              active: false
            };
          })
        });
      }
    });
  },
  onLoadMomentTags() {
    return webapi.loadProductTags().then(res => {
      const { Data } = res;
      this.setData({
        momentTags: Data.map(item => {
          return {
            name: item.ProductTag,
            active: false
          };
        })
      });
    });
  },
  onLoadShoppingCart: function () {
    return webapi.loadShoppingCart().then(res => {
      if (res && res.Success) {
        this.setData({
          shoppingCart: res.Data
        });
      }
    });
  },
  onLoadFavorite() {
    return webapi.loadWishList().then(res => {
      if (res && res.Success) {
        this.setData({
          favorite: res.Data
        });
      }
    });
  },
  reload() {
    this.setData({
      seller: app.globalData.seller,
      storeInfo: app.globalData.storeInfo,
      userInfo: app.globalData.userInfo,
      stores: app.globalData.myAccessStores,
      isShowTeachBar: true,
      scrollHeight:
        app.getClientAreaHeight() - (app.globalData.bottomTabBarHeight + 54 + 40),
    }, () => {
      const { seller } = this.data;
      this.gotoShopping();
      this.onLoadProductGroupList();
      if (!seller && app.globalData.apiLoginInfo.AcceptAgreement === 0) {
        this.setData({
          disclaimerShow: true
        })
      }
      this.updataDisableComment();
    });
  },
  updataDisableComment() {
    this.setData({
      disableComment: app.globalData.apiLoginInfo.DisableComment === 1
    })
  },
  onLoadProductGroupList(isAddMoment) {
    this.setData({
      scrollAnimation: false
    }, () => {
      this.setData({ scrollMomentsTop: isAddMoment ? this.newMomentScrollTop : 0 })
    })
    this.momentsRefresher.triggerRefresh();
    this.onLoadMomentTopics();
    this.onLoadMomentTags();
    Promise.all([this.onLoadShoppingCart(), this.onLoadFavorite()]).then(() => {
      this.photowall.onWallLoad()
    });

  },
  gotoShopping() {
    this.setData({
      status: "shopping",
      storeInfo: app.globalData.storeInfo,
      tabFooterBarActive: "home",
    });
    this.getShareImage();
  },
  gotoProducts() {
    this.setData({
      status: "products",
      storeInfo: app.globalData.storeInfo,
      tabFooterBarActive: "products"
    });
  },
  gotoCart() {
    this.selectComponent("#cart").onLoad();
    this.setData({
      status: "cart",
      storeInfo: app.globalData.storeInfo,
      tabFooterBarActive: "cart"
    });
  },
  gotoMessages(){
    this.selectComponent("#messages").onLoad();
    this.setData({
      status: "messages",
      storeInfo: app.globalData.storeInfo,
      tabFooterBarActive: "messages"
    });
  },
  gotoChooseStore() {
    this.setData({
      status: "choose-store",
      storeInfo: app.globalData.storeInfo
    });
  },
  gotoAboutMe() {
    this.selectComponent("#aboutme").onLoad();
    this.selectComponent("#aboutme").onShow();
    this.setData({
      status: "aboutme",
      storeInfo: app.globalData.storeInfo,
      tabBar_active: "aboutme"
    });
  },
  showSellerDialog(isSeller) {
    const apiLoginInfo = Request.getApiLoginInfo();
    console.log("apiLoginInfo", apiLoginInfo);
    this.setData({
      apiLoginInfo: apiLoginInfo,
      isSeller: isSeller,
      showEdituserDialog: true
    });
  },
  hiedEdituserDialog() {
    this.setData({
      showEdituserDialog: false
    });
  },
  onCopyWechatId(e) {
    console.log(e);
  },
  onUploadWechatPaymentQRCode() {
    wx.chooseImage({
      sourceType: ["album", "camera"],
      count: 1,
      success: res => {
        const fullPath = res.tempFilePaths[0];
        cloudApi.webapiUploadFiles(
          fullPath,
          data => {
            console.log(data);
            const wechatPaymentQrCode = Object.values(data.Data)[0];
            this.setData({ progress: { percent: 0, show: false } });
            webapi
              .UpdateStoreApplicationWechatInfo({
                Guid: this.data.apiLoginInfo.StoreApplication.Guid,
                wechatPaymentQrCode: wechatPaymentQrCode
              })
              .then(res => {
                if (res && res.Success) {
                  this.data.apiLoginInfo.StoreApplication.WechatPaymentQRCode = wechatPaymentQrCode;
                  this.setData({
                    apiLoginInfo: this.data.apiLoginInfo
                  });
                } else {
                  app.ShowToast("更新失败");
                }
              });
          },
          res => {
            this.setData({ progress: { percent: res.progress, show: true } });
          }
        );
      }
    });
  },
  onWechatIDChange(e) {
    this.tmpWechatId = e.detail;
  },
  onSaveWechatID() {
    webapi
      .UpdateStoreApplicationWechatInfo({
        Guid: this.data.apiLoginInfo.StoreApplication.Guid,
        WechatId: this.tmpWechatId
      })
      .then(res => {
        if (res && res.Success) {
          this.data.apiLoginInfo.StoreApplication.WechatId = this.tmpWechatId;
          this.setData({
            disabledWechat: true,
            apiLoginInfo: this.data.apiLoginInfo
          });

        } else {
          app.ShowToast("更新失败");
        }
      });
  },
  refresherScroll(e) {
    this.setData({
      scrollTop: e.detail.scrollTop
    });
  },
  onPulling() {
    console.log("onPulling");
  },
  onRefresh() {
    console.log("onRefresh");
    const { queryModel } = this.data;
    queryModel.pageIndex = 0;
    this.searchDQProduct().then(data => {
      this.momentsRefresher.finishPullToRefresh();
    });
  },
  onLoadmore() {
    console.log("onLoadmore");
    const { queryModel } = this.data;
    queryModel.pageIndex = queryModel.pageIndex + 1;
    this.setData({
      queryModel: queryModel
    });
    this.searchDQProduct().then(data => {
      const isEnd = data.TotalCount === this.data.moments.length;
      this.momentsRefresher.finishLoadmore(isEnd);
    });
  },
  momentsSearch(e) {
    const { queryModel } = this.data;
    this.setData({
      scrollAnimation: false,
    }, () => {
      this.setData({
        scrollMomentsTop: 0,
        queryModel: {
          ...queryModel,
          ...e.detail
        }
      });
      this.momentsRefresher.triggerRefresh();
    })
  },
  momentsChooseTopic(e) {
    this.setData({
      momentTopics: e.detail
    });
  },
  momentsChooseTag(e) {
    this.setData({
      momentTags: e.detail
    });
  },
  removeMoment(guid) {
    const { moments } = this.data;
    const index = moments.findIndex(item => item.Guid === guid);
    moments.splice(index, 1);
    this.setData({
      moments
    }, () => {
      this.getNewMomentScrollTop().then(top => {
        this.newMomentScrollTop = top
      })
    });
  },

  addShoppingCart(guid, quantity) {
    return webapi
      .addToShoppingCart(guid, quantity)
      .then(res => {
        if (res && res.Success) {
          wx.showToast({
            title: "添加购物车成功！"
          });
          return this.onLoadShoppingCart();
        } else {
          wx.showToast({
            title: "添加购物车失败！"
          });
          return res;
        }
      }).catch(res => {
        wx.showToast({
          title: "添加购物车失败！"
        });
        return res;
      });
  },

  updateShoppingCart(guid, quantity) {
    return webapi
      .updateShoppingCart(guid, quantity)
      .then(res => {
        if (res && res.Success) {
          return this.onLoadShoppingCart();
        } else {
          if (quantity === 0) {
            wx.showToast({
              title: "从购物车移除失败！"
            });
          }
          return res;
        }
      }).catch(res => {
        wx.showToast({
          title: "从购物车移除失败！"
        });
        return res;
      });
  },
  addFavorite(product) {
    const { favorite } = this.data;
    return webapi
      .addToWishList(product.Guid)
      .then(res => {
        if (res && res.Success) {
          wx.showToast({
            title: "添加收藏成功！"
          });
          favorite.push(product);
          this.setData({
            favorite
          });
        } else {
          wx.showToast({
            title: "添加收藏失败！"
          });
        }
        return res;
      })
      .catch(res => {
        wx.showToast({
          title: "添加收藏失败！"
        });
        return res;
      });
  },
  removeFavorite(product) {
    const { favorite } = this.data;
    return webapi
      .removeProductFromWishList(product.Guid)
      .then(res => {
        if (res && res.Success) {
          const index = favorite.findIndex(item => item.Guid === product.Guid);
          favorite.splice(index, 1);
          this.setData({
            favorite
          });
        } else {
          wx.showToast({
            title: "移除收藏失败！"
          });
        }
        return res;
      })
      .catch(res => {
        wx.showToast({
          title: "移除收藏失败！"
        });
        return res;
      });
  },
  onDisclaimerClose() {
    this.setData({ disclaimerShow: false })
  },
  onShowMomment(callback) {
    this.mommentCommitCallback = callback
    this.setData({
      commentShow: true,
    })
  },
  onCommentClose(e) {
    this.mommentCommitCallback = null
    this.setData({
      commentText: '',
      commentShow: false
    })
  },
  onCommentChange({ detail }) {
    this.setData({
      commentText: detail
    })
  },
  onCommit(e) {
    if (this.mommentCommitCallback) {
      const { commentText } = this.data;
      const context = commentText.trim();
      if (context.length > 0) {
        this.mommentCommitCallback(context).then(res => {
          this.onCommentClose();
        })
      } else {
        wx.showToast({
          title: "请填写评论！",
          icon: "none",
        });
      }
    }
  },
  takeOffProduct(list){
    const { moments } = this.data;
    this.photowall.takeOffProduct(list);
    moments.forEach(item => {
      list.forEach(guid=>{
        const product = item.ProductList.find(i => i.Guid === guid)
        if(product){
          product.isTakeOff = true
        }
      })
    })
    this.setData({
      moments
    })
  },
  updateProduct(product) {
    const { moments } = this.data;
    this.photowall.updateProduct(product);
    moments.forEach(item => {
      const index = item.ProductList.findIndex(i => i.Guid === product.Guid)
      item.ProductList[index] = product;
    })
    this.setData({
      moments
    })
  },
  updateMoment(moment) {
    const { moments } = this.data;
    const index = moments.findIndex(item => item.Guid === moment.Guid);
    if (index > -1) {
      moments[index] = moment
      this.setData({ moments })
    }
  },
  onGotoTeaching(e) {
    const { seller } = this.data;
    wx.navigateTo({
      url: `/pages/teaching/index?seller=${seller}`
    });
  },
  onCloseTeachBar(e) {
    this.setData({
      isShowTeachBar: false,
      scrollHeight:
        app.getClientAreaHeight() - (app.globalData.bottomTabBarHeight + 54),
    })
  },
  onMomentBackTop() {
    this.setData({
      scrollAnimation: true
    }, () => {
      this.setData({
        scrollMomentsTop: 0
      })
    })
  },
  onShowCartBar() {
    const { seller } = this.data;
    if (!seller) {
      this.setData({
        showCartBar: true
      })
    }
  },
  onHideCartBar() {
    const { seller } = this.data;
    if (!seller) {
      this.setData({
        showCartBar: false
      })
    }
  },
  onMomentPublish() {
    wx.navigateTo({
      url: '/pages/seller/publish/index',
      events: {
        initData: (callback) => {
          callback({ products: [], target: 'home' })
        },
        onComplete: () => {
          this.completePublish();
        }
      }
    });
  },
  completePublish() {
    this.setData({
      status: 'shopping',
      tabFooterBarActive: 'home'
    })
    this.onLoadProductGroupList(true);
  }
});
