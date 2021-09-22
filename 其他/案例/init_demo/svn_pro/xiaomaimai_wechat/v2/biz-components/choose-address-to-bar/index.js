/**
 * 收货地址条 组件
 */
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    address: {
      type: Object,
      value: {},
    },
    checkAddress: {
      type: String,
      value: "1"
    },
    isShowChoose: {
      type: Boolean,
      value: true,
    }
  },

  /**
   * 组件的初始数据
   */
  data: {

  },

  /**
   * 组件的方法列表
   */
  methods: {
    gotoAddress(e) {
      wx.navigateTo({
        url: '/pages/address/user-address/user-address?allowSelect=true',
        events: {
          chooseAddress: (address) => {
            this.triggerEvent('chooseAddress', address);
          }
        }
      })
    },
    onCheckAddress(e) {
      console.log(e);
      this.triggerEvent('checkAddress', e.detail);
    }
  }
})
