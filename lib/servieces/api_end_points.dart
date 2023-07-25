
class ApiEndPoints {

  //
  static const subPathUser = "/api";
  // static const subDomainUserAuth = "/api/";
  // static const String login = subDomainUserAuth+"token";
  static const String products ="/products";
  static const String token ="/token";
  static const String userlogin =subPathUser+"/userlogin";
  static const String customer_reg =subPathUser+"/customer_reg";
  static const String lookupSearch =subPathUser+"/lookupSearch";
  static const String cardissue =subPathUser+"/card_issue";
  static const String card_topup =subPathUser+"/card_topup";
  ///TOPUP DETAILS
  static const String get_carddetails =subPathUser+"/get_carddetails";
  static const String get_usercounter =subPathUser+"/get_usercounter";
  static const String card_sale =subPathUser+"/card_sale";
  static const String card_tapsale =subPathUser+"/card_tapsale";
  static const String get_report =subPathUser+"/get_report";
  static const String get_history =subPathUser+"/get_history";
  static const String get_reportdet =subPathUser+"/get_reportdet";
  static const String card_renew =subPathUser+"/card_renew";
  ///ADMIN
  static const String updateAppSetup =subPathUser+"/updateAppSetup";
  static const String card_block =subPathUser+"/card_block";
  static const String view_countermast =subPathUser+"/view_countermast";
  static const String save_countermast =subPathUser+"/save_countermast";
  static const String createuser =subPathUser+"/createuser";
  static const String view_registration =subPathUser+"/view_registration";
  static const String view_usermast =subPathUser+"/view_usermast";
  static const String edituser =subPathUser+"/edituser";
  static const String updateTapDevices =subPathUser+"/updateTapDevices";
  static const String cardhistory =subPathUser+"/cardhistory";
  static const String openDrawer =subPathUser+"/openDrawer1";


  static const String rechargeReport =subPathUser+"/rechargeReport";
  static const String regReport =subPathUser+"/regReport";
  static const String refundReport =subPathUser+"/refundReport";
  static const String salesReport =subPathUser+"/salesReport";
  static const String expiryReport =subPathUser+"/expiryReport";
  static const String nonUsageReport =subPathUser+"/nonUsageReport";




  ///DEVICE REG
  static const String cehckDevice =subPathUser+"/cehckDevice";
  static const String registerDevice =subPathUser+"/registerDevice";

  ///NOTIFICATION TO PAYED DEVICE
  static const String updatepayment =subPathUser+"/updatepayment";

 ///PENDING PAYMENT
  static const String getPendingPayment =subPathUser+"/getPendingPayment";


  ///BISTRO
  static const String getbistro =subPathUser+"/getbistro";
  static const String saveInvoice =subPathUser+"/saveInvoice";


  ///CARDISSUE update sale
  static const String card_issue_updatesales =subPathUser+"/card_issue_updatesales";
  static const String get_PendingCardIssue =subPathUser+"/get_PendingCardIssue";
  static const String getCardStockDet =subPathUser+"/getCardStockDet";

///PRINTER
  static const String  getprinters =subPathUser+"/getprinters";
  static const String  getPrintSetup =subPathUser+"/getPrintSetup";




}