/**
 * card-panel-title 卡布局标题栏-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */
Component({
    options: {
        multipleSlots: true
    },
    /**
     * 组件的属性列表
     */
    externalClasses: ['root-class', 'right-title-class'],
    properties: {
        titleRight: {
            type: String,
            value: "",
        },
        title: {
            type: String,
            value: "",
        },
        showRightArrow: {
            type: Boolean,
            value: false,
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
        bindTapRight: function () {
            this.triggerEvent('tapRight', {});
        }
    }
});
