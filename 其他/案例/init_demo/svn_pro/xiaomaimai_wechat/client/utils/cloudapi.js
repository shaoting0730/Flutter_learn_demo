import Config from './config.js'
import Request from './request.js'

function webapiUploadFiles(fullPath){
  var arr = fullPath.split('/');
  var fileName = arr[arr.length - 1];
  return wx.uploadFile({
    url: `${Config.contentAPIRoot}/Content/UploadImageFiles`, 
    filePath: fullPath,
    name: fileName,
    formData: {
      'user': 'test'
    },
    header:{
      'wbhost': Config.StoreName,
      'StoreGuid': Config.StoreGuid,
      'token': Request.getToken()
    },
    success(res) {
      const data = res.data
      console.log(res,"webapiUploadFiles Success--->");
    },
    fail(err){
      console.log(err, "webapiUploadFiles Fail--->");
    }
  });
}

function wxCloudUploadFiles(localFiles) {
    for (var i = 0; i < localFiles.length; i++) {
        var fullPath = localFiles[i];
        var arr = fullPath.split('/');
        var fileName = arr[arr.length - 1];
        const uploadTask = wx.cloud.uploadFile({
            // 指定上传到的云路径
            cloudPath: fileName,
            // 指定要上传的文件的小程序临时文件路径
            filePath: fullPath,
            // 成功回调
            success: res => {
                console.log('上传成功', res)
            },
        });
        return uploadTask;
    }
}

const CloudApi = {
  webapiUploadFiles,
};

export default CloudApi;

module.exports = CloudApi;