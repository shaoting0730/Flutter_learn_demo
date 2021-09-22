// components/drawer/drawer-left/index.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        show: {
            type: Boolean,
            value: false
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        show: false
    },
    /**
     * 组件的方法列表
     */
    methods: {
        onClose: function () {
            this.setData({ show: false });
        }
    },
    externalClasses: ['extended-class']
})
