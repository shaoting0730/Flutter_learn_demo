import webapi from "../../utils/webapi";
const app = getApp();
Component({
  properties: {
    show: {
      type: Boolean,
      value: false
    }
  },
  data: {
    checked: false,
  },
  methods: {
    onChange(e) {
      this.setData({
        checked: e.detail
      })
    },
    onAgree(e) {
      const { checked } = this.data;
      if (checked) {
        webapi.AcceptAgreement().then(res => {
          this.triggerEvent('close');
          app.globalData.apiLoginInfo.AcceptAgreement = 1
        })
      } else {
        this.triggerEvent('close');
      }
    }
  }
})
