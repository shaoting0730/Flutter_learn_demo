// pages/orderexport.js
var webapi = require('../../utils/webapi');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    selectedStatus: '',
    selectedDateType: '',
    starttime: '',
    endtime: '',
    exportordertime: '', 
    exportorderstatus:'',
    progress:{percent:0},
    exportfileurl:'',
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    if (options.selectedStatus)
      this.setData({ selectedStatus: options.selectedStatus});
    if (options.selectedDateType)
      this.setData({ selectedDateType: options.selectedDateType });
    if (options.starttime)
      this.setData({ starttime: options.starttime });
    if (options.endtime)
      this.setData({ endtime: options.endtime });
    if (this.data.selectedStatus =="waitaction")
      this.setData({ exportorderstatus: '等候付款'});
    else if (this.data.selectedStatus == "readyforship")
      this.setData({ exportorderstatus: '已支付' });
    else
      this.setData({ exportorderstatus: '全部' });
    if (this.data.selectedDateType!='')
    {
      if (this.data.selectedDateType == "today")
        this.setData({ exportordertime: '当天' });
      else if (this.data.selectedDateType == "thismonth")
        this.setData({ exportordertime: '当月' });
      else if (this.data.selectedDateType == "halfyear")
        this.setData({ exportordertime: '半年' });
      else if (this.data.selectedDateType == "oneyear")
        this.setData({ exportordertime: '一年内' });
        
    }
    else
    {
      var starttime = this.data.starttime;
      var endtime = this.data.endtime;
      this.setData({ exportordertime:starttime+' - '+ endtime});
    }
    this.doExport();
  },
  doExport:function(){
    var self = this;
    var exportdone = false;
    webapi.ExportDQOrders({ ExportOrderStatus: this.data.selectedStatus, ExportOrderDateType: this.data.selectedDateType, ExportOrderStartDate: this.data.starttime, ExportOrderEndDate:this.data.endtime}).then((res)=>{
        if(res.Success)
        {
          self.setData({ exportfileurl: res.Data});
        }
        else
        {
          self.setData({ exportfileurl: '' });
          wx.showModal({
            title: '提示',
            content: res.Message,
          })
        }
        exportdone = true;
    });
    var id = setInterval(function () {
      //定时执行的代码
      if (!exportdone)
      {
        var newprecent = self.data.progress.percent + 10;
        if(newprecent>=100)
          newprecent = 99;
        self.setData({ progress: { percent: newprecent}});
      }
      else{
        if (self.data.exportfileurl=='')
          self.setData({ progress: { percent: 100 } });
        else
          self.setData({ progress: { percent: 100 } });
        clearInterval(id);//关闭定时器
      }
    }, 1000);
    
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },
  btnCopyLink: function(){
    var self = this;
    wx.setClipboardData({
      data: self.data.exportfileurl,
      success: function (res) {
      }
    });
  },
  btnDownload:function(){
    wx.showLoading({
      title: '正在下载。。。',
    })
    wx.downloadFile({
      url: this.data.exportfileurl,
      success: function (res) {
        wx.hideLoading();
        wx.showToast({
          title: '下载完成',
        });
        console.log(res.tempFilePath);
        wx.openDocument({
          filePath: res.tempFilePath,
          fileType: 'xlsx',
        })
      },
      fail: function (res) {
        wx.hideLoading();
        wx.showModal({
          title: '提示',
          content: JSON.stringify(res),
        })
        reject(res);
      }
    })
  },
})