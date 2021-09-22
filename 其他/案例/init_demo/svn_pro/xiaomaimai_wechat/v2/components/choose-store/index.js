const app = getApp()


Component({
  properties: {
    myAccessStores: {
      type: Array,
      value: [],
    },
  },

  data: {
    myVisitStores: [],
    myOwnStores: [],
    needAuthor: false,
    safeAreaBottom: app.getSafeAreaBottom(),
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
  },

  methods: {
    updateData(myAccessStores) {
      if (!myAccessStores || myAccessStores.length === 0) return;
      let myVisitStores = [];
      let myOwnStores = [];

      for (let index = 0; index < myAccessStores.length; index++) {
        if (myAccessStores[index].IsOwner === true) {
          myOwnStores.push(myAccessStores[index]);
        } else {
          myVisitStores.push(myAccessStores[index]);
        }
      }
      const needAuthor =  myOwnStores.length === 0;
      this.setData({
        myVisitStores: myVisitStores,
        myOwnStores: myOwnStores,
        needAuthor: needAuthor,
        scrollHeight: app.getClientAreaHeight() - (needAuthor ? app.globalData.bottomTabBarHeight : 0)
      });
    },
    onApplyNew: function () {
      wx.navigateTo({
        url: '/pages/gzh/index',
      });
    },
    onChooseStore: function (e) {
      app.changeStore(e.currentTarget.dataset.storeguid);
    },
  },

  observers: {
    'myAccessStores': function (myAccessStores) {
      this.updateData(myAccessStores);
    }
  }
});
