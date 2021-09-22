Page({

    /**
     * 页面的初始数据
     */
    data: {
        drawer_left_show: false,
        drawer_right_show: false,
        imageUrls: [
            'https://images.unsplash.com/photo-1537944434965-cf4679d1a598?auto=format&fit=crop&w=400&h=250&q=60',
            'https://images.unsplash.com/photo-1538032746644-0212e812a9e7?auto=format&fit=crop&w=400&h=250&q=60',
            'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=400&h=250&q=80',
            'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=400&h=250&q=60',
            'https://images.unsplash.com/photo-1512341689857-198e7e2f3ca8?auto=format&fit=crop&w=400&h=250&q=60'
        ]
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {

    },

    /**
     * 生命周期函数--监听页面初次渲染完成
     */
    onReady: function () {

    },

    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {

    },

    /**
     * 生命周期函数--监听页面隐藏
     */
    onHide: function () {

    },

    /**
     * 生命周期函数--监听页面卸载
     */
    onUnload: function () {

    },

    /**
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh: function () {

    },

    /**
     * 页面上拉触底事件的处理函数
     */
    onReachBottom: function () {

    },

    /**
     * 用户点击右上角分享
     */
    onShareAppMessage: function () {

    },
    onClickListItem: function (event) {
        console.log("onClickListItem: ", event);
    },
    onOpenLeftDrawer: function (event) {
        this.setData({
            drawer_left_show: true
        });
    },
    onOpenRightDrawer: function (event) {
        this.setData({
            drawer_right_show: true
        });
    },
    onChangeTab:function (event) {
        wx.showToast({
            title: `切换到Item ${event.detail.current + 1}`,
            icon: "none"
        })

        console.log("onChangeTab: ", event);
    },
    onChangeTabbar: function (event) {
        console.log("onChangeTabbar: ", event);
    },
    onChangeCarousel: function (event) {
        console.log("onChangeCarousel: ", event)
    },
    onAnimationFinish: function (event) {
        console.log("onAnimationFinish: ", event);
    }
})
