Component({
  externalClasses: [
    'custom-class'
  ],
  properties: {
    selected: {
      type: Boolean,
      value: false
    },
    url: {
      type: String,
      value: ''
    },
    order: {
      type: Number,
      value: 0
    },
    description: {
      type: String,
      value: ''
    }
  },
  methods: {
    onClick(e) {
      this.triggerEvent('click');
    }
  }
});


