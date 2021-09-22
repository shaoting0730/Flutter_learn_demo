/**
 * 空白占位组件
 */
Component({
    externalClasses: ['placeholder-class',"image-class","title-class"],
    /**
     * 组件的属性列表
     */
    properties: {
        show:{
            type:Boolean,
            value:false,
        },
        title:{
            type:String,
            value:"没有可用订单/(ㄒoㄒ)/~~",
        },
        src:{
            type:String,
            value:"../../images/search_no.png",
        }
    },

    /**
     * 组件的初始数据
     */
    data: {},

    /**
     * 组件的方法列表
     */
    methods: {}
})
