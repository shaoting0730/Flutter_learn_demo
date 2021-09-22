import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../pages/store_main.dart';
import '../pages/welcome.dart';
import '../pages/personal_center/binding_phone.dart';
import '../pages/personal_center/advertising.dart';
import '../pages/personal_center/feedback.dart';
import '../pages/personal_center/freight_settings.dart';
import '../pages/login.dart';
import '../pages/personal_center/orders.dart';
import '../pages/phone_login.dart';
import '../pages/store_dynamic/publish_activity.dart';
import '../pages/personal_center/publish_activity_success.dart';
import '../pages/share_wechat_account.dart';
import '../pages/store_dynamic/edit_share.dart'; // 编辑分享内容
import '../pages/personal_center/user_role.dart'; // 用户角色界面
import '../pages/personal_center/setting_page.dart'; //  设置界面
import '../pages/personal_center/manage_address_page.dart'; // 管理收货地址
import '../pages/personal_center/mine_supplier_page.dart'; // 我的供应商
import '../pages/personal_center/online_supplier_page.dart'; // 线上供应商
import '../pages/personal_center/export_order_page.dart'; // 一键导出订单
import '../pages/store_dynamic/edit_image_page.dart'; // 编辑图片
import '../pages/store_dynamic/edit_product_page.dart'; //编辑产品
import '../pages/free_setupShop.dart'; //免费开店
import '../pages/register_page.dart'; //注册页面
import '../pages/select_store_page.dart'; //选择店面
import '../pages/store_dynamic/edit_tag.dart'; //选择tag
import '../pages/personal_center/supplier_product_page.dart'; // 供应商商品列表
import '../pages/username_login_page.dart'; // 用户名登录
import '../pages/personal_center/supplier_image_page.dart'; // 产品图片
import '../pages/personal_center/supplier_referral_code.dart'; // 供应商推荐码

//
Handler storeMainHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  String paramsId = params['id'].first;
  return StoreMainPage();
});

Handler welcomeHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WelcomeScreen();
});

Handler bindingPhoneHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BindingPhonePage();
});

Handler advertisingHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AdvertisingPage();
});

Handler feedbackHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FeedbackPage();
});

// 运费设置
Handler freightSettingsHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String currentMoney = params['currentMoney'].first;
  return FreightSettingsPage(currentMoney: currentMoney);
});

Handler loginHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

Handler ordersListHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OrderListPage();
});

Handler phoneLoginHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PhoneLoginPage();
});

// 发布页面
Handler publishActivityHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PublishActivity();
});

Handler publishActivitySuccessHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PublishActivitySuccess();
});

Handler shareWechatAccountPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ShareWechatAccountPage();
});

// 编辑分享内容
Handler editSharePageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String text = params['text'].first;
  return EditSharePage(text: text);
});

// 用户角色界面
Handler userRolePageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserRolePage();
});

// 设置界面
Handler settingPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String modelStr = params['modelStr'].first;
  return SettingPage(modelStr: modelStr);
});

// 管理收货地址
Handler manageAddressPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String modelStr = params['modelStr'].first;
  return ManageAddressPage(modelStr: modelStr);
});

//我的供应商
Handler mineSupplierPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MineSupplierPage();
});

//线上供应商
Handler onlineSupplierPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String guid = params['guid'].first;

  return OnlineSupplierPage(guid: guid);
});

// 一键导出订单
Handler exportOrderPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ExportOrderPage();
});

//编辑图片
//Handler editImagePageHandle = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  return EditImagePage();
//});

// 编辑产品
//Handler editProductPageHandle = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  return EditProductPage();
//});

// 免费开店
Handler freeSetupShopPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FreeSetupShopPage();
});

// 注册页面
Handler registerPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});

// 编辑标签
Handler editTagPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EditTagPage();
});

// 用户名登录
Handler usernameLoginPageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UsernameLoginPage();
});
//
//// 供应商商品列表
//Handler supplierProductPageHandle = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  String VendorCategoryGuid = params['VendorCategoryGuid'].first;
//  String VendorGuid = params['VendorGuid'].first;
//  String img = params['img'].first;
//  String name = params['name'].first;
//  return SupplierProductPage(
//      VendorCategoryGuid: VendorCategoryGuid, VendorGuid: VendorGuid);
//});

// 供应商商品图片 & 编辑产品的大图
Handler supplierImagePageHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String imgStr = params['imgStr'].first;
  return SupplierImagePage(imgStr: imgStr);
});

// 供应商推荐码
Handler supplierReferralCodeHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SupplierReferralCode();
});
