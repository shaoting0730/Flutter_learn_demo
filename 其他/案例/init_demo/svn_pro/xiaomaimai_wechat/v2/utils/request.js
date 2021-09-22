import Config from './config';
import Util from './util';

function getGlobalData() {
    const app = getApp();
    if (app && app.globalData) {
        return app.globalData;
    } else {
        return null;
    }
}

function getStoreHost() {
  const globalData = getGlobalData();
  return globalData && globalData.storeInfo && globalData.storeInfo.StoreHost ? globalData.storeInfo.StoreHost : Config.StoreHost;
}

function getStoreGuid() {
    const globalData = getGlobalData();
    return globalData && globalData.storeInfo && globalData.storeInfo.StoreGuid ? globalData.storeInfo.StoreGuid : Config.StoreGuid;
}

function setApiLoginInfo(data) {
    if(data && data.StoreApplication && data.StoreApplication.CreatedOn) {
        data.StoreApplication.CreatedOnFMT = Util.timeStampToDateTime(data.StoreApplication.CreatedOn, 'Y-M-D');
    }
    getGlobalData().apiLoginInfo = data;
}

function getApiLoginInfo() {
    return getGlobalData().apiLoginInfo;
}

function getUserInfo() {
    return getGlobalData().userInfo;
}

function getToken() {
    const globalData = getGlobalData();
    if (globalData && globalData.apiLoginInfo && globalData.apiLoginInfo.LoginToken) {
        return globalData.apiLoginInfo.LoginToken;
    }
    return '';
}

function baseRequest(url, method, header, data, loading, skipError) {
    // console.log("api---->", {
    //     url: url,
    //     method: method,
    //     header: header,
    //     data: data,
    // })
    header['content-type'] = 'application/json';
    header['Program-Version'] = getApp().version;
    if(loading && loading.title) {
        getApp().showLoading(loading);
    }
    return new Promise((resolve, reject) => {
        wx.request({
            url: url,
            method: method,
            header: header,
            data: data,
            success: function (res) {
                if(loading && loading.title) getApp().hideLoading();

                //去除wx API 封装
                if (res.statusCode === 200) {
                    //console.log("baseRequest--200->", res);
                    if(res.data && res.data.Success === false && res.data.ErrorDesc && !skipError) {
                        getApp().showToast({
                            title: res.data.ErrorDesc,
                            icon: 'none',
                            duration: 3000,
                        });
                    }
                    resolve(res.data);
                } else if (res.statusCode === 500) {
                    console.log("baseRequest--500内部错误--->", res);
                    reject(res);
                } else {
                    console.log(`baseRequest--${res.statusCode} -未知错误--->`, res);
                    reject(res);
                }
            },
            fail: function (res) {
                if(loading && loading.title) getApp().hideLoading();
                reject(res);
            },
        });
    });
}

function post(url, storeHost, storeGuid, loginToken, data) {
    const header = {
        'Platform': 'wx',
        'StoreGuid': storeGuid,
        'token': loginToken
    };
    return baseRequest(url, "POST", header, JSON.stringify(data));
}

function post(url, data, loading, skipError) {
    const header = {
        'Platform': 'wx',
        'StoreGuid': getStoreGuid(),
        'token': getToken()
    };
    return baseRequest(url, "POST", header, JSON.stringify(data), loading, skipError);
}

function postRaw(url, data, loading) {
    const header = {
        'Platform': 'wx',
        'StoreGuid': getStoreGuid(),
        'token': getToken()
    };
    return baseRequest(url, "POST", header, data, loading);
}

function get(url, loading) {
    const header = {
        'Platform': 'wx',
        'StoreGuid': getStoreGuid(),
        'token': getToken()
    };
    const data = "";
    return baseRequest(url, "GET", header, data, loading);
}

const Request = {
    setApiLoginInfo,
    getApiLoginInfo,
    getUserInfo,
    getGlobalData,
    getToken,
    getStoreGuid,
    getStoreHost,
    post,
    postRaw,
    get,
};

export default Request;
