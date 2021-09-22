import styleToCssString from '../helpers/styleToCssString'
const getPlacements = ([a, b] = rects, placement = 'top') => {
  switch (placement) {
    case 'topLeft':
      return {
        top: -(b.height - 4),
        left: 0,
      }
    case 'top':
      return {
        top: -(b.height - 4),
        left: (a.width - b.width) / 2,
      }
    case 'topRight':
      return {
        top: -(b.height - 4),
        right: 0
      }
    case 'rightTop':
      return {
        top: 0,
        right: a.width + 4,
      }
    case 'right':
      return {
        top: (a.height - b.height) / 2,
        right: a.width + 4,
      }
    case 'rightBottom':
      return {
        top: a.height - b.height,
        right: a.width + 4,
      }
    case 'bottomRight':
      return {
        top: a.height + 4,
        right: a.width - b.width,
      }
    case 'bottom':
      return {
        top: a.height + 4,
        left: (a.width - b.width) / 2,
      }
    case 'bottomLeft':
      return {
        top: a.height + 4,
        left: 0,
      }
    case 'leftBottom':
      return {
        top: a.height - b.height,
        left: -(b.width - 4),
      }
    case 'left':
      return {
        top: (a.height - b.height) / 2,
        left: -(b.width - 4),
      }
    case 'leftTop':
      return {
        top: 0,
        left: -(b.width - 4),
      }
    default:
      return {
        left: 0,
        top: 0,
      }
  }
}

Component({
  externalClasses: [
    'custom-class',
    'content-class'
  ],
  options: {
    multipleSlots: true
  },
  properties: {
    clientWidth: {
      type: Number,
      value: 0
    },
    clientHeight: {
      type: Number,
      value: 0
    },
    title: {
      type: String,
      value: '',
    },
    content: {
      type: String,
      value: '',
    },
    placement: {
      type: String,
      value: 'top',
    },
    defaultVisible: {
      type: Boolean,
      value: false,
    },
    mask: {
      type: Boolean,
      value: false,
    },
  },
  data: {
    overlayShow: false,
    fade: 'fade',
    classWrap: '',
    popoverVisible: false,
  },
  methods: {
    getPopoverStyle() {
      const { placement, clientWidth, clientHeight } = this.properties
      const query = wx.createSelectorQuery().in(this)
      query.select('.one-popover__element').boundingClientRect()
      query.select(`.one-popover`).boundingClientRect()
      query.exec((rects) => {
        if (rects.filter((n) => !n).length) return

        if (clientWidth) {
          rects[1].width = Number(clientWidth);
        }
        if (clientHeight) {
          rects[1].height = Number(clientHeight);
        }

        const placements = getPlacements(rects, placement)
        const popoverStyle = styleToCssString(placements)

        this.setData({
          popoverStyle,
        })
      })
    },
    // onEnter() {
    //   this.getPopoverStyle()
    // },
    onChange() {
      const { popoverVisible } = this.data
      const nextVisible = !popoverVisible
      if (nextVisible) {
        this.getPopoverStyle()
        this.triggerEvent('showPopover');
      }
      this.setData({ popoverVisible: nextVisible })
    },
    onClick() {
      this.onChange()
    },
    setBackdropVisible(visible) {
      if (this.data.mask && this.$wuxBackdrop) {
        this.$wuxBackdrop[visible ? 'retain' : 'release']()
      }
    },
    onMaskClick() {
      const { maskClosable, popoverVisible } = this.data
      if (maskClosable && popoverVisible) {
        this.onChange()
      }
    },
    onPopoverClose() {
      this.onChange();
    },
    close() {
      this.setData({ popoverVisible: false })
    }
  }
})
