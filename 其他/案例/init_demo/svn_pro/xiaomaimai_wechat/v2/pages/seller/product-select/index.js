
import webapi from "../../../utils/webapi";
import cloudApi from "../../../utils/cloudapi";
import util from "../../../utils/util";

const app = getApp();


Page({
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
    searchModel: {
      pageIndex: 0,
      pageSize: 100
    },
    safeAreaBottom: app.getSafeAreaBottom(),
    scrollHeight: app.getClientAreaHeight() - (app.globalData.bottomTabBarHeight + 54),
    scrollTop: 0,
    scrollWallTop: 0,
    scrollAnimation: false
  },

  onLoad() {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('getSelectedList', (list) => {

      let selectedImgeCount = 0;
      let selectedVideoCount = 0;
      list.forEach(item => {
        if (item.VideoUrl) {
          selectedVideoCount++;
        } else {
          selectedImgeCount++;
        }
      })

      this.setData({
        selectedList: list,
        selectedImgeCount,
        selectedVideoCount
      }, () => {
        this.refresher = this.selectComponent("#refresher");
        this.refresher.setParent(this);
        this.onLoadMomentTopics();
        this.onLoadMomentTags();
        this.refresher.triggerRefresh();
      });
    });
  },

  onTriggerSelected({ detail }) {
    let { selectedList, products, selectedImgeCount, selectedVideoCount } = this.data;
    let count = detail.selected ? -1 : 1;

    if (detail.VideoUrl) {
      selectedVideoCount = selectedVideoCount + count;
    } else {
      selectedImgeCount = selectedImgeCount + count;
    }
    if (
      (selectedVideoCount === 0 && selectedImgeCount >= 0) ||
      (selectedVideoCount === 1 && selectedImgeCount === 0)
    ) {
      detail.selected = !detail.selected;
      products[
        products.findIndex(item => item.Guid == detail.Guid)
      ] = detail;
      if (detail.selected) {
        selectedList.push(detail);
      } else {
        const index = selectedList.findIndex(i => i.Guid === detail.Guid);
        selectedList.splice(index, 1);
      }
      this.setData({
        products,
        selectedList,
        selectedImgeCount,
        selectedVideoCount
      });
    }
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
    const { searchModel, products, selectedList } = this.data;

    console.log("onLoadPhotoWall", searchModel);
    return webapi.searchDQProduct(searchModel).then(res => {
      if (res && res.Success) {
        //let wishList = app.globalData.wishList;
        const productList = res.Data.ListObjects.map(item => {
          return {
            ...item,
            selected: selectedList.findIndex(c => c.Guid === item.Guid) > -1,
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
  onComplete() {
    const { selectedList } = this.data;
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('onComplete', selectedList)
    wx.navigateBack({
      changed: true
    })
  },
  onBackTop() {
    this.setData({
      scrollAnimation: true
    }, () => {
      this.setData({
        scrollWallTop: 0
      })
    })
  },
})
