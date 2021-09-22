/**
 * 产品图走马灯组件
 */
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        autoplay: {
            type: Boolean,
            value: true,
        },
        indicatorDots: {
            type: Boolean,
            value: true,
        },
        circular: {
            type: Boolean,
            value: true,
        },
        interval: {
            type: Number,
            value: 3000,
        },
        duration: {
            type: Number,
            value: 250,
        },
        product: {
            type: Object,
            value: {
                ImageUrls: [],
                ProductName: "商品名称",
                ProductPrice: 0,
            },
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        screenWidth: 750,
        screenHeight: 750,
    },
    attached: function () {
        console.log(this, "---->tab");
        wx.getSystemInfo({
            success: (res) => {
                this.setData({
                    screenWidth: res.windowWidth,
                    screenHeight: res.windowHeight,
                });

            }
        })
    },
    /**
     * 组件的方法列表
     */
    methods: {
        bindPreviewImage: function (e) {
            const {screenWidth, screenHeight} = this.data;
            const product = this.properties.product;
            const imageidx = e.target.dataset.imageidx;
            let imageList = [];
            product.ImageUrls.map((imageUrl, index) => {
                const fullImageUrl = `${imageUrl}?imageMogr2/format/jpg/thumbnail/${screenWidth * 2}x${screenHeight * 2}`;
                imageList.push(fullImageUrl);
            });

            wx.previewImage({
                current: imageidx,
                urls: imageList,
            });
        }
    }
})
