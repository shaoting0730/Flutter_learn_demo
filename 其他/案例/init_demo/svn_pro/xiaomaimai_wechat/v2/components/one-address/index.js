const computedBehavior = require('miniprogram-computed')


Component({
  behaviors: [computedBehavior],
  externalClasses: [
    'custom-class',
    'title-class',
    'phone-class',
    'content-class',
    'footer-class'
  ],
  options: {
    multipleSlots: true
  },
  properties: {
    title: String,
    phone: String,
    province: String,
    city: String,
    town: String,
    address: String,
    clickable: Boolean,
    useFooterSlot: {
      type: Boolean,
      value: false,
    },
    isDefault: {
      type: Boolean,
      value: false,
    },
    tagName: {
      type: String,
      value: '默认'
    }
  },
  computed: {
    addressLine(data) {
      return `${data.province}${data.city}${data.town}${data.address}`
    },
  },
  data: {},
  lifetimes: {
    attached: function () { },
  },
  methods: {
    onClick(e) {
      if (this.data.clickable) {
        this.triggerEvent('click', e.detail);
      }
      //this.jumpLink();
    }
  }
})
