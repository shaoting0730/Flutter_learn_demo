// components/footer/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
      badge: {
        type: String,
        value: "",
      },
      active: {
          type: String,
          value: "",
      },
      seller: {
        type: Boolean,
        value: false,
      }    
    },

    /**
     * 组件的初始数据
     */
    data: {},

    /**
     * 组件的方法列表
     */
    methods: {
        onChange(event) {
            switch (event.detail) {
                case 0:
                  wx.redirectTo({
                        url: '/pages/home/index',
                    });
                    break;
                case 1:
                    wx.redirectTo({
                        url: '/pages/aboutme/index?active=' + event.detail,
                    });
                    break;
              case 2:
                wx.redirectTo({
                  url: '/pages/cart/cart',
                });
                break;
            }
        }
    }
})
