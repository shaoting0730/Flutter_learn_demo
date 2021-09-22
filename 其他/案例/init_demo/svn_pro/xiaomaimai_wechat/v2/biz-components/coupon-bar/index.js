/**
 * 选择优惠券 组件
 */
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        show: {
            type: Boolean,
            value: true,
        },
        validcoupons: {
            type: Array,
            value: [],
        },
    },

    /**
     * 组件的初始数据
     */
    data: {
        discountPrice: 0,
        couponguid: '',
    },

    /**
     * 组件的方法列表
     */
    methods: {
        getvou: function (e) {
            const couponguid = e.currentTarget.dataset.id;
            const price = e.currentTarget.dataset.price;
            this.setData({
                discountPrice: parseFloat(price),
                couponguid: couponguid
            });

        },
    }
})
