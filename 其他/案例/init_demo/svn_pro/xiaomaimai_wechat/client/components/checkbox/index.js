/**
 * 标题栏组件
 */
Component({
    /**
     * 组件的属性列表
     */
    externalClasses: ['checkbox-class'],
    properties: {
        bindtap: {
            type: Function,
            value: null,
        },
        checked: {
            type: Boolean,
            value: false,
        },
        title: {
            type: String,
            value: "",
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
        onTapCheckBox: function () {
            const {checked} = this.data;
            console.log(this, "checkbox...")
            this.triggerEvent('change', {
                checked: !checked,
                data: this.data,
            });
        }
    }
})
