// components/imagelist/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        productList: {
            type: Array,
            value: []
        },
        moments: {
            type: Array,
            value: []
        },
        displayPirce:{
          type: Boolean,
          value:true,
        },
        previewImageDetails:{
          type: Boolean,
          value: true,
        },
    },

    /**
     * 组件的初始数据
     */
    data: {},

    /**
     * 组件的方法列表
     */
    methods: {
        onPreview: function (event) {
          if(this.properties.previewImageDetails)
          {
            const guid = event.currentTarget.dataset.guid;
            wx.navigateTo({
              url: '/pages/showdetails/index?pid=' + guid
            });
          }
          else
          {
            const index = event.currentTarget.dataset.index;
            wx.previewImage({
              current: this.properties.productList[index].PictureList[0],
              urls: this.properties.productList[index].PictureList,
            });            
          }
        },
    },
    externalClasses: ['custom-class']
})
