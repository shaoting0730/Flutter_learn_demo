import Util from "../../utils/util.js";

Component({
  externalClasses: [
    'custom-class'
  ],
  properties: {
    index: {
      type: Number,
      value: 0
    },
    title: {
      type: String,
      value: ''
    },
    product: {
      type: Object,
      value: {},
      observer: 'updataProduct'
    },
    seller: {
      type: Boolean,
      value: false
    },
  },
  data: {
    defaultImage: '',
    product: {}
  },
  methods: {
    updataProduct(n) {
      this.setData({ product: n })
    },
    onChooseActionSheet(e) {
      const { product } = this.data;
      this.triggerEvent('choose', product);
    },
    onNameInput({ detail }) {
      const { product } = this.data;
      const { value } = detail;
      product.ProductName = value;
      product.Description = value;
      this.setData({ product })
      this.triggerEvent('update', product);
    },
    onPriceInput({ detail }) {
      const { product } = this.data;
      const { value } = detail;

      if (Util.isNumber(value) || value === '') {
        product.Price = value
      }
      this.setData({ product })
      this.triggerEvent('update', product);
    },
    onGotoVideo(e) {
      const { product } = this.properties;
      wx.navigateTo({
        url: "/pages/seller/product-video/index",
        events: {
          getVideo: callback => {
            callback(product.VideoUrl);
          },
          setVideo: (url) => {
            product.VideoUrl = url;
            this.setData({ product })
            this.triggerEvent('update', product);
          }
        }
      });
    },
    onGotoImages(e) {
      const { product } = this.properties;
      wx.navigateTo({
        url: "/pages/seller/product-images/index",
        events: {
          getImages: callback => {
            callback(product.PictureList || []);
          },
          setImages: (images) => {
            product.PictureList = images;
            this.setData({ product })
            this.triggerEvent('update', product);
          }
        }
      });
    },
    onGotoTags(e) {
      const { product } = this.data;
      wx.navigateTo({
        url: "/pages/seller/product-tags/index",
        events: {
          getTag: callback => {
            callback(product.TagList || []);
          },
          setTage: tags => {
            product.TagList = tags;
            this.setData({ product })
            this.triggerEvent('update', product);
          }
        }
      });
    }
  }
});


