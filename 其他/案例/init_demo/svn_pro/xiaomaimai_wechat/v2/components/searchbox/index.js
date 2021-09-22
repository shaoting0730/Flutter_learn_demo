const app = getApp();
// components/search-box/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    inline: {
      type: Boolean,
      value: false
    },
    withSelect: {
      type: Boolean,
      value: false
    },
    seller: {
      type: Boolean,
      value: false
    },
    ShareGroupKey: {
      type: String,
      value: ''
    },
    className: String,
    tags: {
      type: Array,
      value: [],
      observer: "watchTags"
    },
    topic: {
      type: Array,
      value: [],
      observer: "watchTopic"
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    show: "",
    keywords: "",
    max_showTags: 10,
    max_showTopics: 5,
    button_active: false,
    info: ''
  },

  methods: {
    watchTags(n) {
      const { topic } = this.data;
      const count = topic.filter(item => item.active).length + n.filter(item => item.active).length

      this.setData({
        info: count ? count : ''
      })
    },
    watchTopic(n) {
      const { tags } = this.data;
      const count = tags.filter(item => item.active).length + n.filter(item => item.active).length
      this.setData({
        info: count ? count : ''
      })
    },
    onToggle() {
      this.setData({
        button_active: !this.data.button_active,
        show: this.data.show === "" ? "in" : ""
      });
    },
    onClear() {
      this.onToggle();

      const { tags, topic } = this.properties;
      tags.forEach(item => {
        item.active = false;
      })
      topic.forEach(item => {
        item.active = false;
      })
      this.triggerEvent("onChooseTopic", topic);
      this.triggerEvent("onChooseTag", tags);
      this.onSearch({
        ProductName: [],
        TagList: [],
        keywords: ""
      });
    },
    onClearQuery() {
      const homePage = app.currentPage();
      homePage.setData({
        queryModel: {
          ProductName: [],
          TagList: [],
          keywords: '',
          ShareGroupKey: '',
        }
      });
      app.showToast({ title: '加载全部商品', duration: 2000 });
      homePage.onLoadProductGroupList();
    },
    onSubmit() {
      this.onToggle();
      const { keywords } = this.data;
      const { tags, topic } = this.properties;
      this.onSearch({
        ProductName: topic.filter(item => item.active).map(item => item.name),
        TagList: tags.filter(item => item.active).map(item => item.name),
        keywords: keywords
      });
    },
    // 根据话题筛选Moment
    onChooseTopic(event) {
      const { value } = event.currentTarget.dataset;
      const { topic } = this.properties;
      const item = topic.find(item => item.name === value);
      item.active = !item.active;
      this.triggerEvent("onChooseTopic", topic);
    },
    // 根据标签筛选Moment
    onChooseTag(event) {
      const { value } = event.currentTarget.dataset;
      const { tags } = this.properties;
      const item = tags.find(item => item.name === value);
      item.active = !item.active;
      this.triggerEvent("onChooseTag", tags);
    },
    onSearchConfirm(event) {
      this.setData({
        keywords: event.detail
      });
      this.onSearch({
        ProductName: [],
        TagList: [],
        keywords: event.detail
      });
    },
    onGotoMore(e) {
      const { tags, topic } = this.properties;
      wx.navigateTo({
        url: "/pages/more/index",
        events: {
          getData: callback => {
            callback({ tags, topic });
          },
          onChooseTag: tags => {
            this.triggerEvent("onChooseTag", tags);
          },
          onChooseTopic: topic => {
            this.triggerEvent("onChooseTopic", topic);
          },
        }
      });
    },
    onSearch(searchData) {
      this.triggerEvent("onSearch", searchData);
    }
  }
});
