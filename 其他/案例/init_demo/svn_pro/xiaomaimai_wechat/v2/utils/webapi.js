import Config from './config.js'
import Request from './request.js'
const MD5Encode = require("MD5Encode.js");

function getSign({ storeGuid, storeCustomerGuid, guid, price }) {
  return "Currency=CNY&" +
    "MerchantGuid=" + storeGuid + "&" +
    "NotifyUrl=https://payment.xiaomaimaiquan.com/wechat/confirmed&" +
    "OrderPrice=" + price + "&" +
    "OuterTradeNo=" + guid + "&" +
    "PaymentAmount=" + price + "&" +
    "PaymentDescription=xmmq&" +
    "PaymentMethod=WechatNative&" +
    "SignType=md5&" +
    "StoreCustomerKey=" + storeCustomerGuid + "&" +
    "TradeType=JSAPI&" +
    "key=vmD5pSpAHU4wpV7vDyK5";
}

const webapi = {
  //---- payment API root -----
  PlaceUnifyOrder({ storeGuid, storeCustomerGuid, orders }) {
    const postData = [];
    orders.forEach(order => {
      postData.push({
        CommonRequest: {
          MerchantGuid: storeGuid,
          StoreCustomerKey: storeCustomerGuid,
          PaymentMethod: 'WechatNative',
          SignType: 'md5',
          Sign: MD5Encode.hexMD5(getSign({ storeGuid, storeCustomerGuid, guid: order.guid, price: order.price })),
        },
        OuterTradeNo: order.guid,
        OrderPrice: order.price,
        PaymentAmount: order.price,
        PaymentDescription: 'xmmq',
        Currency: 'CNY',
        NotifyUrl: "https://payment.xiaomaimaiquan.com/wechat/confirmed",
        TradeType: 'JSAPI',
        OrderDetails: [],
      })
    })
    return Request.post(`${Config.paymentAPIRoot}/PlaceUnifyOrder2`, postData);
  },
  //---- customer API root -----
  BindInternalVendor(dataModel) {
    return Request.post(`${Config.customerAPIRoot}/BindInternalVendor`, dataModel, {
      title: '绑定中...',
    });
  },
  LoadAllVendors() {
    return Request.post(`${Config.customerAPIRoot}/LoadAllVendors`, '', {
      title: '获取数据',
      icon: 'loading',
      mask: true,
    });
  },
  AddNewStoreApplication(dataModel) {
    return Request.post(`${Config.customerAPIRoot}/AddNewStoreApplication`, dataModel, {
      title: '提交申请中...',
    });
  },
  RegisterAsOwner(OwnerRegister) {
    return Request.post(`${Config.customerAPIRoot}/RegisterAsOwner`, OwnerRegister);
  },
  getMyAccessStores(wechatCode, userInfo, iv, storeGuid) {
    const loginModel = { WechatCode: wechatCode, UserInfo: userInfo, Iv: iv, StoreGuid: storeGuid };
    return Request.post(`${Config.customerAPIRoot}/GetMyAccessStores`, loginModel, { title: '获取店铺信息...' });
  },
  userLogin(wechatCode, userInfo, iv, refCode, storeGuid) {
    const loginModel = { WechatCode: wechatCode, UserInfo: userInfo, Iv: iv, RefCode: refCode, StoreGuid: storeGuid };
    return Request.post(`${Config.customerAPIRoot}/WechatLogin`, loginModel);
  },
  loadUserBind(targetStoreGuid) {
    return Request.postRaw(`${Config.customerAPIRoot}/LoadUserBind`, targetStoreGuid);
  },
  retrieveStoreInfo() {
    return Request.post(`${Config.customerAPIRoot}/RetrieveStoreInfo`, false, { title: '加载店铺信息' });
  },
  UpdateStoreApplicationWechatInfo(dataModel) {
    return Request.post(`${Config.customerAPIRoot}/UpdateStoreApplicationWechatInfo`, dataModel, {
      title: '更新店铺信息',
    });
  },
  setDefaultAddress(addressGuid) {
    return Request.postRaw(`${Config.customerAPIRoot}/SetDefaultAddress`, addressGuid);
  },
  searchStoreCustomerAddress(addressSearch) {
    return Request.post(`${Config.customerAPIRoot}/SearchStoreCustomerAddress`, addressSearch);
  },
  deleteStoreCustomerAddress(addressGuid) {
    const dataModel = { Guid: addressGuid, StoreCustomerGuid: Request.getGlobalData().apiLoginInfo.StoreCustomerGuid };
    return Request.post(`${Config.customerAPIRoot}/DeleteStoreCustomerAddress`, dataModel);
  },
  addStoreCustomerAddress(address) {
    return Request.post(`${Config.customerAPIRoot}/AddStoreCustomerAddress`, address);
  },
  updateStoreCustomerAddress(address) {
    return Request.post(`${Config.customerAPIRoot}/UpdateStoreCustomerAddress`, address);
  },
  SendMobileVerificationCode(phoneNumber) {
    return Request.postRaw(`${Config.customerAPIRoot}/SendMobileVerificationCode`, phoneNumber, { title: "发送中..." });
  },
  VerificationCodeLogin(phoneNumber, verifyCode) {
    return Request.post(`${Config.customerAPIRoot}/VerificationCodeLogin`, {
      PhoneNumber: phoneNumber,
      VerifyCode: verifyCode,
    }, { title: "正在绑定..." });
  },
  RefreshUserInfo() {
    console.log("刷新用户信息")
    return Request.post(`${Config.customerAPIRoot}/RefreshUserInfo`, {});
  },
  GetMySharePicture(showLoading = true) {
    return Request.post(`${Config.customerAPIRoot}/GetMySharePicture`, {
      TemplateType: 1,
    }, showLoading ? {
      title: '正在加载中...',
      icon: 'loading',
      mask: true,
    } : null);
  },
  GetGZHSharePicture(showLoading = true) {
    return Request.post(`${Config.customerAPIRoot}/GetMySharePicture`, {
      TemplateType: 5,
    }, showLoading ? {
      title: '正在加载中...',
      icon: 'loading',
      mask: true,
    } : null);
  },
  GetDQProductSharePicture(productList) {
    return Request.post(`${Config.customerAPIRoot}/GetDQProductSharePicture`, productList,{
      title: '正在加载中...',
      icon: 'loading',
      mask: true,
    });
  },
  GetDQOrderSharePictureEx(orderList, isDisplayPrice, showLoading = false) {
    return Request.post(`${Config.customerAPIRoot}/GetDQOrderSharePictureEx`,
      { GuidList: orderList, IsDisplayPrice: isDisplayPrice },
      showLoading && {
        title: showLoading === true ? '生成订单内容' : showLoading,
      });
  },
  GetDQMomentSharePicture(momentguid) {
    return Request.postRaw(`${Config.customerAPIRoot}/GetDQMomentSharePicture`, momentguid, {
      title: '正在加载中...',
      icon: 'loading',
      mask: true,
    });
  },
  getValidRedBonus(apiLoginInfo, doSuccess) {
    const dataModel = { KeyGuid: Request.getGlobalData().apiLoginInfo.StoreCustomerGuid, PageIndex: 0, PageSize: 100 };
    return Request.post(`${Config.customerAPIRoot}/GetValidRedBonus`, dataModel);
  },
  GetGZHQRCode() {
    return Request.post(`${Config.customerAPIRoot}/GetGZHQRCode`, {}, {
      title: '获取公众号二维码',
    });
  },
  GetBuyerInfo() {
    return Request.post(`${Config.customerAPIRoot}/GetBuyerInfo`, {});
  },
  UpdateBuyerInfo(model) {
    return Request.post(`${Config.customerAPIRoot}/UpdateBuyerInfo`, model);
  },
  logOnLoad(options) {
    const pages = getCurrentPages();
    if (pages.length > 1) return; // 非启动页面不log

    const page = pages[0];
    const data = {
      path: page.route,
      query: Object.keys(options).map(key => key + '=' + options[key]).join('&'),
    };
    return Request.post(`${Config.customerAPIRoot}/LogOnLoad`, data);
  },
  AcceptAgreement() {
    return Request.post(`${Config.customerAPIRoot}/AcceptAgreement`, 1);
  },
  RemoveComment(model) {
    return Request.post(`${Config.customerAPIRoot}/DisableComment`, model);
  },
  SetDisableComment(value) {
    return Request.post(`${Config.customerAPIRoot}/DisableComment`, value);
  },
  //---- order API root -----
  ExportDQOrders(dataModel) {
    return Request.post(`${Config.orderAPIRoot}/ExportDQOrders`, dataModel);
  },
  GetBasicShippingFee(shippingPrice) {
    return Request.post(`${Config.orderAPIRoot}/GetBasicShippingFee`);
  },
  SetBasicShippingFee(shippingPrice) {
    return Request.post(`${Config.orderAPIRoot}/SetBasicShippingFee`, shippingPrice);
  },
  BatchUpdateOrderStatus(batchOrderStatus) {
    return Request.post(`${Config.orderAPIRoot}/BatchUpdateOrderStatus`, batchOrderStatus, {
      title: '正在更新',
      icon: 'loading',
      mask: true,
    });
  },
  UpCopyOrder(model) {
    return Request.post(`${Config.orderAPIRoot}/UpCopyOrder`, model, {
      title: '正在更新',
      icon: 'loading',
      mask: true,
    });
  },
  BatchPayOrders(orderList) {
    return Request.post(`${Config.orderAPIRoot}/BatchPayOrders`, orderList);
  },
  updateOrderImage(dataModel) {
    return Request.post(`${Config.orderAPIRoot}/UpdateOrderImage`, dataModel);
  },
  updateOrderStatus(orderStatus) {
    return Request.post(`${Config.orderAPIRoot}/UpdateOrderStatus`, orderStatus);
  },
  loadOrderCountSummary() {
    return Request.post(`${Config.orderAPIRoot}/LoadOrderCountSummary`, null, null, true);
  },
  deleteOrder(orderGuid) {
    const dataModel = { Guid: orderGuid, StoreCustomerGuid: Request.getGlobalData().apiLoginInfo.StoreCustomerGuid };
    return Request.post(`${Config.orderAPIRoot}/DeleteOrder`, dataModel);
  },
  searchOrder(orderSearch) {
    return Request.post(`${Config.orderAPIRoot}/SearchOrder`, orderSearch, {
      title: '获取订单详情',
    });
  },
  placeOrder(order) {
    return Request.post(`${Config.orderAPIRoot}/PlaceDQOrder2`, order, {
      title: '生成订单',
      icon: 'loading',
      mask: true,
    });
  },
  updateOrder(order) {
    return Request.post(`${Config.orderAPIRoot}/UpdateOrder`, order);
  },
  calculateOrderPrice(shoppingCartProducts) {
    return Request.post(`${Config.orderAPIRoot}/CalculateDQOrderPrice`, shoppingCartProducts, {
      title: '计算订单价格',
      icon: 'loading',
      mask: true,
    });
  },
  //---- product API root -----
  PublishVendorProduct(dataModel) {
    return Request.post(`${Config.productAPIRoot}/PublishVendorProduct`, dataModel, {
      title: '正在发布',
      icon: 'loading',
      mask: true,
    });
  },
  GetVendorProduct4Publish(vendorProductGuid) {
    return Request.postRaw(`${Config.productAPIRoot}/GetVendorProduct4Publish`, vendorProductGuid);
  },
  SearchVendorProduct(dataModel) {
    return Request.post(`${Config.productAPIRoot}/SearchVendorProduct`, dataModel, {
      title: '获取数据',
      icon: 'loading',
      mask: true,
    });
  },
  GetVendorCategoryList() {
    return Request.post(`${Config.productAPIRoot}/GetVendorCategoryList`, '', {
      title: '获取数据',
      icon: 'loading',
      mask: true,
    });
  },
  AdvertisementClicked(dataModel) {
    return Request.post(`${Config.productAPIRoot}/AdvertisementClicked`, dataModel, {
      title: '正在跳转...',
    });
  },
  SearchAdvertisement(dataModel) {
    return Request.post(`${Config.productAPIRoot}/SearchAdvertisement`, dataModel);
  },
  RemoveAdvertisement(dataModel) {
    return Request.post(`${Config.productAPIRoot}/RemoveAdvertisement`, dataModel);
  },
  UpdateAdvertisement(dataModel) {
    return Request.post(`${Config.productAPIRoot}/UpdateAdvertisement`, dataModel);
  },
  PublishAdvertisement(dataModel) {
    return Request.post(`${Config.productAPIRoot}/PublishAdvertisement`, dataModel, {
      title: '正在发布...',
    });
  },
  addNewMoment(model) {
    return Request.post(`${Config.productAPIRoot}/AddNewMoment`, model, {
      title: '正在发布',
      icon: 'loading',
      mask: true,
    });
  },
  addNewProducts(model) {
    return Request.post(`${Config.productAPIRoot}/AddNewProducts`, model, {
      icon: 'loading',
      mask: true,
    });
  },
  promoteProducts(model) {
    return Request.post(`${Config.productAPIRoot}/PromoteProducts`, model, {
      title: '正在发布',
      icon: 'loading',
      mask: true,
    });
  },
  RemoveDQProductPicture(dataModel) {
    return Request.post(`${Config.productAPIRoot}/RemoveDQProductPicture`, dataModel);
  },
  repostMoment(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/RepostMoment`, requestModel)
  },
  removeMoment(productGroup) {
    return Request.post(`${Config.productAPIRoot}/RemoveMoment`, productGroup)
  },
  removeDQProduct(productList) {
    return Request.post(`${Config.productAPIRoot}/RemoveDQProduct`, productList)
  },
  searchDQProduct(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/SearchDQProduct`, requestModel)
  },
  searchPromotedDQProduct(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/SearchPromotedDQProduct`, requestModel)
  },
  searchDQProductGroup(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/SearchDQProductGroup`, requestModel)
  },
  loadChinaCityCode() {
    return Request.post(`${Config.contentAPIRoot}/LoadChinaCityCode`);
  },
  loadMomentTopics() {
    return Request.post(`${Config.productAPIRoot}/LoadAllMomentTopics`);
  },
  loadProductTags() {
    return Request.post(`${Config.productAPIRoot}/LoadAllProductTags`);
  },
  loadWishList(dataModel) {
    return Request.post(`${Config.productAPIRoot}/LoadDQWishList`, dataModel);
  },
  removeProductFromWishList(productCode) {
    const dataModel = [productCode];
    return Request.post(`${Config.productAPIRoot}/RemoveProductFromWishList`, dataModel);
  },
  addToWishList(productCode) {
    return Request.postRaw(`${Config.productAPIRoot}/AddProductToWishList`, productCode);
  },
  loadShoppingCart() {
    return Request.postRaw(`${Config.productAPIRoot}/LoadDQShoppingCart`);
  },
  UpdateCustomerPhoneNumber(phoneNumber) {
    return UpdateStoreCustomerAttribute({
      AttributeName: StoreCustomerAttributeName.BindMobile,
      AttributeValue: phoneNumber,
      ActionType: UpdateAction.Overwrite,
    });
  },
  addToShoppingCart(productCode, quantity) {
    const dataModel = { ProductCode: productCode, Quantity: quantity };
    return Request.post(`${Config.productAPIRoot}/AddToShoppingCart`, dataModel);
  },
  updateShoppingCart(productCode, quantity) {
    const dataModel = [{ ProductCode: productCode, Quantity: quantity }];
    return Request.post(`${Config.productAPIRoot}/UpdateShoppingCart`, dataModel);
  },
  mergeDQProducts(productGuidList) {
    return Request.post(`${Config.productAPIRoot}/MergeDQProducts`, productGuidList);
  },
  addNewDQProduct(productList) {
    return Request.post(`${Config.productAPIRoot}/AddNewDQProduct`, productList);
  },
  updateDQProduct(model) {
    return Request.post(`${Config.productAPIRoot}/UpdateDQProduct`, model, {
      title: '正在保存',
      icon: 'loading',
      mask: true,
    });
  },
  SetMomentAtTop(model) {
    return Request.post(`${Config.productAPIRoot}/SetMomentAtTop`, model);
  },
  AddNewLike(model) {
    return Request.post(`${Config.productAPIRoot}/AddNewLike`, model);
  },
  RemoveLike(model) {
    return Request.post(`${Config.productAPIRoot}/RemoveLike`, model);
  },
  AddNewComment(model) {
    return Request.post(`${Config.productAPIRoot}/AddNewComment`, model);
  },
  SetCommentAtTop(model) {
    return Request.post(`${Config.productAPIRoot}/SetCommentAtTop`, model);
  },
  MyUnreadCommentCount(model) {
    return Request.post(`${Config.productAPIRoot}/MyUnreadCommentCount`, model);
  },
  MyRecentComment(model) {
    return Request.post(`${Config.productAPIRoot}/MyRecentComment`, model);
  },
  StoreUnreadCommentCount() {
    return Request.post(`${Config.productAPIRoot}/StoreUnreadCommentCount`, model);
  },
  StoreRecentComment(model) {
    return Request.post(`${Config.productAPIRoot}/StoreRecentComment`, model);
  },
};

export default webapi;

module.exports = webapi;
