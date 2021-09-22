import Util from "../../utils/util";

/**
 * 标题栏组件
 */
Component({
  externalClasses: [
    'icon-class',
  ],
  properties: {
    url: {
      type: String,
      value: null,
    },
    title: {
      type: String,
      value: '--',
    },
    fontSize: {
      type: Number,
      value: 14,
    },
    copy: {
      type: Boolean,
      value: false,
    },
    iconSize: {
      type: Number,
      value: 20,
    },
    iconRadius: {
      type: String,
      value: '',
    },
    fontColor: {
      type: String,
      value: '#000',
    },
    textShow: {
      type: Boolean,
      value: true,
    },
    copyText:{
      type: String,
      value: '复制',
    }
  },

  /**
   * 组件的初始数据
   */
  data: {},

  /**
   * 组件的方法列表
   */
  methods: {
    onCopy: function () {
      Util.setClipboard(this.properties.title, `${this.properties.title} 已复制到剪贴板`);
    }
  }
})
