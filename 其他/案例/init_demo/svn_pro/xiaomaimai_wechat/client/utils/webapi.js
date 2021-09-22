import Config from './config.js'
import Request from './request.js'

function updateOrderStatus(orderStatus) {
    return Request.post(`${Config.orderAPIRoot}/Order/UpdateOrderStatus`, orderStatus);
}

function loadOrderCountSummary() {
    return Request.post(`${Config.orderAPIRoot}/Order/LoadOrderCountSummary`);
}

function deleteOrder(orderGuid) {
    const dataModel = {Guid: orderGuid, StoreCustomerGuid: Request.getGlobalData().apiLoginInfo.StoreCustomerGuid};
    return Request.post(`${Config.orderAPIRoot}/Order/DeleteOrder`, dataModel);
}

function placeOrder(order) {
    return Request.post(`${Config.orderAPIRoot}/Order/PlaceDQOrder`, order);
}

function searchOrder(orderSearch) {
    return Request.post(`${Config.orderAPIRoot}/Order/SearchOrder`, orderSearch);
}

function updateOrder(order) {
    return Request.post(`${Config.orderAPIRoot}/Order/UpdateOrder`, order);
}

function setDefaultAddress(addressGuid) {
    return Request.postRaw(`${Config.customerAPIRoot}/Customer/SetDefaultAddress`, addressGuid);
}

function searchStoreCustomerAddress(addressSearch) {
    return Request.post(`${Config.customerAPIRoot}/Customer/SearchStoreCustomerAddress`, addressSearch);
}

function deleteStoreCustomerAddress(addressGuid) {
    const dataModel = {Guid: addressGuid, StoreCustomerGuid: Request.getGlobalData().apiLoginInfo.StoreCustomerGuid};
    return Request.post(`${Config.customerAPIRoot}/Customer/DeleteStoreCustomerAddress`, dataModel);
}

function addStoreCustomerAddress(address) {
    return Request.post(`${Config.customerAPIRoot}/Customer/AddStoreCustomerAddress`, address);
}

function updateStoreCustomerAddress(address) {
    return Request.post(`${Config.customerAPIRoot}/Customer/UpdateStoreCustomerAddress`, address);
}


function loadChinaCityCode() {
    return Request.post(`${Config.contentAPIRoot}/Content/LoadChinaCityCode`);
}

function calculateOrderPrice(shoppingCartProducts) {
    return Request.post(`${Config.orderAPIRoot}/Order/CalculateDQOrderPrice`, shoppingCartProducts);
}

function loadWishList() {
    return Request.post(`${Config.productAPIRoot}/Product/LoadDQWishList`);
}

function removeProductFromWishList(productCode) {
    const dataModel = [productCode];
    return Request.post(`${Config.productAPIRoot}/Product/RemoveProductFromWishList`, dataModel);
}

function addToWishList(productCode) {
    return Request.postRaw(`${Config.productAPIRoot}/Product/AddProductToWishList`, productCode);
}


function loadShoppingCart() {
    return Request.postRaw(`${Config.productAPIRoot}/Product/LoadDQShoppingCart`);

}

function addToShoppingCart(productCode, quantity) {
    const dataModel = {ProductCode: productCode, Quantity: quantity};
    return Request.post(`${Config.productAPIRoot}/Product/AddToShoppingCart`, dataModel);
}

function updateShoppingCart(apiLoginInfo, productCode, quantity) {
    const dataModel = [{ProductCode: productCode, Quantity: quantity}];
    return Request.post(`${Config.productAPIRoot}/Product/UpdateShoppingCart`, dataModel);
}

function loadProductTags() {
    return Request.post(`${Config.productAPIRoot}/Product/LoadAllProductTags`);
}

function loadMomentTopics() {
    return Request.post(`${Config.productAPIRoot}/Product/LoadAllMomentTopics`);
}

function addNewMoment(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/Product/AddNewMoment`, requestModel)
}

function repostMoment(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/Product/RepostMoment`, requestModel)
}

function removeMoment(productGroup) {
    return Request.post(`${Config.productAPIRoot}/Product/RemoveMoment`, productGroup)
}

