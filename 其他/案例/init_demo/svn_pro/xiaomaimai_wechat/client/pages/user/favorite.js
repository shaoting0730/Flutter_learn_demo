import webApi from "../../utils/webapi";
import util from "../../utils/util";
const app = getApp();
Page({
    data: {
        page: 1,
        productData: [],
    },
    onLoad: function (options) {
        this.onLoadFavoriteProducts();

        //this.loadProductData();
    },
    onShow: function() {
        this.onLoadFavoriteProducts();
    },
    onLoadFavoriteProducts: function () {
        let productData = [];
        webApi.searchDQProduct({})
            .then(res => {
                if (res && res.Success) {
                    const wishList = app.globalData.wishList;
                    res.Data.ListObjects.forEach(p => {
                        if(wishList.includes(p.Guid)) {
                            productData.push(p);
                        }
                    })
                    console.log("productData: ", productData);
                    this.setData({ productData: productData });
                }
            });
    },
    onPreview: function (event) {
        const guid = event.currentTarget.dataset.guid;
        wx.navigateTo({
            url: '/pages/showdetails/index?pid=' + guid
        })
    },
    onCancel: function (event) {
        console.log("取消收藏");

        const guid = event.currentTarget.dataset.guid;
        webApi.removeProductFromWishList(guid).then(res => {
            if(res && res.Success) {
                const wishList = app.globalData.wishList;
                app.globalData.wishList = wishList.filter(item => item !== guid);
                console.log("globalData: ", app.globalData.wishList);
                this.onLoadFavoriteProducts();
            }
        })
    }
});
