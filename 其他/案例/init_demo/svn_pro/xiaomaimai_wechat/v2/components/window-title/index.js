const app = getApp();
/**
 * 标题栏组件
 */
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    left: {
      type: String,
      value: "小买卖圈",
    },
    leftIcon: {
      type: String,
      value: "../../images/logo_xmmq_120.png",
    },
    right: {
      type: String,
      value: "",
    },
    choose: {
      type: Boolean,
      value: true
    }
  },
  /**
   * 组件的初始数据
   */
  data: {
    safeAreaTop: app.getSafeAreaTop(),
  },
  /**
   * 组件的方法列表
   */
  methods: {
    onToChangeStore() {
      const {choose} = this.properties;
      if(choose){
        wx.navigateTo({ url: "/pages/change-store/index" });
      }
    },
  }
})
