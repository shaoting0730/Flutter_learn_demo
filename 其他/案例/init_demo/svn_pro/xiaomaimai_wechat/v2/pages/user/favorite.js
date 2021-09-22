import webapi from "../../utils/webapi";

const app = getApp();
Page({
  data: {
    page: 1,
    refresherScrollTop: 0,
    scrollTop: 0,
    searchModel: {
      pageSize: 10
    },
    productData: [],
    scrollHeight: app.getClientAreaHeight() - 54 ,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onLoad() {
    this.refresher = this.selectComponent("#refresher");
    this.refresher.triggerRefresh();
  },
  getFavoriteProducts() {
    const { searchModel, productData } = this.data;
    return webapi.loadWishList(searchModel).then(res => {
      if (res.Success) {
        const ListObjects = res.Data;
        if (searchModel.pageIndex === 0) {
          this.setData({
            productData: ListObjects
          })
        } else {
          this.setData({
            productData: productData.concat(ListObjects)
          })
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
  changeStore(event) {
    app.changeStoreEx(event.currentTarget.dataset.storeguid);
  },
  onDelete(event) {
    const { productData } = this.data;
    wx.showModal({
      title: "提示",
      content: "你确认移除吗",
      success: res => {
        const { item } = event.currentTarget.dataset;
        res.confirm &&
          app
            .getHomePage()
            .removeFavorite(item)
            .then(res => {
              if (res && res.Success) {
                const index = productData.findIndex(
                  item => item.Guid === item.Guid
                );
                productData.splice(index, 1);
                this.setData({
                  productData
                });
              }
            });
      },
      fail: () => {
        wx.showToast({
          title: "网络异常！",
          duration: 2000
        });
      }
    });
  },
  refresherScroll(e) {
    this.setData({
      refresherScrollTop: e.detail.scrollTop
    });
  },
  onRefresh() {
    const { searchModel } = this.data;
    searchModel.pageIndex = 0;
    this.getFavoriteProducts().then(data => {
      this.refresher.finishPullToRefresh();
      this.refresher.finishLoadmore(true);
    });
  },
  onLoadmore() {
    const { searchModel, productData } = this.data;
    searchModel.pageIndex += 1;
    this.getFavoriteProducts().then(data => {
      const isEnd = data.TotalCount === productData.length;
      this.refresher.finishLoadmore(isEnd);
    });
  },
  onSearch(e) {
    const { searchModel } = this.data;
    this.setData({
      scrollTop: 0,
      searchModel: {
        ...searchModel,
        productName: e.detail
      }
    });
    this.refresher.triggerRefresh();
  },
});
