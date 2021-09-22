import webApi from "../../utils/webapi"
const app = getApp()

// components/listbox/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    productList: {
      type: Array,
      value: []
    },
    seller: {
      type: Boolean,
      value: false,
    },
    previewImageDetails:{
      type: Boolean,
      value: true,
    },
  },

  /**
   * 组件的初始数据
   */
  data: {
  },
  /**
   * 组件的方法列表
   */
  methods: {
    /**
     * 发布
     */
    onPublish(event) {
      const vendorproductguid = event.currentTarget.dataset.vendorproductguid;
      const index = event.currentTarget.dataset.index;
      wx.navigateTo({
        url: '/pages/franchise/publish?vendorproduct=' + vendorproductguid + '&vendorguid=' + this.properties.productList[index].VendorGuid
      });
    },
  }
})
