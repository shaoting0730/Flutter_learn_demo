// pages/more/index.js
Page({

    /**
     * 页面的初始数据
     */
    data: {
        topics: [],
        tags: []
    },
    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
      const pages = getCurrentPages();
      const homePage = pages[0];
      let hometopics = homePage.data.productGroupNames;
      let hometags = homePage.data.productTags;
      if (homePage.data.queryModel.ProductName)
      {
        hometopics.forEach(s => {
          if (homePage.data.queryModel.ProductName.filter(function (value) {
            return value === s.groupName
          }).length > 0)
            s.active = true;
        });
      }
      if (homePage.data.queryModel.TagList)
      {
        hometags.forEach(s => {
          if (homePage.data.queryModel.TagList.filter(function (value) {
            return value === s.tagName
          }).length > 0)
            s.active = true;
        });
      }
      this.setData({ topics: hometopics, tags: hometags });
    },
    // 根据话题筛选Moment
    onChooseTopic: function (event) {
        const index = event.currentTarget.dataset.index;
        let topics = this.data.topics;
        topics[index].active = !topics[index].active;
        this.setData({topics: topics});

        const pages = getCurrentPages();
        const homePage = pages[0];
        homePage.setData({productGroupNames: topics});
    },
    onChooseTag: function (event) {
        const index = event.currentTarget.dataset.index;
        let tags = this.data.tags;
        tags[index].active = !tags[index].active;
        this.setData({tags: tags});

        const pages = getCurrentPages();
        const homePage = pages[0];
        homePage.setData({productTags: tags});
    },
    onConfirm: function (event) {
        const pages = getCurrentPages();
        const homePage = pages[0];
        let topics = [];
        this.data.topics.filter(function (value) {
            return value.active === true
        }).forEach(s => topics.push(s.groupName));
        let tags = [];
        this.data.tags.filter(function (value) {
            return value.active === true
        }).forEach(s => tags.push(s.tagName));

        homePage.setData({
            queryModel: {
                ProductName: topics,
                TagList: tags
            }
        });

        wx.navigateBack();
    }
})