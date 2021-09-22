// pages/order/pay-result/pay-result-success.js
Page({

    /**
     * 页面的初始数据
     */
    data: {},

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (option) {
        console.log("--->onLoad",option);
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
    onJumpToOrderDetail: function () {
      wx.redirectTo({
            url: `/pages/user/order?currentTab=0`,
        })
    }
})
