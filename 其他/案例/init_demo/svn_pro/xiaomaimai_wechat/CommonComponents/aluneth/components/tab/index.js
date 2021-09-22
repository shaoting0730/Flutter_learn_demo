// components/tab/index.js
Component({
    relations: {
        "../tabs/index": {
            type: "ancestor",
            linked: function (target) {

            }
        }
    },
    /**
     * 组件的属性列表
     */
    properties: {
        title: {
            type: String,
            value: ""
        },
        disabled: {
            type: Boolean,
            value: false
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        active: ""
    },

    /**
     * 组件的方法列表
     */
    methods: {

    },
    externalClasses: ["extended-class"]
})
