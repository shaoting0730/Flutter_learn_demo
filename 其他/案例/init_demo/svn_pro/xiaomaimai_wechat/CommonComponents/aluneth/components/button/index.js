// components/buttons/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        inline: {
            type: String,
            value: 'inline'
        },
        size: {
            type: String,
            value: 'medium'
        },
        type: {
            type: String,
            value: "default"
        },
        value: {
            type: String,
            value: "default"
        },
        disabled: {
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

    },
    externalClasses: ["extended-class"]
})
