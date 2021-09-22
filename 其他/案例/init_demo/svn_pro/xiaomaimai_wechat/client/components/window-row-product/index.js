/**
 * 标题栏组件
 */
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        left:{
            type:String,
            value:"",
        },
        right:{
            type:String,
            value:"",
        },
        data:{
            type:Object,
            value:null,
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
        bindTapRight:function(){
            console.log("widow-row-product--->",this.properties);
            this.triggerEvent('tapRight',{data:this.properties.data});
        }
    }
})
