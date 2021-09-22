var app = getApp();
var MD5Encode = require("MD5Encode.js");

/**
 * 对字符串判空
 */
function isStringEmpty(data) {
    if (null == data || "" == data) {
        return true;
    }
    return false;
}

/**
 * 封装网络请求
 */
function sentHttpRequestToServer(uri, data, method, successCallback, failCallback, completeCallback) {
    wx.request({
        url: app.d.hostUrl + uri,
        data: data,
        method: method,
        header: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        success: successCallback,
        fail: failCallback,
        complete: completeCallback
    })
}

/**
 * 将map对象转换为json字符串
 */
function mapToJson(map) {
    if (null == map) {
        return null;
    }
    var jsonString = "{";
    for (var key in map) {
        jsonString = jsonString + key + ":" + map[key] + ",";
    }
    if ("," == jsonString.charAt(jsonString.length - 1)) {
        jsonString = jsonString.substring(0, jsonString.length - 1);
    }
    jsonString += "}";
    return jsonString;
}

/**
 * 弹窗提示成功
 */
function toastSuccess() {
    wx.showToast({
        title: '成功',
        icon: 'success',
        duration: 2000
    })
}

/**
 * 调用微信支付
 */
function doWechatPay(appId, appKey, prepayId, successCallback, failCallback, completeCallback) {


    var key = "910C0320F62F464DA243FFFEF3E89C60";
    var nonceString = getRandomString();
    var currentTimeStamp = getCurrentTimeStamp();
    var packageName = "prepay_id=" + prepayId;
    var dataMap = {
        timeStamp: currentTimeStamp,
        nonceStr: nonceString,
        package: packageName,
        signType: "MD5",
        paySign: getWechatPaySign(appId, key, nonceString, packageName, currentTimeStamp),
        success: successCallback,
        fail: failCallback,
        complete: completeCallback
    }
    console.log(dataMap,"---->doWechatPay");
    wx.requestPayment(dataMap);
}

/**
 * 获取微信支付签名字符串
 */
function getWechatPaySign(appId, appKey, nonceStr, packageName, timeStamp) {
    var beforMD5 = "appId=" + appId + "&nonceStr=" + nonceStr + "&package=" + packageName + "&signType=MD5" + "&timeStamp=" + timeStamp + "&key=" + appKey;


    // beforMD5 = "appId=wxd678efh567hg6787&nonceStr=5K8264ILTKCH16CQ2502SI8ZNMTM67VS&package=prepay_id=wx2017033010242291fcfe0db70013231072&signType=MD5&timeStamp=1490840662&key=qazwsxedcrfvtgbyhnujmikolp111111";
    console.log("beforMD5--->", beforMD5);
    const paySign = doMD5Encode(beforMD5).toUpperCase();
    console.log("afterMD5--->", paySign);
    return paySign;
}

/**
 * 获取当前时间戳
 */
function getCurrentTimeStamp() {
    var timestamp = parseInt(Date.parse(new Date())/1000);
    return timestamp + "";
}

/**
 * 获取随机字符串，32位以下
 */
function getRandomString() {
    return Math.random().toString(36).substring(3, 8);
}

/**
 * MD5加密
 */
function doMD5Encode(toEncode) {
    return MD5Encode.hexMD5(toEncode);
}

module.exports = {
    isStringEmpty: isStringEmpty,
    sentHttpRequestToServer: sentHttpRequestToServer,
    mapToJson: mapToJson,
    toastSuccess: toastSuccess,
    doWechatPay: doWechatPay
}
