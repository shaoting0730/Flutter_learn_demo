// components/carousel/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        imageUrls: {
            type: Array,
            value: []
        },
        indicatorDots: {
            type: Boolean,
            value: false
        },
        indicatorColor: {
            type: String,
            value: "rgba(0, 0, 0, .3)"
        },
        indicatorActiveColor: {
            type: String,
            value: "#000000"
        },
        autoPlay: {
            type: Boolean,
            value: true
        },
        current: {
            type: Number,
            value: 0
        },
        currentItemId: {
            type: String,
            value: ""
        },
        interval: {
            type: Number,
            value: 5000
        },
        duration: {
            type: Number,
            value: 1000
        },
        circular: {
            type: Boolean,
            value: false
        },
        vertical: {
            type: Boolean,
            value: false
        },
        previousMargin: {
            type: String,
            value: "0px"
        },
        nextMargin: {
            type: String,
            value: "0px"
        },
        displayMultipleItems: {
            type: Number,
            value: 1
        },
        skipHiddenItemLayout: {
            type: Boolean,
            value: false
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
        onChange: function (event) {
            this.triggerEvent("change", event.detail);
        },
        onAnimationFinish: function (event) {
            this.triggerEvent("animationfinish", event.detail);
        }
    }
})
