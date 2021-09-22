import Config from './config';

function getGlobalData(){
    const app = getApp();
    if (app && app.globalData) {
        return app.globalData;
    }else{
        return null;
    }
}
function getStoreName() {
  const app = getApp();
  let storeName = Config.StoreName;
  if (app && app.globalData && app.globalData.apiLoginInfo && app.globalData.apiLoginInfo.StoreName) {
    storeName = app.globalData.apiLoginInfo.StoreName;
  }
  else if (app && app.globalData && app.globalData.storeName)
  {
    storeName = app.globalData.storeName;
  }
  return storeName;
}
function getStoreGuid()
{
  const app = getApp();
  let storeGuid = Config.StoreGuid;
  if (app && app.globalData && app.globalData.apiLoginInfo && app.globalData.apiLoginInfo.StoreGuid) {
    storeGuid = app.globalData.apiLoginInfo.StoreGuid;
  }
  else if (app && app.globalData && app.globalData.storeGuid) {
    storeGuid = app.globalData.storeGuid;
  }
  return storeGuid;
}
function setApiLoginInfo(data){
    getGlobalData().apiLoginInfo = data;
}

function getApiLoginInfo(){
    return getGlobalData().apiLoginInfo;
}

function getUserInfo(){
    return getGlobalData().userInfo;
}

function getToken() {
    const app = getApp();
    let token = "";
    if (app && app.globalData && app.globalData.apiLoginInfo && app.globalData.apiLoginInfo.LoginToken) {
        token = app.globalData.apiLoginInfo.LoginToken;
    }
    return token;
}

function baseRequest(url, method, header, data) {
    console.log("api---->", {
        url: url,
        method: method,
        header: header,
        data: data,
    })
    return new Promise((resolve, reject) => {
        wx.request({
            url: url,
            method: method,
            header: header,
            data: data,
            success: function (res) {
                //去除wx API 封装
                if (res.statusCode == 200) {
                    // console.log("baseRequest--200->", res);
                    resolve(res.data);
                } else if (res.statusCode == 500) {
                    console.log("baseRequest--500内部错误--->", res);
                    reject(res);
                } else {
                    console.log(`baseRequest--${res.statusCode} -未知错误--->`, res);
                    reject(res);
                }
            },
            fail: function (res) {
                reject(res);
            },
        });
    });
}

function post(url, storeName, storeGuid, loginToken, data) {
  const header = {
    'wbhost': storeName,
    'Platform':'wx',
    'StoreGuid': storeGuid,
    'token': loginToken
  };
  return baseRequest(url, "POST", header, JSON.stringify(data));
}
function post(url, data) {
    const header = {
      'wbhost': getStoreName(),
      'Platform': 'wx',
      'StoreGuid': getStoreGuid(),
      'token': getToken()
    };
    return baseRequest(url, "POST", header, JSON.stringify(data));
}

function postRaw(url, data) {
    const header = {
      'wbhost': getStoreName(),
      'Platform': 'wx',
      'StoreGuid': getStoreGuid(),
      'token': getToken()
    };
    return baseRequest(url, "POST", header, data);
}

function get(url) {
    const header = {
      'wbhost': getStoreName(),
      'Platform': 'wx',
      'StoreGuid': getStoreGuid(),
      'token': getToken()
    };
    const data = "";
    return baseRequest(url, "GET", header, data);
}

const Request = {
    setApiLoginInfo,
    getApiLoginInfo,
    getUserInfo,
    getGlobalData,
    getToken,
    getStoreName,
    getStoreGuid,
    post,
    postRaw,
    get,
};

export default Request;
