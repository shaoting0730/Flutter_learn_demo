import webapi from "../../utils/webapi";
import Util from "../../utils/util";

const app = getApp();

Page({
  data: {
    seller: false,
    product: {},
    scrollMomentsTop: 0,
    shoppingCart: [],
    favorite: [],
    pictures: [],
    notice: {
      show: true,
      className: 'notice-def',
      text: '商品已下架'
    },
    promoted: [],
    screenWidth: app.globalData.systemInfo.screenWidth,
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onLoad() {

    const eventChannel = this.getOpenerEventChannel()
    const homePage = app.getHomePage();
    const { seller } = app.globalData;
    this.getCart();

    eventChannel.emit('getProduct', (product) => {
      Promise.all([webapi.searchDQProduct({
        ProductGuid: [product.Guid || product.ProductGuid],
        includeDeleted: true,
        PageSize: 1
      }), webapi.searchPromotedDQProduct({
        ProductGuid: [product.Guid || product.ProductGuid],
        includeDeleted: true
      })]).then(res => {
        const p = res[0].Data.ListObjects[0];

        this.setData({
          seller,
          product: p,
          shippingCost: app.globalData.shippingCost,
          favorite: homePage.data.favorite,
          promoted: Util.arrayGroup(res[1].Data.ListObjects || [], 3),
          pictures: (p.PictureList || []).filter((_, i) => i !== 0),
          notice: {
            show: (seller && p.Status === -1) || (!seller && p.StockQuantity < 8),
            className: p.Status === -1 || p.StockQuantity === 0 ? 'notice-def' : 'notice-warning',
            text: p.Status === -1 ? '商品已下架' : p.StockQuantity === 0 ? '当前商品库存不足' : '当前库存剩余8件，每人限购1件',
          }
        });
      });


    });
  },
  getCart() {
    const homePage = app.getHomePage();
    const { shoppingCart } = homePage.data;
    let count = 0;
    shoppingCart.forEach(cart => {
      if (cart.StockQuantity <= 0) return;
      count += cart.Quantity
    });
    this.setData({
      shoppingCart,
      cartCount: count === 0 ? '' : count
    })
  },
  onMomentBackTop() {
    this.setData({
      scrollMomentsTop: 0
    })
  },
  onRemoveProduct() {
    const homePage = app.getHomePage()
    const { product } = this.data;
    wx.showModal({
      title: '提示',
      content: '确定下架该商品吗？',
      success(res) {
        if (res.confirm) {
          const guid = product.Guid;
          webapi.removeDQProduct([guid]).then(res => {
            homePage.takeOffProduct([guid])
            wx.navigateBack()
          })
        } else if (res.cancel) {
        }
      }
    })
  },
  onEditProduct() {
    const { product } = this.data;
    wx.redirectTo({
      url: `/pages/seller/product-edit/index?productId=${product.Guid}`,
    });
  },
  onBuy() {
    const { product } = this.data;
    wx.navigateTo({
      url: '/pages/order/pay',
      events: {
        getData: (callback) => {
          callback({
            products: [{
              ProductCode: product.Guid,
              Quantity: 1
            }]
          })
        },
      }
    });
  },
  onAddToCart() {
    const { product } = this.data;
    app.getHomePage().addShoppingCart(product.Guid, 1).then(res => {
      this.getCart();
    });
  },
  onShare() {
    const { product } = this.data;
    wx.navigateTo({
      url: '/pages/share/index',
      events: {
        getImage: (callback) => {
          webapi.GetDQProductSharePicture([product.Guid])
            .then(res => {
              callback(res.Data)
            });
        }
      }
    });
  },
  onPreviewImage({ currentTarget }) {
    const { product } = this.data;
    const { url } = currentTarget.dataset;
    wx.previewImage({
      current: url,
      urls: product.PictureList
    })
  },
  onGotoCart() {
    app.getHomePage().gotoCart();
    setTimeout(() => {
      wx.navigateBack({
        delta: getCurrentPages().length - 1
      })
    }, 300)
  },
  onFavorite({ currentTarget }) {
    const { value } = currentTarget.dataset;
    const { product, seller } = this.data;
    if (!seller && product.Status !== -1) {
      const homePage = app.getHomePage();
      (value ? homePage.removeFavorite(product) : homePage.addFavorite(product)).then(() => {
        this.setData({
          favorite: homePage.data.favorite,
        })
      });
    }
  }
})
