/**
 * ComponentName XXX-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */
Component({
    /**
     * 组件的属性列表
     */
    externalClasses: ['root-class'],
    properties: {
        url: {
            type: String,
            value: "",
        },
        title: {
            type: String,
            value: "",
        },
        subTitle: {
            type: String,
            value: "",
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
        bindDelete(){
            console.log("--->删除当前记录")
            this.triggerEvent("delete");
        }
    }
});
