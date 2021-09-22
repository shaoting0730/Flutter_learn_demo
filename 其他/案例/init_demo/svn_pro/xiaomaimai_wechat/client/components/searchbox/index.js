// components/search-box/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        inline: {
            type: Boolean,
            value: false
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
      show: "",
      button_active: false,
      productGroupNames:[],
      productTags:[],
      keywords: "",
      max_showTags: 10,
      max_showTopics: 5
    },

    /**
     * 组件的方法列表
     */
    methods: {
      onSearch() {
        this.onToggle();
        const pages = getCurrentPages();
        const homePage = pages[pages.length-1];
        let homeTopics = homePage.data.productGroupNames;
        let homeTags = homePage.data.productTags;
        if (homePage.data.queryModel.ProductName)
        {
          homeTopics.forEach(s => {
            if (homePage.data.queryModel.ProductName.filter(function (value) {
              return value === s.groupName
            }).length > 0)
              s.active = true;
          });
        }
        if (homePage.data.queryModel.TagList)
        {
          homeTags.forEach(s => {
            if (homePage.data.queryModel.TagList.filter(function (value) {
              return value === s.tagName
            }).length > 0)
              s.active = true;
          });
        }
        this.setData({ productGroupNames: homeTopics, productTags: homeTags });
      },
      onClear:function(event){
        this.onToggle();
        const pages = getCurrentPages();
        const homePage = pages[pages.length - 1];
        homePage.setData({
          queryModel: {
            ProductName: [],
            TagList: [],
            keywords: ''
          }
        });
        homePage.onLoadProductGroupList();
      },
      onSubmit: function (event) {
          this.onToggle();
          const pages = getCurrentPages();
        const homePage = pages[pages.length - 1];
          let topics = [];
          let tags = [];
          this.data.productGroupNames.filter(function (value) {
              return value.active === true
          }).forEach(s => topics.push(s.groupName));

        this.data.productTags.filter(function (value) {
              return value.active === true
          }).forEach(s => tags.push(s.tagName));
          homePage.setData({
              queryModel: {
                  ProductName: topics,
                  TagList: tags,
                  keywords: this.data.keywords
              }
          });
          homePage.onLoadProductGroupList();
      },
      onCancel: function (event) {
          this.onToggle();
          console.log("取消", event);
      },
      onClickBackDrop: function (event) {
          this.onToggle();
      },
      onToggle: function (event) {
          this.setData({button_active: !this.data.button_active});
          this.setData({show: this.data.show === "" ? "in" : ""});
      },
      onInit: function (event) {
        this.setData({show: ""});
        this.setData({button_active: false});
      },
      // 根据话题筛选Moment
      onChooseTopic: function (event) {
          const index = event.currentTarget.dataset.index;
          let productGroupNames = this.data.productGroupNames;
          productGroupNames[index].active = !productGroupNames[index].active;
          this.setData({productGroupNames: productGroupNames});
          // 更新home/index中的productGroupNames数据
          const pages = getCurrentPages();
        pages[pages.length - 1].setData({productGroupNames: productGroupNames});
      },
      // 根据标签筛选Moment
      onChooseTag: function (event) {
          const index = event.currentTarget.dataset.index;
          let productTags = this.data.productTags;
          productTags[index].active = !productTags[index].active;
          this.setData({productTags: productTags});
          // 更新home/index中的productGroupNames数据
          const pages = getCurrentPages();
        pages[pages.length - 1].setData({productTags: productTags});
      },
      onSearchConfirm: function (event) {
        const pages = getCurrentPages();
        const homePage = pages[pages.length - 1];
        homePage.setData({
          queryModel: {
            ProductName: [],
            TagList: [],
            keywords: event.detail.value,
          }
        });
        homePage.onLoadProductGroupList();                    
      },
      onGotoMore: function (event) {
          // 跳转到more页面
          wx.navigateTo({
              url: '/pages/more/index'
          })
      }
    }
})
