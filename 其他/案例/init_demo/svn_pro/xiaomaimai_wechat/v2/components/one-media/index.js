Component({
  externalClasses: [
    'custom-class',
    'image-class',
    'content-class',
    'body-class',
    'title-class'
  ],
  options: {
    multipleSlots: true
  },
  properties: {
    image: {
      type: String,
      value: null
    },
    imageSize: {
      type: [Number, String],
      value: 40
    },
    title: {
      type: String,
      value: null
    },
  },
  methods: {
    onClick(e) {
      this.triggerEvent('click', e);
    }
  }
});


