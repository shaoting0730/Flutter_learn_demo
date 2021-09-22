const app = getApp();

Component({
  externalClasses: [
    'custom-class',
    'custom-options-class',
  ],

  properties: {
    seller: {
      type: Boolean,
      value: false
    },
    showOptions: {
      type: Boolean,
      value: false
    },
    showProductIcon: {
      type: Boolean,
      value: false
    },
    disabledPublishBtn: {
      type: Boolean,
      value: false
    }
  },
  data: {
    safeAreaBottom: app.getSafeAreaBottom(),
  },

  methods: {
    onBackTop(e) {
      this.triggerEvent('backTop');
    },
    onProducts(e) {
      this.triggerEvent('products')
    },
    onPublish(e) {
      this.triggerEvent('publish')
    },
    onUnPublish(e) {
      this.triggerEvent('unpublish')
    }
  }
})
