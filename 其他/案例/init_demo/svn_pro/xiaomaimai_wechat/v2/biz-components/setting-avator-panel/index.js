import Util from "../../utils/util";
import Request from "../../utils/request";
const app = getApp()
/**
 * ComponentName XXX-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */
Component({
  /**
   * 组件的属性列表
   */
  externalClasses: ['root-class'],
  properties: {
    avatarUrl: {
      type: String,
      value: "",
    },
    nickName: {
      type: String,
      value: "",
      observer: "changeApiLoginInfo",
    },
    vendorCode: {
      type: String,
      value: "",
    },
    balance: {
      type: Number,
      value: 0,
    },
    level: {
      type: Number,
      value: 1,
    },
    isLogin: {
      type: Boolean,
      value: false,
    },
    showBalance: {
      type: Boolean,
      value: false,
    },
    showExport: {
      type: Boolean,
      value: false,
    },
    storeInfo: {
      type: Object,
      value: {}
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    maskPhoneNumber: "暂未填写手机号",
    show: false,
  },

  /**
   * 组件的方法列表
   */
  methods: {
    changeApiLoginInfo() {
      console.log("changeApiLoginInfo------>");
      const apiLoginInfo = Request.getApiLoginInfo();
      if (apiLoginInfo) {
        this.setData({
          maskPhoneNumber: Util.maskInfo(apiLoginInfo.CellPhone, "*", 3, 3),
        });
      }
    },
    bindQRCode: function () {
      wx.navigateTo({
        url: "/pages/share-to-friend/index"
      })
    },
    bindUserEditor: function () {
      if (this.properties.showExport) {
        app.currentPage().showSellerDialog(true);
      }
    },
    btnExportOrder: function () {
      wx.navigateTo({
        url: '/pages/order/orderselection?selectionType=export',
      });
    },
    openSellerInfo() {
      app.currentPage().showSellerDialog(false);
    }
  }
});