function removeDQProduct(productList) {
    return Request.post(`${Config.productAPIRoot}/Product/RemoveDQProduct`, productList)
}

function searchDQProduct(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/Product/SearchDQProduct`, requestModel)
}

function searchDQProductGroup(model) {
    const requestModel = model
    return Request.post(`${Config.productAPIRoot}/Product/SearchDQProductGroup`, requestModel)
}

//发送手机验证码
function SendMobileVerificationCode(phoneNumber) {
    return Request.postRaw(`${Config.customerAPIRoot}/Customer/SendMobileVerificationCode`, phoneNumber);
}

function getValidRedBonus(apiLoginInfo, doSuccess) {
    const dataModel = {KeyGuid: Request.getGlobalData().apiLoginInfo.StoreCustomerGuid, PageIndex: 0, PageSize: 100};
    return Request.post(`${Config.customerAPIRoot}/Customer/GetValidRedBonus`, dataModel);
}

//绑定手机号，（验证手机号+验证码）
function VerificationCodeLogin(phoneNumber, verifyCode) {
    return Request.post(`${Config.customerAPIRoot}/Customer/VerificationCodeLogin`, {
        PhoneNumber: phoneNumber,
        VerifyCode: verifyCode,
    });
}

//更新用户手机信息
function UpdateCustomerPhoneNumber(phoneNumber) {
    return UpdateStoreCustomerAttribute({
        AttributeName: StoreCustomerAttributeName.BindMobile,
        AttributeValue: phoneNumber,
        ActionType: UpdateAction.Overwrite,
    });
}

function GetMySharePicture() {
    return Request.post(`${Config.customerAPIRoot}/Customer/GetMySharePicture`, {
        TemplateType: 1,
    });
}
function GetDQOrderSharePictureEx(orderList, isDisplayPrice) {
  return Request.post(`${Config.customerAPIRoot}/Customer/GetDQOrderSharePictureEx`, { GuidList: orderList, IsDisplayPrice: isDisplayPrice});
}
function GetDQProductSharePicture(productList) {
  return Request.post(`${Config.customerAPIRoot}/Customer/GetDQProductSharePicture`, productList);
}
function GetDQMomentSharePicture(momentguid) {
  return Request.postRaw(`${Config.customerAPIRoot}/Customer/GetDQMomentSharePicture`, momentguid);
}

function RefreshUserInfo() {
    console.log("刷新用户信息")
    return Request.post(`${Config.customerAPIRoot}/Customer/RefreshUserInfo`, {});
}
function getMyAccessStores(wechatCode, userInfo, iv) {
  const loginModel = { WechatCode: wechatCode, UserInfo: userInfo, Iv: iv };
  return Request.post(`${Config.customerAPIRoot}/Customer/GetMyAccessStores`, loginModel);
}
function RegisterAsOwner(OwnerRegister){
  return Request.post(`${Config.customerAPIRoot}/Customer/RegisterAsOwner`, OwnerRegister);
}
function userLogin(wechatCode, userInfo, iv) {
    const loginModel = {WechatCode: wechatCode, UserInfo: userInfo, Iv: iv};
  return Request.post(`${Config.customerAPIRoot}/Customer/WechatLogin`, loginModel);
}

function retrieveStoreInfo() {
    return Request.post(`${Config.customerAPIRoot}/Customer/RetrieveStoreInfo`,false);
}

function addNewDQProduct(productList) {
  return Request.post(`${Config.productAPIRoot}/Product/AddNewDQProduct`, productList);
}

function mergeDQProducts(productGuidList) {
  return Request.post(`${Config.productAPIRoot}/Product/MergeDQProducts`, productGuidList);
}

function updateDQProduct(model) {
  return Request.post(`${Config.productAPIRoot}/Product/UpdateDQProduct`, model);
}

function GetMySharePicture() {
  return Request.post(`${Config.customerAPIRoot}/Customer/GetMySharePicture`, {
    TemplateType: 1
  });
}

function BatchUpdateOrderStatus(batchOrderStatus) {
  return Request.post(`${Config.orderAPIRoot}/Order/BatchUpdateOrderStatus`, batchOrderStatus);
}
function BatchPayOrders(orderList) {
  return Request.post(`${Config.orderAPIRoot}/Order/BatchPayOrders`, orderList);
}
function updateOrderImage(dataModel) {
  return Request.post(`${Config.orderAPIRoot}/Order/UpdateOrderImage`, dataModel);
}
function RemoveDQProductPicture(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/RemoveDQProductPicture`, dataModel);
}
function SetBasicShippingFee(shippingPrice) {
  return Request.post(`${Config.orderAPIRoot}/Order/SetBasicShippingFee`, shippingPrice);
}
function GetBasicShippingFee(shippingPrice) {
  return Request.post(`${Config.orderAPIRoot}/Order/GetBasicShippingFee`);
}
function ExportDQOrders(dataModel){
  return Request.post(`${Config.orderAPIRoot}/Order/ExportDQOrders`, dataModel);
}
function PublishAdvertisement(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/PublishAdvertisement`, dataModel);
}
function UpdateAdvertisement(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/UpdateAdvertisement`, dataModel);
}
function RemoveAdvertisement(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/RemoveAdvertisement`, dataModel);
}
function SearchAdvertisement(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/SearchAdvertisement`, dataModel);
}
function AdvertisementClicked(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/AdvertisementClicked`, dataModel);
}
function AddNewStoreApplication(dataModel){
  return Request.post(`${Config.customerAPIRoot}/Customer/AddNewStoreApplication`, dataModel);
}

function LoadAllVendors() {
  return Request.post(`${Config.customerAPIRoot}/Customer/LoadAllVendors`,'');
}
function GetVendorCategoryList() {
  return Request.post(`${Config.productAPIRoot}/Product/GetVendorCategoryList`, '');
}
function SearchVendorProduct(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/SearchVendorProduct`, dataModel);
}
function GetVendorProduct4Publish(vendorProductGuid) {
  return Request.postRaw(`${Config.productAPIRoot}/Product/GetVendorProduct4Publish`, vendorProductGuid);
}
function PublishVendorProduct(dataModel) {
  return Request.post(`${Config.productAPIRoot}/Product/PublishVendorProduct`, dataModel);
}
function BindInternalVendor(dataModel) {
  return Request.post(`${Config.customerAPIRoot}/Customer/BindInternalVendor`, dataModel);
}

