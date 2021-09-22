Component({
  externalClasses: [
    'custom-class'
  ],
  relations: {
    '../one-grid-item/index': {
      type: 'descendant',
      linked(child) {
        this.children.push(child);
      },
      unlinked(child) {
        this.children = this.children.filter((item) => item !== child);
      }
    }
  },

  properties: {
    square: {
      type: Boolean,
      observer: 'updateChildren'
    },
    gutter: {
      type: [Number, String],
      value: 0,
      observer: 'updateChildren'
    },
    clickable: {
      type: Boolean,
      observer: 'updateChildren'
    },
    columnNum: {
      type: Number,
      value: 4,
      observer: 'updateChildren'
    },
    center: {
      type: Boolean,
      value: true,
      observer: 'updateChildren'
    },
    border: {
      type: Boolean,
      value: true,
      observer: 'updateChildren'
    }
  },
  created() {
    this.children = [];
  },
  attached() {
    const { gutter } = this.data;
    if (gutter) {
      this.setData({
        style: `padding-left: ${addUnit(gutter)}`
      });
    }
  },
  methods: {
    updateChildren() {
      this.children.forEach((child) => {
        child.updateStyle();
      });
    }
  }
});

function addUnit() {
  return 0;
}
