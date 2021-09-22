const app = getApp();
/**
 * 标题栏组件
 */
Component({
  externalClasses: [
    'content-class',
  ],
  data: {
    viewStartTop: app.getSafeAreaTop() + app.globalData.titleHeight,
  },
});
