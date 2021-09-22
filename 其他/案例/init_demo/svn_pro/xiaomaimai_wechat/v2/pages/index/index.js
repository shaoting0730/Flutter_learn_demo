//index.js
//获取应用实例
const app = getApp()

Page({
  data: {
    status: 'loading',
    canIUse: wx.canIUse('button.open-type.getUserInfo')
  },
  onLoad: function ()  {
    const self = this;
    app.getUserInfo({success: () => {
        app.GetMyStoreList({success: (stores) => {
          if(stores.count !== 1) {
            self.setData({status: 'choose-store', myAccessStores: stores});
          }
          else {
            app.gotoStore(stores[0].StoreGuid);
          }
        }});
    }, fail: () => {
      self.setData({status: 'need-author'});
    }});
  }
})
