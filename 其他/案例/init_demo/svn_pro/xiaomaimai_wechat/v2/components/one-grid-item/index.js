const computedBehavior = require('miniprogram-computed')

Component({
  behaviors: [computedBehavior],
  externalClasses: [
    'custom-class'
  ],
  relations: {
    '../one-grid/index': {
      type: 'ancestor',
      linked(parent) {
        this.parent = parent;
      }
    }
  },
  properties: {
    icon: String,
    dot: Boolean,
    info: null,
    text: String,
    useSlot: Boolean
  },
  ready() {
    this.updateStyle();
  },
  methods: {
    updateStyle() {
    },
    onClick(e) {
      this.triggerEvent('click', e.detail);
    }
  }
});

function addUnit() {
  return 0;
}