const WebApi = {
  BindInternalVendor,
  PublishVendorProduct,
  GetVendorProduct4Publish,
  SearchVendorProduct,
  GetVendorCategoryList,
  LoadAllVendors,
  AddNewStoreApplication,
  AdvertisementClicked,
  SearchAdvertisement,
  RemoveAdvertisement,
  UpdateAdvertisement,
  PublishAdvertisement,
  ExportDQOrders,
  GetBasicShippingFee,
  SetBasicShippingFee,
  BatchUpdateOrderStatus,
  RemoveDQProductPicture,
  BatchPayOrders,
  updateOrderImage,
  GetMySharePicture,
  RegisterAsOwner,
  getMyAccessStores,
  userLogin,
  retrieveStoreInfo,
  addNewMoment,
  repostMoment,
  removeMoment,
  removeDQProduct,
  searchDQProduct,
  searchDQProductGroup,
  updateOrderStatus,
  loadOrderCountSummary,
  deleteOrder,
  searchOrder,
  placeOrder,
  updateOrder,
  setDefaultAddress,
  searchStoreCustomerAddress,
  deleteStoreCustomerAddress,
  addStoreCustomerAddress,
  updateStoreCustomerAddress,
  loadChinaCityCode,
  loadMomentTopics,
  loadProductTags,
  calculateOrderPrice,
  loadWishList,
  removeProductFromWishList,
  addToWishList,
  loadShoppingCart,
  addToShoppingCart,
  updateShoppingCart,
  SendMobileVerificationCode,
  VerificationCodeLogin,
  UpdateCustomerPhoneNumber,
  RefreshUserInfo,
  GetMySharePicture,
  GetDQProductSharePicture,
  GetDQOrderSharePictureEx,
  GetDQMomentSharePicture,
  getValidRedBonus,
  mergeDQProducts,
  addNewDQProduct,
  updateDQProduct,
};

export default WebApi;

module.exports = WebApi;