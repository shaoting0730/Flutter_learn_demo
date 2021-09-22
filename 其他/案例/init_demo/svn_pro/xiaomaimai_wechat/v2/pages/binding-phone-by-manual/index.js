import Request from "../../utils/request";
import Util from './../../utils/util';

/**
 * PageXXXX XXXX 页
 * Author:Colin3dmax
 * Date:2018/7/30
 */
var app = getApp();
var webapi = require('../../utils/webapi');

const WAIT_SEC = 60;
Page({
    data: {
        phoneNumber: '',
        validCode: '',
        waitSec: 0,
    },
    onShow: function () {
    },

    onLoad: function (options) {

    },
    stopWaitTimer() {
        if (this.waitTimer != null) {
            clearInterval(this.waitTimer);
            this.waitTimer = null;
        }
    },
    startWaitTimer() {
        this.stopWaitTimer();
        this.waitTimer = setInterval(() => {
            let currSec = this.data.waitSec;
            if (currSec > 0) {
                currSec--;
                this.setData({
                    waitSec: currSec,
                });
            } else {
                this.setData({
                    waitSec: 0,
                });
                this.stopWaitTimer();
            }
        }, 1000);
    },
    startWaitSec(second) {
        this.setData({
            waitSec: second,
        });
        this.startWaitTimer();
    },
    bindInputPhoneNumber: function (e) {
        console.log("bindInputPhoneNumber", e);
        const phoneNumber = e.detail.value;
        this.setData({
            phoneNumber: phoneNumber,
        });
    },
    bindInputValidCode: function (e) {
        console.log("bindInputPhoneNumber", e);
        const validCode = e.detail.value;
        this.setData({
            validCode: validCode,
        });
    },
    bindSendValidDisabledButton: function (e) {
        wx.showToast({
            title: "验证码已发送，请等待短信通知",
            icon: 'none',
            duration: 2000,
        });
    },
    bindSendValidButton: function (e) {
        const {phoneNumber} = this.data;
        if (phoneNumber == "") {
            Util.showToast("手机号不能为空");
            return;
        }
        //调用发送验证码API
        webapi.SendMobileVerificationCode(phoneNumber).then(json => {
            Util.showToast("验证码已发送");
            this.startWaitSec(WAIT_SEC);
        });
    },
    jumpToHomePage: function () {
        //跳转到首页
        wx.navigateBack({
            delta: 2
        });
        wx.reLaunch({
            url: '/pages/home/index'
        })
    },
    bindPhoneNumber: function () {
        const {phoneNumber, validCode} = this.data;

        if (phoneNumber == "") {
            Util.showToast("手机号不能为空");
            return;
        }
        if (validCode == "") {
            Util.showToast("验证码不能为空");
            return;
        }
        //调用发送绑定手机号 API
        webapi.VerificationCodeLogin(phoneNumber, validCode).then(json => {
            if (json.Success) {
                Util.showToast("绑定成功");
                webapi.RefreshUserInfo().then((res) => {
                    console.log(res, "--->RefreshUserInfo");
                    if (res.Success) {
                        Request.setApiLoginInfo(res.Data);
                    }
                });
                this.jumpToHomePage();
            } else {
                if (json.ErrorCode == 3019) {
                    Util.showToast("验证码无效，无法绑定")
                } else {
                    Util.showToast("绑定失败")
                }

            }

        });
    },
    // onShareAppMessage: Util.shareApp,
});
