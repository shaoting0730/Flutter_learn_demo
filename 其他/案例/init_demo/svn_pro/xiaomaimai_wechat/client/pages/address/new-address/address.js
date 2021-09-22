//城市选择
var app = getApp();
var webapi = require('../../../utils/webapi');
Page({
    data: {
        provinceList: ['请选择省份'],//省级数组
        cityList: ['请选择城市'],//城市数组
        townList: ['请选择区县'],//区数组
        provinceIndex: 0,
        cityIndex: 0,
        townIndex: 0,
        address: {Guid: ''},
    },
    formSubmit: function (e) {
        var adds = e.detail.value;
        this.data.address.FullName = adds.name;
        this.data.address.AddressLine = adds.address;
        this.data.address.Town = adds.town;
        this.data.address.city = adds.city;
        this.data.address.province = adds.province;
        this.data.address.PhoneNumber = adds.phone;
        this.data.address.IDCardType = 1;
        this.data.address.IDCardNumber = adds.idcardnumber;
        this.data.address.AddressType = 4;
        this.data.address.StoreCustomerGuid = app.globalData.apiLoginInfo.StoreCustomerGuid;
        if (this.data.address.Guid == '')
            webapi.addStoreCustomerAddress(this.data.address).then((res) => {
                if (res.Success) {
                    wx.navigateBack({
                      delta: 1
                    });
                }
            });
        else
            webapi.updateStoreCustomerAddress(this.data.address).then((res) => {
                if (res.Success) {
                  wx.navigateBack({
                    delta: 1
                  }); 
                }
            });
    },
    refreshProvince: function (selectedValue) {
        var province = ['请选择省份'];
        for (var index in app.globalData.chinaCityCode) {
            province.push(index);
        }
        var selectedIndex = province.indexOf(selectedValue);
        if (selectedIndex < 0)
            selectedIndex = 0;
        this.setData({
            provinceList: province,
            provinceIndex: selectedIndex,
        });
        if (selectedIndex > 0) {
            var city = '';
            if (this.data.address)
                city = this.data.address.City;
            this.refreshCity(city);
        }
    },
    refreshCity: function (selectedValue) {
        var city = ['请选择城市'];
        for (var index in app.globalData.chinaCityCode[this.data.provinceList[this.data.provinceIndex]]) {
            city.push(index);
        }
        var selectedIndex = city.indexOf(selectedValue);
        if (selectedIndex < 0)
            selectedIndex = 0;
        this.setData({
            cityList: city,
            cityIndex: selectedIndex,
            townList: ['请选择区县'],
        });
        if (selectedIndex > 0) {
            var town = '';
            if (this.data.address)
                town = this.data.address.Town;
            this.refreshTown(town);
        }
    },
    refreshTown: function (selectedValue) {
        var town = ['请选择区县'];
        for (var index in app.globalData.chinaCityCode[this.data.provinceList[this.data.provinceIndex]][this.data.cityList[this.data.cityIndex]]) {
            if (town.indexOf(app.globalData.chinaCityCode[this.data.provinceList[this.data.provinceIndex]][this.data.cityList[this.data.cityIndex]][index].Town) <= 0)
                town.push(app.globalData.chinaCityCode[this.data.provinceList[this.data.provinceIndex]][this.data.cityList[this.data.cityIndex]][index].Town);
        }
        var selectedIndex = town.indexOf(selectedValue);
        if (selectedIndex < 0)
            selectedIndex = 0;
        this.setData({
            townList: town,
            townIndex: selectedIndex,
        });
    },
    onLoad: function (options) {
        if (options.address){
            console.log("---->onLoad--->options.address-->",options.address);
            this.setData({
                address: JSON.parse(options.address),
            },()=>{
                var province = '';
                if (this.data.address){
                    province = this.data.address.Province;
                }
                this.refreshProvince(province);
            });
        }
        else
          this.refreshProvince('');
    },
    bindPickerChangeProvince: function (e) {
        this.setData({
            provinceIndex: e.detail.value,
        });
        var city = '';
        if (this.data.address)
            city = this.data.address.City;
        this.refreshCity(city);
    },
    bindPickerChangeCity: function (e) {
        this.setData({
            cityIndex: e.detail.value,
        });
        var town = '';
        if (this.data.address)
            town = this.data.address.Town;
        this.refreshTown(town);
    },
    bindPickerChangeTown: function (e) {
        this.setData({
            townIndex: e.detail.value,
        });
    }
})
