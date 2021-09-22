import webapi from "../../../utils/webapi";
import Util from "../../../utils/util.js";

const app = getApp();

Page({
  data: {
    showPopover: false,
    products: [],
    pictures: [],
    video: {},
    selected: [],
    isOneVideo: false,
    context: '',
    target: '',
    delta: 1,
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaTop: app.getSafeAreaTop(),
    safeAreaBottom: app.getSafeAreaBottom(),
  },
  onLoad() {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('initData', ({ products, delta = 1, target }) => {
      this.breakProductPictures({ products, delta, target })
    });
  },
  breakProductPictures({ products, delta = 1, target }) {
    const isOneVideo = !!products.find(item => item.VideoUrl)
    const selected = [];
    if (isOneVideo) {
      selected.push({
        uuid: Util.uuid(),
        url: products[0].VideoUrl,
        selected: false,
        product: products[0]
      })
      this.setData({
        video: products[0],
        products,
        delta,
        selected,
        isOneVideo,
        target
      });
    } else {
      const pictures = [];
      products.forEach(item => {
        item.PictureList.forEach(url => {
          pictures.push({
            uuid: Util.uuid(),
            url: url,
            selected: false,
            product: item
          })
        })
      })
      if (pictures.length <= 9) {
        pictures.forEach(item => {
          item.selected = true
          selected.push(item)
        })
      }
      this.setData({
        delta,
        products,
        pictures,
        selected,
        isOneVideo,
        target
      });
    }

  },
  onNavigateBack() {
    const { delta } = this.data;
    wx.navigateBack({
      delta: delta
    });
  },
  onContextFocus({ detail }) {
    const { value } = detail;
    if (!value) {
      this.setData({
        context: "#新品上架# "
      });
    }
  },
  onContextInput({ detail }) {
    this.setData({
      context: detail.value
    });
  },
  onClickPicture({ target }) {
    const { pictures, selected } = this.data;
    const { index } = target.dataset;
    const picture = pictures[index];
    const isSelected = !picture.selected
    if (isSelected && selected.length >= 9) {
      return
    } else {
      picture.selected = isSelected;
      if (picture.selected) {
        selected.push(picture)
      } else {
        const index = selected.findIndex(item => item.uuid === picture.uuid);
        selected.splice(index, 1)
      }
      this.setData({
        selected,
        pictures
      })
    }
  },
  onGotoReselect() {
    const { products, delta, target } = this.data;
    wx.navigateTo({
      url: "/pages/seller/product-select/index",
      events: {
        getSelectedList: (callback) => {
          callback(products)
        },
        onComplete: (products) => {
          this.breakProductPictures({ products, delta, target })
        }
      }
    });
  },
  onPushMoment() {
    const { delta, context, selected } = this.data;
    const eventChannel = this.getOpenerEventChannel();
    const text = context.trim();
    const topic = (text.match(/#([^#]*)#/) || ['', ''])[1];
    const model = {
      groupName: topic,
      description: topic ? text.substring(topic.length + 2, text.length) : text,
      status: 1,
      displayOrder: 0,
      productList: [],
      UpdateProductsOnly: false,
      PictureList: selected.map(item => {
        return {
          ImageUrl: item.url,
          ProductGuid: item.product.Guid,
        }
      })
    };

    webapi.promoteProducts(model).then((res) => {
      if (res.Success) {
        wx.navigateBack({ delta: delta });
        eventChannel.emit('onComplete')

      } else {
        wx.showToast({
          title: "网络异常",
          icon: 'none',
          duration: 2000,
        });
      }
    }).catch(() => {
      wx.showToast({
        title: "网络异常",
        icon: 'none',
        duration: 2000,
      });
    })

  }
})
