// components/tabbar-item/index.js
Component({
    relations: {
        "../tabbar/index": {
            type: "ancestor",
            linked: function (target) {

            }
        }
    },
    /**
     * 组件的属性列表
     */
    properties: {
        icon: {
            type: String,
            value: ""
        },
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
        onChange: function () {
            const parent = this.getRelationNodes('../tabbar/index')[0];
            parent.onChange(this);
        }
    },
    externalClasses: ["extended-class"]
})
