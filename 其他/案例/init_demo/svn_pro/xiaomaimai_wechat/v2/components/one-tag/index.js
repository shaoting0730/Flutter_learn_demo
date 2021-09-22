
Component({
  properties: {
    type: {
      type: String,
      value: ''
    },
    hasHover: {
      type: Boolean,
      value: false
    },
    icon: {
      type: String,
      value: ''
    }
  },
  data: {
  },
  methods: {
    onClick(e){
      this.triggerEvent('click');
    }
  }
});
