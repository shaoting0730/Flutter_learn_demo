/**
 * ComponentName XXX-组件
 * Author:Colin3dmax
 * Date:2018/7/16
 */

import Util from './../../utils/util';
Component({
    /**
     * 组件的属性列表
     */
    externalClasses: ['root-class'],
    properties: {
        needAuthor:{
            type: Boolean,
            value: true,
        },
        canIUse:{
            type: Boolean,
            value: true,
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
        bindGetUserInfo:function(event){
            console.log("bindGetUserInfo",event.detail);
            if(event.detail.errMsg=="getUserInfo:ok"){
                Util.setLocalStorage("userInfo",event.detail);
            }
            this.triggerEvent('bindGetUserInfo',event.detail);

        }
    }
});
