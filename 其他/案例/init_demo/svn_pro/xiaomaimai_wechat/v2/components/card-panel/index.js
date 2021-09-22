/**
 * card-panel 卡布局-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */
Component({
    /**
     * 组件的属性列表
     */
    externalClasses: ['root-class', "right-title-class"],
    properties: {
        showTitle: {
            type: Boolean,
            value: true
        },
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
        showTitleBottomLine: {
            type: Boolean,
            value: false,
        },
        showBottomLine: {
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
