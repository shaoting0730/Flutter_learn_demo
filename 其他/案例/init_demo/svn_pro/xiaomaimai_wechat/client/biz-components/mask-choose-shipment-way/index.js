/**
 * 产品图走马灯组件
 */

import WebApi from '../../utils/webapi';

Component({
    /**
     * 组件的属性列表
     */
    properties: {
        animDuration:{
          type:Number,
          value:250,
        },
        hideDialog:Object,
        product:{
            type:Object,
            value:{
                ImageUrls:[],
                ProductName:"商品名称",
                ProductPrice:0,
            },
        },
        productMin:{
            type:Number,
            value:1,
        },
        productMax:{
            type:Number,
            value:99,
        },
    },

    /**
     * 组件的初始数据
     */
    data: {
        buynum:1,
        show:false,
        selectedProducts:[],
    },
    /**
     * 组件的方法列表
     */
    methods: {
        // 弹窗
        showDialog: function (selectedProducts) {
            console.log("showDialog--->")

            var animation = wx.createAnimation({
                duration: this.data.animDuration,
                timingFunction: "ease",
                delay: 0
            });
            animation.translateY(0).step();

            this.setData({
                show:true,
                selectedProducts:selectedProducts,
                // animationData: animation.export()
            },()=>{

                setTimeout(()=>{
                    this.setData({
                        animationData: animation.export()
                    });
                },50);


            });
        },
        hideDialog: function (doneCallBack) {
            console.log("hideDialog--->")
            var animation = wx.createAnimation({
                duration: this.data.animDuration,
                timingFunction: "ease",
                delay: 0
            });
            animation.translateY(750).step();

            this.setData({
                animationData: animation.export()
            });

            setTimeout(()=>{
                this.setData({
                    show:false,
                },()=>{
                    if(typeof(doneCallBack)=="function"){
                        doneCallBack();
                    }
                });
            },this.data.animDuration);

        },
        bindDeliveryToDoor:function(e){
            const {selectedProducts} = this.data;
            console.log("click bindDeliveryToDoor");
            this.hideDialog(()=>{
                wx.navigateTo({
                    url: '/pages/order/pay?productData=' + JSON.stringify(selectedProducts),
                });
            });
        },
        bindSelfDelivery:function(){
            const {selectedProducts} = this.data;
            console.log("click bindSelfDelivery");
            this.hideDialog(()=>{
                wx.navigateTo({
                    url: '/pages/pay_ways/pay_self?productData=' + JSON.stringify(selectedProducts),
                });
            });
        },
        addShopCart: function (e) { //添加到购物车
            var redirectUrl = '';
            let selectProductList = [];
            selectProductList.push(this.data.product.ProductCode);
            if (e.currentTarget.dataset.type == 'buynow') {
                redirectUrl = '../order/pay?productData='+JSON.stringify(selectProductList);
            }
            WebApi.addToShoppingCart(this.data.product.ProductCode, this.data.buynum).then((res) => {
                wx.showToast({
                    title: '操作成功！',
                    duration: 2000
                });
            });
        }
    }
})
