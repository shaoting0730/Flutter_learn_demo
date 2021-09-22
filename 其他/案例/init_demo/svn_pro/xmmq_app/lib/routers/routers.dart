import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handle.dart';

class Routers {
  static String root = '/';
  static String loginPage = './login';
  static String phoneLoginPage = './phone_login';
  static String publishActivitySuccessPage = './publish_activity_success';
  static String publishActivityPage = './publish_activity';
  static String storeMainPage = './store_main';
  static String orderListPage = './order_list';
  static String freightSettingsPage = './freight_settings';
  static String advertisingPage = './advertising';
  static String feedbackPage = './feedback';
  static String shareWechatAccountPage = './share_wechat_account';
  static String bindingPhonePage = './binding_phone';
  static String editsharePage = './edit_share';
  static String userRolePage = './user_role';
  static String settingPage = './setting_page';
  static String manageAddressPage = './manage_address_page';
  static String mineSupplierPage = './mine_supplier_page';
  static String onlineSupplierPage = './online_supplier_page';
  static String editImagePage = './edit_image_page';
  static String exportOrderPage = './export_order_page';
//  static String editProductPage = './edit_produpct_page';
  static String freeSetupShopPage = './free_setupShop_Page';
  static String registerPage = './register_page';
  static String editTagPage = './edit_tag_page';
  static String supplierProductPage = './supplier_product_pageHandle';
  static String usernameLoginPage = './username_login_page';
  static String supplierImagePage = './supplier_image_page';
  static String supplierReferralCode = './supplier_referral_code';

  static void configureRouters(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("路由未知");
    });
    router.define(root, handler: welcomeHandle);
    router.define(loginPage, handler: loginHandle);
    router.define(phoneLoginPage, handler: phoneLoginHandle);
    router.define(publishActivitySuccessPage,
        handler: publishActivitySuccessHandle);
    router.define(publishActivityPage, handler: publishActivityHandle);
    router.define(storeMainPage, handler: storeMainHandle);
    router.define(orderListPage, handler: ordersListHandle);
    router.define(freightSettingsPage, handler: freightSettingsHandle);
    router.define(advertisingPage, handler: advertisingHandle);
    router.define(feedbackPage, handler: feedbackHandle);
    router.define(shareWechatAccountPage,
        handler: shareWechatAccountPageHandle);
    router.define(bindingPhonePage, handler: bindingPhoneHandle);
    router.define(editsharePage, handler: editSharePageHandle);
    router.define(userRolePage, handler: userRolePageHandle);
    router.define(settingPage, handler: settingPageHandle);
    router.define(manageAddressPage, handler: manageAddressPageHandle);
    router.define(mineSupplierPage, handler: mineSupplierPageHandle);
    router.define(onlineSupplierPage, handler: onlineSupplierPageHandle);
    router.define(exportOrderPage, handler: exportOrderPageHandle);
    router.define(freeSetupShopPage, handler: freeSetupShopPageHandle);
    router.define(registerPage, handler: registerPageHandle);
    router.define(editTagPage, handler: editTagPageHandle);
//    router.define(supplierProductPage, handler: supplierProductPageHandle);
    router.define(usernameLoginPage, handler: usernameLoginPageHandle);
    router.define(supplierImagePage, handler: supplierImagePageHandle);
    router.define(supplierReferralCode, handler: supplierReferralCodeHandle);
//    router.define(editProductPage, handler: editProductPageHandle);
//    router.define(editImagePage, handler: editImagePageHandle);
  }
}
