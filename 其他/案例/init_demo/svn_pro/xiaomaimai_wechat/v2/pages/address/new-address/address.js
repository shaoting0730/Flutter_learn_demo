import webapi from '../../../utils/webapi'
import areaList from '../../../utils/area'

import util from "../../../utils/util";
const app = getApp();

Page({
  data: {
    address: {
      Guid: '',
      FullName: '',
      Province: '',
      City: '',
      Town: '',
      PostCode: '',
      PhoneNumber: '',
      AddressLine: '',
      IDCardNumber: '',
      IDCardType: 0,
      AddressType: 4,
    },
    isEditCard: false,
    showAreaList: false,
    areaList: areaList,
    isDefaultAddress: false,
    areas: '',
    errors: {}
  },
  onLoad(options) {
    const eventChannel = this.getOpenerEventChannel()
    eventChannel.emit('getAddress', (address) => {
      if (address) {
        this.setData({
          address: address,
          idcard: address.IDCardNumber.replace(/^([\s\S]{4})([\s\S]{11})([\s\S]*)$/g, '$1***********$3'),
          areas: `${address.Province}/${address.City}/${address.Town}`,
          isDefaultAddress: address.AddressType === 2
        });
      }
    });
  },
  formSubmit(e) {
    var adds = e.detail.value;
    const eventChannel = this.getOpenerEventChannel()
    if (this.validate(adds)) {
      const { address, isEditCard } = this.data;
      const postData = {
        ...address,
      }
      if (isEditCard) {
        postData.IDCardNumber = adds.idcard
      }
      address.StoreCustomerGuid = app.globalData.apiLoginInfo.StoreCustomerGuid;
      (postData.Guid === '' ?
        webapi.addStoreCustomerAddress(postData) :
        webapi.updateStoreCustomerAddress(postData))
        .then((res) => {
          if (res.Success) {
            eventChannel.emit('onLoadAddress', postData);
            wx.navigateBack({
              delta: 1
            });
          }
        });
    }
  },
  validate(data) {
    console.log(data);
    const errorData = {};
    const { isEditCard } = this.data;
    const { name, phone, areas, address, idcard } = data;

    if (name.length === 0) {
      errorData.FullName = '请输入收件人姓名';
    }
    if (phone.length === 0) {
      errorData.PhoneNumber = '输入收件人手机号';
    } else if (!/^\d{11}$/ig.test(data.phone)) {
      errorData.PhoneNumber = '输入正确的手机号';
    }
    if (areas.length === 0) {
      errorData.area = '请选择所在地区';
    }
    if (address.length === 0) {
      errorData.AddressLine = '请输入收件人详细地址';
    }

    if (isEditCard && idcard.length > 0 && !util.isCardId(idcard)) {
      errorData.IDCardNumber = '请输入正确的身份证号';
    }
    if (Object.keys(errorData).length === 0) {
      return true;
    } else {
      this.setData({
        errors: errorData
      })
      return false;
    }
  },
  onBlur(e) {
    this.setData({
      address: {
        ...this.data.address,
        [e.target.dataset.name]: e.detail.value
      },
      errors: {
        ...this.data.errors,
        [e.target.dataset.name]: ''
      }
    })
  },
  showPopup(e) {
    this.setData({
      showAreaList: true,
    });
  },
  onCloseAreaList(e) {
    this.setData({
      showAreaList: false,
    });
  },
  onAreaCofrim(e) {
    if (!e.detail.index.includes(0)) {
      const values = e.detail.values;
      this.setData({
        areas: values.map(item => item.name).join('/'),
        address: {
          ...this.data.address,
          Province: values[0].name,
          City: values[1].name,
          Town: values[2].name,
          PostCode: values[2].code
        },
        errors: {
          ...this.data.errors,
          area: ''
        }
      });
      this.onCloseAreaList();
    }
  },
  onChangeDefaultAddress(e) {
    this.setData({
      address: {
        ...this.data.address,
        AddressType: e.detail ? 2 : 4
      },
      isDefaultAddress: e.detail
    })
  },
  onChangeAddressLine(e) {
    this.setData({
      address: {
        ...this.data.address,
        AddressLine: e.detail
      },
    })
  },
  onChangeIDCard({ detail }) {
    this.setData({
      isEditCard: true,
      idcard: detail
    })
  }
})
