var app = getApp();
Page({
  data: {
    safeAreaBottom: app.getSafeAreaBottom(),
    topics: [],
    tags: []
  },
  onLoad(o) {
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.emit("getData", data => {
      this.setData({
        topics: data.topic,
        tags: data.tags
      });
    });
  },
  onChooseTopic(e) {
    const { index } = e.currentTarget.dataset;
    const { topics } = this.data;
    topics[index].active = !topics[index].active;
    this.setData({ topics });
  },
  onChooseTag(e) {
    const { index } = e.currentTarget.dataset;
    const { tags } = this.data;
    tags[index].active = !tags[index].active;
    this.setData({ tags });
  },
  onConfirm() {
    const { topics, tags } = this.data;
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.emit("onChooseTag", tags);
    eventChannel.emit("onChooseTopic", topics);
    wx.navigateBack();
  }
});
