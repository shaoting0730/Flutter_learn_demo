// pages/advertisement/advertisementhistory.js
import webapi from "../../utils/webapi"
import util from "../../utils/util"
import Request from "../../utils/request"

const app = getApp()

Page({

    /**
     * 页面的初始数据
     */
    data: {
        seller: false,
        advertisements: [],
        photoWallList: null,
        publish: 0,
        StoreGuid: '',
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
        if (options.publish)
            this.setData({publish: options.publish});
        this.setData({seller: app.globalData.seller, StoreGuid: Request.getStoreGuid()});
        let query = {};
        if (this.data.publish == 1) {
            query = {PublishStoreGuid: Request.getStoreGuid(), DisplayStoreGuid: ''};
        } else {
            query = {PublishStoreGuid: Request.getStoreGuid(), DisplayStoreGuid: '', ExcludeSearch: true};
        }
        webapi.SearchAdvertisement(query).then((res1) => {
            console.log(res1);
            if (res1.Success) {
                var list = res1.Data.ListObjects;
                list.forEach((val, key) => {
                    val.GroupName = '广告';
                    val.Description = val.Advertisement.Description;
                    val.UpdatedOn = util.timeStampToDateTime(val.Advertisement.CreatedOn, 'M-D');
                });
                this.setData({
                    advertisements: list,
                    photoWallList: list
                });
            }
        });
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
    }
})
