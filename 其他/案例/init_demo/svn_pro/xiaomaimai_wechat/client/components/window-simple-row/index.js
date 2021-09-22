/**
 * ComponentName XXX-组件
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
    externalClasses: ['root-class'],
    properties: {
        title:{
            type:String,
            value:'',
        },
        showRightArrow:{
            type:Boolean,
            value:false,
        },
        showTitleBottomLine:{
            type:Boolean,
            value:false,
        },
        iconUrl:{
            type:String,
            value:'',
        },
    },

    /**
     * 组件的初始数据
     */
    data: {},

    attached:function(){
        console.log(this,"xxxxx-->properties",this.properties);
    },
    /**
     * 组件的方法列表
     */
    methods: {
        bindTapRow:function(){
            this.triggerEvent("tapRow",{});
        }
    }
});
