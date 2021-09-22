// pages/showdetails/index.js
import webApi from "../../utils/webapi";

const app = getApp();
Page({

    /**
     * 页面的初始数据
     */
    data: {
        indicatorDots: false,
        autoplay: false,
        current: 1,
        collapse: true,
        duration: 100,
        list: [],
        seller: false
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
      const currentPid = options.pid;
      const pages = getCurrentPages();
      const homePage = pages[pages.length-2];
      let list = [];
      if (homePage.data.active==0)
      {
        homePage.data.moments.forEach(group => {
          group.ProductList.forEach(item => {
            list.push(item);
          })
        })
      }
      else if (homePage.data.photoWallList)
      {
        homePage.data.photoWallList.forEach(items => {
          items[1].forEach(item => {
            if(item.product.VideoUrl)
            {
              var listItem = JSON.parse(JSON.stringify(item.product));
              list.push(listItem);
            }
            else
            {
              for (var i = 0; i < item.product.PictureList.length; i++) {
                var listItem = JSON.parse(JSON.stringify(item.product));
                listItem.PictureList = [];
                listItem.PictureList.push(item.product.PictureList[i]);
                list.push(listItem);
              }
            }
          })
        })
      }
      else if (homePage.data.productData) {///from favorite page
        list = homePage.data.productData
      }
      let currentIndex = list.findIndex(item => item.Guid === currentPid);
      this.setData({current: currentIndex, list: list, seller: app.globalData.seller});

        /* let item = event.target.dataset.src;
            let index = pictures.findIndex(v => v === item); */
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
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh: function () {

    },

    /**
     * 页面上拉触底事件的处理函数
     */
    onReachBottom: function () {

    },
 
    onCollapse: function (event) {
        this.setData({collapse: !this.data.collapse})
    },
    onAddToCart: function (event) {
        const guid = event.currentTarget.dataset.guid;
        let quantity = 1;
        webApi.addToShoppingCart(guid, quantity).then(res => {
            if (res && res.Success) {
                wx.showToast({
                  title: '添加购物车成功',
                })
                ///this.reloadPhotoWall();
            }
        })
    },
    onEditProduct: function (event) {
        const guid = event.currentTarget.dataset.guid;
        wx.navigateTo({
          url: '/pages/productedit/index?productId=' + guid
        });
    },
  onRemoveProduct: function (event) {
    wx.showModal({
      title: '提示',
      content: '确定删除整个商品吗？',
      success(res) {
        if (res.confirm) {
          const guid = event.currentTarget.dataset.guid;
          webApi.removeDQProduct([guid]).then(res => {
            console.log("remove list: ", res);
          });
          wx.redirectTo({
            url: '/pages/home/index'
          });
          } else if (res.cancel) {
        }
      }
    })
  }
})