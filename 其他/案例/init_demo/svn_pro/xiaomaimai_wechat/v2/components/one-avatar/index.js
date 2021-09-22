Component({
  externalClasses: [
    'custom-class',
    'thumb-class',
    'text-class',
  ],
  // options: {
  //   multipleSlots: true
  // },
  properties: {
    text: String,
    thumb: String,
    thumbWidth: String,
    thumbHeight: String,
    ellipsis: Boolean,
    borderColor: {
      type: String,
      value: ''
    },
    clamp: {
      type: Number,
      value: 0
    },
    alignment: {
      type: String,
      value: 'vertical'
    },
    mode: {
      type: String,
      value: 'aspectFill'
    }
  },
  data: {
    textStyle: '',
    imageStyle: ''
  },
  lifetimes: {
    attached: function () {
      if (this.properties.clamp > 0) {
        this.setData({
          textStyle: `-webkit-line-clamp: ${this.properties.clamp};`
        })
      }
      var imageStyle = [];
      if (this.properties.thumbWidth) {
        imageStyle.push(`width: ${this.properties.thumbWidth}`)
      }
      if (this.properties.thumbHeight) {
        imageStyle.push(`height: ${this.properties.thumbHeight}`);
      }
      if (this.properties.borderColor) {
        imageStyle.push(`border: 1px solid ${this.properties.borderColor}`);
      }
      if (imageStyle.length > 0) {
        this.setData({
          imageStyle: imageStyle.join(';')
        })
      }
    },
  },
  methods: {
  }
})
