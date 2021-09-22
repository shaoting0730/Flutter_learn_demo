/**
 * ComponentName XXX-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */
Component({
    /**
     * 组件的属性列表
     */
    externalClasses: ['root-class','title-class'],
    properties: {
        checked:{
            type:Boolean,
            value:false,
        },
        title:{
            type:String,
            value:'',
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
        bindClick:function(event){
            this.triggerEvent('change',{checked:this.properties.checked});
        }
    }
});
