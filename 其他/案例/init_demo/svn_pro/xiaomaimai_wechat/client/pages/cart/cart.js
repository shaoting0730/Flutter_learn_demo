import WebApi from "../../utils/webapi";

var app = getApp();
var webapi = require('../../utils/webapi');
import Util from './../../utils/util';
Page({
    data: {
        page: 1,
        total: 0,
        carts: [],
        showLoading: false,
        productMin:0,
        productMax:99,
        showChooseShipmentWay:false,
        totalQuantity: 0
    },
    bindJumpDetail:function(event){
        /*console.log("bindJumpDetail--->",e);
        const productCode = e.currentTarget.dataset.productcode;
        wx.navigateTo({url: `../product/detail?ProductCode=${productCode}`});*/
        const productCode = event.currentTarget.dataset.productcode;
        wx.navigateTo({
            url: '/pages/showdetails/index?pid=' + productCode
        })
    },
    onRemoveCart: function (event) {
      const carts = this.data.carts;
      let selectedProduct = [];
      carts.forEach(p => {
        if (p.selected)
          selectedProduct.push(p.ProductCode);
      });
      if(selectedProduct.length<=0)
        wx.showToast({
          title: '请先勾选要删除的商品',
        });
      else
      {
        wx.showModal({
          title: '提示',
          content: '确定从购物车删除选中的商品吗？',
          success(res) {
            if (res.confirm) {
              selectedProduct.forEach(p => {
                webapi.updateShoppingCart(app.globalData.userInfo, p, 0);
              });
              this.onLoad();
            } else if (res.cancel) {
              console.log('用户点击取消')
            }
          }
        });
      }
    },
    bindScanProductQRCode:function(){
        Util.scanProductQRCode();
    },
    bindStepperChange:function(e){
        const productCode = e.currentTarget.dataset.productcode;
        const num=e.detail;
        if(num==0){
            wx.showModal({
                title: '提示',
                content: '你确认移除吗',
                success: (res)=>{
                    if(res.confirm){
                        webapi.updateShoppingCart(app.globalData.apiLoginInfo, productCode, num).then(() => {
                            this.onLoad();
                        });
                    }
                },
                fail: function () {
                    wx.showToast({
                        title: '网络异常！',
                        duration: 2000
                    });
                }
            });
        }else{
            webapi.updateShoppingCart(app.globalData.apiLoginInfo, productCode, num).then(() => {
                this.loadProductData();
            });
        }
    },
    bindItemCheckbox: function (e) {
        console.log("----->bindItemCheckbox", e);
        const checked = e.detail.checked;
        const index = e.currentTarget.dataset.index;
        console.log("bindItemCheckbox", checked, index);

        this.setCartChecked(index,checked);

        this.updateAllCartsChecked();
        this.calcSumPrice();
    },
    setCartChecked(index,isChecked){
        var carts = this.data.carts;
        carts[index].selected = isChecked;
        this.setData({
            carts: carts
        });
    },
    setAllCartsChecked(isAllChecked){
        let carts = this.data.carts;
        console.log(carts, "====>carts")
        //遍历
        for (var i = 0; i < carts.length; i++) {
            carts[i].selected = isAllChecked;
        }
        this.setData({
            carts: carts
        });
    },
    updateAllCartsChecked:function(){
        let selectedAllStatus = true;

        let carts = this.data.carts;
        //遍历
        for (var i = 0; i < carts.length; i++) {
            if(!carts[i].selected){
                selectedAllStatus = false;
                break;
            }
        }
        this.setData({
            selectedAllStatus: selectedAllStatus,
        });
    },
    bindToggleSelectAll: function (e) {
        var selectedAllStatus = e.detail.checked;
        this.setAllCartsChecked(selectedAllStatus);
        this.updateAllCartsChecked();
        this.calcSumPrice();
    },
    bindSelectAll: function () {
        // 环境中目前已选状态
        var selectedAllStatus = this.data.selectedAllStatus;
        // 取反操作
        selectedAllStatus = !selectedAllStatus;
        // 购物车数据，关键是处理selected值
        var carts = this.data.carts;
        // 遍历
        for (var i = 0; i < carts.length; i++) {
            carts[i].selected = selectedAllStatus;
        }
        this.setData({
            selectedAllStatus: selectedAllStatus,
            carts: carts
        });
        this.calcSumPrice();
    },

    bindCheckout: function () {
        // 初始化toastStr字符串
        var toastStr = [];
        // 遍历取出已勾选的cid
        for (var i = 0; i < this.data.carts.length; i++) {
            if (this.data.carts[i].selected) {
                toastStr.push(this.data.carts[i].ProductCode);
                ///toastStr += ',';
            }
        }
        if (toastStr.length == 0) {
            wx.showToast({
                title: '请选择要结算的商品！',
                duration: 2000
            });
            return false;
        }

        //存回data
        wx.navigateTo({
            url: '../order/pay?productData=' + JSON.stringify(toastStr),
        });
    },

    bindToastChange: function () {
        this.setData({
            toastHidden: true
        });
    },

    calcSumPrice: function () {
        var carts = this.data.carts;
        // 计算总金额
        var total = 0;
        let totalQuantity = 0;
        carts.forEach(item => {
            if(item.selected) {
                total += parseInt(item.Quantity) * parseFloat(item.ProductOnSalePrice)
                totalQuantity += item.Quantity;
            }
        })

        // 写回经点击修改后的数组
        this.setData({
            carts: carts,
            total: total,
            totalQuantity: totalQuantity
        });
    },

    onLoad: function (options) {
        this.loadProductData(true);
    },

    onShow: function () {
        // this.loadProductData();
    },
    getSelectedProducts(){
        // 初始化toastStr字符串
        var selectedProducts = [];
        // 遍历取出已勾选的cid
        for (var i = 0; i < this.data.carts.length; i++) {
            if (this.data.carts[i].selected) {
                selectedProducts.push(this.data.carts[i].ProductCode);
            }
        }
        return selectedProducts;
    },
    toggleChooseShipmentWay:function(){
        /*const {showChooseShipmentWay} = this.data.showChooseShipmentWay;
        const selectedProducts = this.getSelectedProducts();

        const maskChooseShipmentWay = this.selectComponent("#maskChooseShipmentWay");

        if(selectedProducts.length>0){
            console.log(maskChooseShipmentWay,"----->maskChooseShipmentWay");
            if(maskChooseShipmentWay){
                maskChooseShipmentWay.showDialog(selectedProducts);
            }
        }else{
            wx.showToast({
                title: '请选择要结算的商品！',
                icon:'none',
                duration: 2000
            });
        }*/

        const selectedProducts = this.getSelectedProducts();
        wx.navigateTo({
          url: '/pages/order/pay?productData=' + JSON.stringify(selectedProducts)
        });
    },
    /*addShopCart: function (e) { //添加到购物车
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
    },*/
    removeShopCard: function (e) {
        var that = this;
        wx.showModal({
            title: '提示',
            content: '你确认移除吗',
            success: function (res) {
                res.confirm && webapi.UpdateShoppingCart(app.globalData.apiLoginInfo, e.currentTarget.dataset.productcode, 0, function () {
                    //更新数据
                    that.loadProductData();
                });
            },
            fail: function () {
                // fail
                wx.showToast({
                    title: '网络异常！',
                    duration: 2000
                });
            }
        });
    },
    setShowLoading: function (isShow) {
        this.setData({
            showLoading: isShow,
        });
    },
    //数据案例
    loadProductData: function (isShowLoading) {
        if (isShowLoading) {
            this.setShowLoading(true);
        }
        webapi.loadShoppingCart().then(res => {
            console.log(res, "---->loadProductData");
            //更新数据
            var productList = res.Data;
            this.setData({
                carts: productList,
                showLoading: false,
            });
            this.calcSumPrice();
            this.updateAllCartsChecked();
        }).catch(() => {
            this.setShowLoading(false);
        });
    },
});
