import util from "../../utils/util";

Component({
  externalClasses: [
    'custom-class'
  ],
  properties: {
    isSelect: {
      type: Boolean,
      value: false
    },
    selectedImgeCount: {
      type: Number,
      value: 0,
    },
    selectedVideoCount: {
      type: Number,
      value: 0,
    },
    product: {
      type: Object,
      value: {}
    },
    seller: {
      type: Boolean,
      value: false
    },
    hiddenSelectIcon: {
      type: Boolean,
      value: false
    }
  },
  methods: {
    triggerCart(e) {
      const { product } = this.properties
      this.triggerEvent('triggerCart', product);
    },
    triggerFavorite(e) {
      const { product } = this.properties
      this.triggerEvent('triggerFavorite', product);
    },
    onClick(e) {
      const { isSelect, product } = this.properties
      isSelect ? this.triggerEvent('triggerSelected', product) : this.onPreview();
    },
    onPreview() {
      const { product } = this.properties
      wx.navigateTo({
        url: "/pages/detail/index",
        events: {
          getProduct(callback) {
            callback(product);
          }
        },
        fail:()=>{
          wx.showToast({
            title: '小程序中页面栈最多十层',
            icon: 'none',
            duration: 2000
          })
        }
      });
    },
  }
});


