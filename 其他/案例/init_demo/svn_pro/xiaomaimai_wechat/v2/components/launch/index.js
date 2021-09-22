const app = getApp();

Component({
  properties: {
    status: String,
    canIUse: Boolean,
    myAccessStores: {
      type: Array,
      value: [],
    },
  },
  data: {
    viewHeight: app.getClientAreaHeight()
  },
  methods: {
    bindGetUserInfo: function (e) {
      wx.reLaunch({url: "/pages/home/index"});
    }
  }
})
