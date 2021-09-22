import webapi from "../../utils/webapi";
import cloudApi from "../../utils/cloudapi";
import util from "../../utils/util";

const app = getApp();

Component({
  properties: {
    shoppingCart: {
      type: Array,
      value: [],
      observer: "watchShoppingCart"
    },
    favoriteList: {
      type: Array,
      value: [],
      observer: "watchFavoriteList"
    },
    seller: {
      type: Boolean,
      value: false
    },
    ShareGroupKey: {
      type: String,
      value: ""
    },
    scrollBottom: {
      type: Number,
      value: 0
    }
  },
  data: {
    select: false,
    progress: {
      percent: 0,
      show: false
    },
    topic: [],
    tags: [],
    products: [],
    selectedList: [],
    selectedImgeCount: 0,
    selectedVideoCount: 0,
    safeAreaBottom: app.getSafeAreaBottom(),
    searchModel: {
      pageIndex: 0,
      pageSize: 100,
      TagList: [],
      ProductName: []
    },
    scrollHeight: app.getClientAreaHeight() - (app.globalData.bottomTabBarHeight + 54),
    scrollTop: 0,
    scrollWallTop: 0,
    uploadMaxCount: 9,
    scrollAnimation: false,
  },

  ready() {
    this.refresher = this.selectComponent("#refresher");
    this.refresher.setParent(this);
  },

  methods: {
    onWallLoad(n, o) {
      const { seller } = this.data;
      this.onLoadMomentTopics();
      this.onLoadMomentTags();
      this.refresher.triggerRefresh();
      if (!seller) {
        this.setData({
          scrollHeight: app.getClientAreaHeight() - (app.globalData.bottomTabBarHeight + 54 + 60),
        })
      }
    },
    onSelect(e) {
      const { products } = this.data;
      app.currentPage().setData({
        showFooter: this.data.select,
        selecting: !this.data.select
      });
      this.setData({
        select: !this.data.select,
        products: products.map(item => { item.selected = false; return item }),
        selectedList: [],
        selectedImgeCount: 0,
        selectedVideoCount: 0
      });
    },
    onTriggerCart({ detail }) {
      const homePage = app.getHomePage();
      detail.addedToCart ?
        homePage.updateShoppingCart(detail.Guid, 0) :
        homePage.addShoppingCart(detail.Guid, 1);
    },
    onTriggerFavorite({ detail }) {
      const homePage = app.getHomePage();
      detail.favorite ? homePage.removeFavorite(detail) : homePage.addFavorite(detail);
    },
    onTriggerSelected({ detail }) {
      let { selectedList, products, selectedImgeCount, selectedVideoCount } = this.data;
      let count = detail.selected ? -1 : 1;
      if (detail.selected) {
        const index = selectedList.findIndex(i => i.Guid === detail.Guid);
        selectedList.splice(index, 1);
      } else {
        selectedList.push(detail);
      }
      if (detail.VideoUrl) {
        selectedVideoCount = selectedVideoCount + count;
      } else {
        selectedImgeCount = selectedImgeCount + count;
      }

      detail.selected = !detail.selected;
      products[
        products.findIndex(item => item.Guid == detail.Guid)
      ] = detail;

      this.setData({
        products,
        selectedList,
        selectedImgeCount,
        selectedVideoCount
      });

    },
    onUnPublish(e) {
      const { selectedList } = this.data;
      const homePage = app.getHomePage();
      const listGuid = selectedList.map(item => item.Guid);
      if (listGuid.length > 0) {
        webapi.removeDQProduct(listGuid).then(res => {
          if (res && res.Success) {
            this.onCleanSelected()
            homePage.takeOffProduct(listGuid)
          } else {
            wx.showToast({
              title: "下架失败！"
            });
          }
        });
      }
    },
    takeOffProduct(list) {
      const { products } = this.data;
      list.forEach(guid => {
        const index = products.findIndex(i => i.Guid === guid)
        products.splice(index, 1);
      })
      this.setData({
        products
      })
    },
    gotoPublish(products, delta) {
      wx.navigateTo({
        url: "/pages/seller/publish/index",
        events: {
          initData: (callback) => {
            callback({ products, delta })
          },
          onComplete: () => {
            this.setData({
              select: false
            })
            this.triggerEvent('completePublish');
          }
        }
      });
    },
    onPublish(e) {
      const { selectedList } = this.data;
      this.gotoPublish(selectedList)
    },
    onProducts(e) {
      wx.navigateTo({
        url: "/pages/seller/product-release/index",
        events: {
          onComplete: ({ products }) => {
            this.onWallLoad();
            if (products.length > 0) {
              this.gotoPublish(products, 2)
            }
          }
        }
      });
    },
    onCleanSelected() {
      const { products } = this.data;
      this.setData({
        products: products.map(item => { item.selected = false; return item }),
        selectedList: [],
        selectedImgeCount: 0,
        selectedVideoCount: 0
      });
    },
    onLoadMomentTopics() {
      return webapi.loadMomentTopics().then(res => {
        if (res && res.Success) {
          const { Data } = res;
          this.setData({
            topic: Data.map(d => {
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
          tags: Data.map(item => {
            return {
              name: item.ProductTag,
              active: false
            };
          })
        });
      });
    },
    refresherScroll(e) {
      this.setData({
        scrollTop: e.detail.scrollTop
      });
    },
    onRefresh() {
      console.log("onRefresh");
      const { searchModel } = this.data;
      searchModel.pageIndex = 0;
      this.onLoadPhotoWall().then(data => {
        this.refresher.finishPullToRefresh();
      });
    },
    onLoadmore() {
      console.log("onLoadmore");
      const { searchModel, products } = this.data;
      searchModel.pageIndex = searchModel.pageIndex + 1;
      this.setData({
        searchModel: searchModel
      });
      this.onLoadPhotoWall().then(data => {
        const isEnd =
          data.TotalCount === products.length || data.ListObjects.length === 0;
        this.refresher.finishLoadmore(isEnd);
      });
    },
    onSearch(e) {
      const { searchModel } = this.data;
      this.setData({
        scrollAnimation: false
      }, () => {
        this.setData({
          scrollWallTop: 0,
          searchModel: {
            ...searchModel,
            ...e.detail
          }
        });
        this.refresher.triggerRefresh();
      })
    },
    onChooseTopic(e) {
      this.setData({
        topic: e.detail
      });
    },
    onChooseTag(e) {
      this.setData({
        tags: e.detail
      });
    },
    onLoadPhotoWall() {
      const { searchModel, products } = this.data;
      const { shoppingCart, favoriteList = [] } = this.properties;
      console.log("onLoadPhotoWall", searchModel);
      return webapi.searchDQProduct(searchModel).then(res => {
        if (res && res.Success) {
          //let wishList = app.globalData.wishList;
          const productList = res.Data.ListObjects.map(item => {
            return {
              ...item,
              StockQuantity: 7,
              favorite: favoriteList.findIndex(c => c.Guid === item.Guid) > -1,
              addedToCart:
                shoppingCart.findIndex(c => c.ProductCode === item.Guid) > -1,
              selected: false
            }
          });
          if (searchModel.pageIndex === 0) {
            this.setData({
              products: productList
            });
          } else {
            this.setData({
              products: products.concat(productList)
            });
          }
          return res.Data;
        }
      });
    },
    watchShoppingCart(n) {
      const { products } = this.data;
      products.forEach(item => {
        item.addedToCart =
          n.findIndex(c => c.ProductCode === item.Guid) > -1;
      });
      this.setData({
        products
      });
    },
    watchFavoriteList(n) {
      const { products } = this.data;
      products.forEach(item => {
        item.favorite =
          n.findIndex(c => c.Guid === item.Guid) > -1;
      });
      this.setData({
        products
      });
    },
    updateProduct(product) {
      const { products } = this.data;
      const index = products.findIndex(i => i.Guid === product.Guid);
      products[index] = product;
      this.setData({
        products
      })
    },
    onBackTop() {
      this.setData({
        scrollAnimation: true,
      }, () => {
        this.setData({
          scrollWallTop: 0
        })
      })
    },
  }
});
