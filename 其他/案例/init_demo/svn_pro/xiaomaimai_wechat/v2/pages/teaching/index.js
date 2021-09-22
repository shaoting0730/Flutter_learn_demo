var app = getApp();

Page({
  data: {
    scrollHeight: app.getClientAreaHeight() - app.globalData.bottomTabBarHeight,
    safeAreaBottom: app.getSafeAreaBottom(),
    seller: true,
    sellerVideos: [{
      title: '一：如何开店？',
      adImage: '/images/qrcode_for_gh.jpg',
      description: '开店前需要先关注小买卖圈微信公众号，微信扫描下方二维码关注，关注成功即可在公众号内开店',
      video: 'http://cdn.xiaomaimaiquan.com/video/OpenStore-1080.mp4',
    }, {
      title: '二：如何发布新店主推荐？',
      video: 'http://cdn.xiaomaimaiquan.com/video/ReleaseDynamics-1080.mp4',
    }, {
      title: '三：如何管理商品？',
      video: 'http://cdn.xiaomaimaiquan.com/video/EditProduct-1080.mp4'
    }, {
      title: '四：如何推广我的店铺？',
      video: 'http://cdn.xiaomaimaiquan.com/video/ShareProduct-1080.mp4'
    }, {
      title: '五：如何绑定供应商？',
      video: 'http://cdn.xiaomaimaiquan.com/video/Supplier-1080.mp4'
    }, {
      title: '六：如何处理订单状态或发货？',
      video: 'http://cdn.xiaomaimaiquan.com/video/ProcessOrder-1080.mp4'
    }, {
      title: '七：如何批量导出订单信息？',
      video: 'http://cdn.xiaomaimaiquan.com/video/ExportOrder-1080.mp4'
    }],
    buyerVideos: [{
      title: '一：如何购买商品？',
      adImage: '/images/qrcode_for_gh.jpg',
      description: '商品分定价和待议价两种，这两种付款方式有些不同。定价商品可直接跳转到小买卖圈服务号完成转账，只需等待卖家确认即可。待议价商品先联系卖家进行沟通再直接转账。',
      subdes: '*定价商品在服务号付款，付款完成记得在微信上通知店主哦',
      video: [{
        title: '定价商品下单流程',
        url: 'http://cdn.xiaomaimaiquan.com/video/PayOrder-1080.mp4',

      },
      {
        title: '待议价商品下单流程',
        url: 'http://cdn.xiaomaimaiquan.com/video/PricePendingOrder-1080.mp4',
      }]
    }, {
      title: '二：如何切换店铺浏览？',
      video: [{ url: 'http://cdn.xiaomaimaiquan.com/video/SwitchStores-1080.mp4' }]
    }],
    show: false,
    videoUrl: '',
  },
  onLoad(options) {
    console.log(options)
    this.setData({
      seller: options.seller === 'true'
    })
  },
  onGoyoHome(e) {
    wx.navigateBack();
  },
  onShowVideo(e) {
    const { url } = e.currentTarget.dataset;
    this.setData({
      videoUrl: url,
      show: true
    })
  },
  prevideoClose(e) {
    this.setData({
      videoUrl: '',
      show: false
    })
  }
})
