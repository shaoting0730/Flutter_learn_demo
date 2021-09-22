var app = getApp();

// pages/tag/index.js
Page({

    /**
     * 页面的初始数据
     */
    data: {
        value: "",
        tags: [],
        // 最大输入五个标签
        maxTagsCount: 5,
        historyTags: [],
        productIndex: 0
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
      this.setData({ historyTags: app.globalData.productTagList});
      this.setData({ productIndex: options.productIndex });
      let pages = getCurrentPages();
      let momentPage = pages[pages.length - 2];
      let products = momentPage.data.products;
      if (products.length > this.data.productIndex)
        this.setData({ tags: products[this.data.productIndex].TagList});
    },
    bindInputConfirm: function (event) {
        let list = [];
        if(this.data.tags.length < this.data.maxTagsCount && event.detail.value.trim() !== "") {
            list.push(event.detail.value.trim());
        }

        this.setData({ value: "" });
        this.setData({ tags: [...this.data.tags, ...list] })
    },
    bindKeyInput: function (event) {
        console.log("bindKeyInput", event);
        let list = this.data.tags;
        if(event.detail.value === "") {
            if(event.detail.keyCode === 8) {
                let lastItem = list.pop();
                this.setData({ tags: list });
                this.setData({ value: lastItem });
            }
        }
    },
    bindAddTag: function (event) {
        let tagName = event.target.dataset.name;
        let list = this.data.tags;
        if(list.length < this.data.maxTagsCount) {
            list.push(tagName);
            this.setData({ tags: list });
        }
    },
    bindEditTag: function (event) {
        this.setData({ hide_icon_remove: false });
    },
    bindSubmitTags: function (event) {
      let pages = getCurrentPages();
      let momentPage = pages[pages.length - 2];
      let products = momentPage.data.products;
      products[this.data.productIndex].TagList = this.data.tags;
      momentPage.setData({ products: products});
      wx.navigateBack({ changed: true })
    }
})