// pages/showdetails/index.js
import webapi from "../../utils/webapi";

const app = getApp();
Page({
  data: {
    storeName: '',
    indicatorDots: true,
    autoplay: false,
    current: 1,
    collapse: false,
    list: [],
    shoppingCart: [],
    seller: false,
    screenWidth: app.globalData.systemInfo.screenWidth,
    safeAreaBottom: app.getSafeAreaBottom(),
    getSafeAreaTop: app.getSafeAreaTop() + 48
  },

  onLoad(o) {
    const eventChannel = this.getOpenerEventChannel()
    const homePage = app.getHomePage();
    eventChannel.emit('getPhotoList', (uuid, list) => {
      const index = list.findIndex(item => item.uuid === uuid);
      this.setData({

        shoppingCart: homePage.data.shoppingCart,
        storeName: app.globalData.storeInfo.StoreName,
        indicatorDots: list.length > 1,
        current: index,
        list: list,
        seller: app.globalData.seller
      });
    });
  },
  onChange({ detail }) {
    this.setData({ current: detail.current });
  },
  onCollapse(event) {
    this.setData({ collapse: !this.data.collapse })
  },
  onAddToCart(event) {
    const { guid } = event.currentTarget.dataset
    app.getHomePage().addShoppingCart(guid, 1);
  },
  onEditProduct(event) {
    const guid = event.currentTarget.dataset.guid;
    wx.redirectTo({
      url: '/pages/seller/product-edit/index?productId=' + guid,
    });
  },
  onBuy({ currentTarget }) {
    const { guid } = currentTarget.dataset
    wx.navigateTo({
      url: '/pages/order/pay',
      events: {
        getData: (callback) => {
          callback(
            {
              products: [{
                ProductCode: guid,
                Quantity: 1
              }]
            })
        },
      }
    });
  },
  onRemoveProduct(event) {
    const homePage = app.getHomePage()
    wx.showModal({
      title: '提示',
      content: '确定下架该商品吗？',
      success(res) {
        if (res.confirm) {
          const guid = event.currentTarget.dataset.guid;
          webapi.removeDQProduct([guid]).then(res => {
            homePage.takeOffProduct([guid])
            wx.navigateBack()
          })
        } else if (res.cancel) {
        }
      }
    })
  },
  onPreviewImage({ currentTarget }) {
    const { dataset } = currentTarget;

    wx.previewImage({
      current: dataset.url,
      urls: [dataset.url]
    })
  },
  onShare() {
    const { current, list } = this.data;
    wx.navigateTo({
      url: '/pages/share/index',
      events: {
        getImage: (callback) => {
          webapi.GetDQProductSharePicture([list[current].Guid])
            .then(res => {
              callback(res.Data)
            });
        }
      }
    });
  }
})
