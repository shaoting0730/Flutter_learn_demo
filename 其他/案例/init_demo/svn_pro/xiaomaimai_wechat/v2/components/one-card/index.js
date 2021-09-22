Component({
  externalClasses: [
    'custom-class',
    'num-class',
    'desc-class',
    'thumb-class',
    'title-class',
    'title-text-class',
    'content-class',
    'price-class',
    'origin-price-class',
    'bottom-class'
  ],
  options: {
    multipleSlots: true
  },
  properties: {
    tag: {
      type: Array,
      value: []
    },
    title: {
      type: String,
      value: ''
    },
    desc: String,
    thumb: String,
    thumbMode: {
      type: String,
      value: 'aspectFill'
    },
    price: {
      type: Number,
      value: 0
    },
    minPrice: {
      type: Number,
      value: 0
    },
    maxPrice: {
      type: Number,
      value: 0
    },
    currency: {
      type: String,
      value: '¥'
    },
    rangePrice: {
      type: Boolean,
      value: false
    },
    showZeroText: {
      type: Boolean,
      value: true
    },
    priceZeroText: {
      type: String,
      value: '待定'
    },
    useConentSlot: {
      type: Boolean,
      value: false
    },
    stockQuantity: {
      type: Number,
      value: 100000,
    }
  },
  data: {},
  lifetimes: {
    attached: function () { },
  },
  methods: {
    onClickThumb() {

    }
  }
})
