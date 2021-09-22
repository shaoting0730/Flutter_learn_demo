import Util from "../../utils/util.js";
const app = getApp();

Component({
  properties: {
    momentGuid: {
      type: String,
      value: ''
    },
    productList: {
      type: Array,
      value: [],
      observer: 'upProductList'
    },
    moments: {
      type: Array,
      value: []
    },
    displayPirce: {
      type: Boolean,
      value: true,
    },
    previewImageDetails: {
      type: Boolean,
      value: true,
    },
    pictures: {
      type: Array,
      value: []
    },
  },

  data: {
    span: 8,
    pictureList: []
  },
  lifetimes: {
    attached() {
      const { pictures, productList } = this.properties;
      const pictureList = pictures.map(item => {
        const product = productList.find(p => p.Guid === item.ProductGuid) || { isTakeOff: true }
        return {
          uuid: Util.uuid(),
          ...item,
          ...product
        }
      })
      this.setData({
        pictureList,
        span: pictureList.length < 5 ? 12 : 8
      })
    }
  },
  methods: {
    upProductList(productList) {
      const { pictures } = this.properties;
      const pictureList = pictures.map(item => {
        const product = productList.find(p => p.Guid === item.ProductGuid) || { isTakeOff: true }
        return {
          uuid: Util.uuid(),
          ...item,
          ...product
        }
      })
      this.setData({
        pictureList,
        span: pictureList.length < 5 ? 12 : 8
      })
    },
    onPreview(event) {
      const { previewImageDetails } = this.properties;
      if (previewImageDetails) {
        const { item } = event.currentTarget.dataset;
        wx.navigateTo({
          url: '/pages/detail/index',
          events: {
            getProduct(callback) {
              callback(item)
            }
          }
        });
      } else {
        const index = event.currentTarget.dataset.index;
        wx.previewImage({
          current: this.properties.productList[index].PictureList[0],
          urls: this.properties.productList[index].PictureList,
        });
      }
    },
  },
  externalClasses: ['custom-class']
})
