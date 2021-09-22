/**
 * 产品订单列表项 组件
 */

import Util from './../../utils/util';
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        product:{
            type:Object,
            value:{
                ImageUrls:[],
                ProductName:"商品名称",
                ProductPrice:0,
            },
            observer:"changeProduct",
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        curPrice:"0.00",
        oldPrice:"0.00",
    },

    /**
     * 组件的方法列表
     */
    methods: {
        changeProduct:function(newVal,oldVal){
            if(newVal){
                const curPrice = Util.toDecimal(newVal.ProductOnSalePrice);
                const oldPrice = Util.toDecimal(newVal.ProductPrice);
                this.setData({
                    curPrice:curPrice,
                    oldPrice:oldPrice,
                });
            }
        },
        bindProductDetail:function(){
            const productCode = this.properties.product.ProductCode;
            // console.log(productCode,"----->productCode");
            wx.navigateTo({url: `/pages/product/detail?ProductCode=${productCode}`});
        }
    }
})
