/**
 * CSwitch 切换-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */
Component({
    /**
     * 组件的属性列表
     */
    externalClasses: ['root-class'],
    properties: {
        checked: {
            type: Boolean,
            value: false,
        },
        color: {
            type: String,
            value: "#64bd63",
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
        bindTap: function () {
            const {checked} = this.properties;
            console.log("bindTap",)
            this.triggerEvent("bindtap", {checked: checked});
            this.triggerEvent("changed", {checked: !checked});
        }
    }
});
