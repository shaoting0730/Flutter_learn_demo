
const app = getApp();

Component({

  properties: {
    show: Boolean,
    videoUrl: String,

    autoplay: {
      type: Boolean,
      value: false
    }
  },
  data: {
    textStyle: '',
    imageStyle: '',
    getSafeAreaTop: app.getSafeAreaTop() + 48,
    height: app.getClientAreaHeight() * 0.8
  },
  lifetimes: {

  },
  methods: {
    onClose(e) {
      this.triggerEvent('close', e.detail);
    }
  }
})
