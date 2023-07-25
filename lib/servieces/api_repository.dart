

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:get/get.dart';

import '../constants/enums/network_types.dart';
import 'api_base_helper_class.dart';
import 'api_end_points.dart';
import 'api_params.dart';


class ApiRepository{

  ApiHelperClass apiBaseHelperClass = ApiHelperClass();
  final CommonController commonController = Get.put(CommonController());

  // Map<String,String> commonHeader= {
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'COMPANY' : company,
  //   'YEARCODE' : yearcode,
  //   'Authorization': 'Bearer ${commonController.acessToken.value}'
  //
  // };


  apiGetToken(){
    Map<String,String> params= {
      ApiParams.grant_type: 'password',
      ApiParams.username: 'user@beamserp.com',
      ApiParams.password: '123456',

    };
    return apiBaseHelperClass.tokenPostRequest(ApiEndPoints.token,params);
  }



  apiUserLogin(passCode,devid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,String> params= {
      ApiParams.PASScode:passCode,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.userlogin,params,header);
  }



  apiRegistration(slcode,fname,mail,mobnum,dob,gender,addrss,city,countrycode){
    dprint(dob);
    dprint(gender);

    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
     "CUSTOMER_DET":[
      {
        ApiParams.slcode:slcode,
        ApiParams.brnCode:"",
        ApiParams.fullname: fname,
        ApiParams.city: city,
        ApiParams.country: 'UAE',
        ApiParams.addresss: addrss,
        ApiParams.addresss2: "",
        ApiParams.addresss3: "",
        ApiParams.pobox: "",
        ApiParams.tel1: "",
        ApiParams.tel2: countrycode,
        ApiParams.mobile: mobnum,
        ApiParams.email: mail,
        ApiParams.dob: dob,
        ApiParams.gender: gender,
      }
     ]
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.customer_reg,params,header);

  }

  apiCustomerDetails(String slcode){
    dprint("SL__CODE  ${slcode}");
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.tableName:"SLMAST",
      ApiParams.colums:"${ApiParams.slcode}|${ApiParams.fullname}|${ApiParams.mobile}|${ApiParams.addresss}|${ApiParams.city}|${ApiParams.email}|${ApiParams.dob}|",
      ApiParams.lstrPage:"0",
      ApiParams.lstrLimit:"1000",
      ApiParams.lstrFilter:[{ "Column": "SLCODE", "Operator": "=", "Value": slcode, "JoinType": "OR" }],

    };
    dprint("Parmsssss ${params}");
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.lookupSearch,params,header);
  }

  apiLookupSerach(String tableName,String column,var filter){
    dprint("Call__api");
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.tableName:tableName,
      ApiParams.colums:column,
      ApiParams.lstrPage:"0",
      ApiParams.lstrLimit:"1000",
      ApiParams.lstrFilter:filter,
    };
    dprint("Parmsssss ${params}");
    return apiBaseHelperClass.postRequest(false,ApiEndPoints.lookupSearch,params,header);
  }


  apiCardIssue(String topupamount, totalamount,registartioncharge,paymnetmode,cardnumber,slcode,deviceid){
    dprint("Call__api");
    Map<String,dynamic> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: deviceid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.top_up_amount:topupamount,
      ApiParams.card_details:[
    {
    ApiParams.slcode: slcode,
    ApiParams.brnCode: "",
    ApiParams.card_number: cardnumber,
    ApiParams.card_pin: "123",
    ApiParams.card_type: "",
    ApiParams.reg_charge: registartioncharge
    }
    ],
      ApiParams.retail_pay_details: [
        {
          ApiParams.sr_no: "1",
          ApiParams.paymode: paymnetmode,
          ApiParams.amt: totalamount,
          ApiParams.card_no: ""
        }

      ]
    };
    dprint("Parmsssss ${params}");
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.cardissue,params,header);
  }


  apiCardDuplicate(remainingbalnce,servieceCharge,paymnetmode,newcardnumber,slcode,deviceid,oldcardnumb){
    dprint("Call__api");
    Map<String,dynamic> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: deviceid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.top_up_amount:remainingbalnce,
      ApiParams.card_details:[
        {
          ApiParams.slcode: slcode,
          ApiParams.brnCode: "",
          ApiParams.card_number: newcardnumber,
          ApiParams.card_pin: "123",
          ApiParams.card_type: "",
          ApiParams.reg_charge: servieceCharge,
          "OLD_CARDNO":oldcardnumb,
          "OLD_BALANCE":remainingbalnce
        }
      ],
      ApiParams.retail_pay_details: [
        {
          ApiParams.sr_no: "1",
          ApiParams.paymode: paymnetmode,
          ApiParams.amt: servieceCharge,
          ApiParams.card_no: ""
        }

      ]
    };
    dprint("Parmsssss ${params}");
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.cardissue,params,header);
  }





  apiCardRenew(deviceid,renewCharge,cardNumb,paymntMode){
    Map<String,dynamic> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: deviceid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.renewcharge:renewCharge,
      ApiParams.card_number:cardNumb,
      ApiParams.table_retailpay:[
        {
          ApiParams.sr_no:"1",
          ApiParams.paymode:paymntMode,
          ApiParams.amt:renewCharge,
          ApiParams.card_no:""
        }
      ]
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.card_renew,params,header);

  }

  apiCustomerData(String slcode){
    dprint("SL__CODE  ${slcode}");
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.tableName:"SLMAST",
      ApiParams.colums:"${ApiParams.slcode}|${ApiParams.fullname}|${ApiParams.mobile}|${ApiParams.addresss}|${ApiParams.city}|${ApiParams.email}|${ApiParams.dob}|",
      ApiParams.lstrPage:"0",
      ApiParams.lstrLimit:"1000",
      ApiParams.lstrFilter:[{ "Column": "SLCODE", "Operator": "=", "Value": slcode, "JoinType": "OR" }],

    };
    dprint("Parmsssss ${params}");
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.lookupSearch,params,header);
  }

  apiTopup(topupamount,cardnumber,paymode,devid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.top_up_amount:topupamount,
      ApiParams.brnCode:"",
      ApiParams.card_number:cardnumber,
      ApiParams.retail_pay_details:[{
        ApiParams.sr_no: "1",
        ApiParams.paymode:paymode,
        ApiParams.amt: topupamount,
        ApiParams.card_no: "" }],

    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.card_topup,params,header);
  }


  apiCardDetails(cardnumber,devid,histry){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),

    };
    Map<String,dynamic> params= {
      ApiParams.card_number:cardnumber,
      "HISTORY_YN":histry
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.get_carddetails,params,header);
  }

  apiGetCounters(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.get_usercounter,"",header);
  }
  apiGetCardStockDet(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.getCardStockDet,"",header);
  }

  apiCardSale(devid,salhead,saldet){

    dprint("@222222222222222222222222");

    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.counter_salhead: salhead,
      ApiParams.counter_saldetails:saldet,
      ApiParams.brnCode:"",
      ApiParams.trn_docno:"",
      ApiParams.trn_docType:"",

    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.card_sale,params,header);


  }


  apiRegAmount(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"COMPANYPARA",
      "lstrSearchColumn" :"REG_AMOUNT|SYNC_DEVICEID|SYNC_USERCD|",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : []
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.lookupSearch,params,header);

  }

  apiRenewAmount(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"COMPANYPARA",
      "lstrSearchColumn" :"RENEW_CHARGE|",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : []
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.lookupSearch,params,header);

  }

  apiServieceCharge(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"COMPANYPARA",
      "lstrSearchColumn" :"DUPLICATE_CHARGE|",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : []
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.lookupSearch,params,header);

  }

  apiCollectionReport(devid,fromdate,todate,reportmode,adminoruser,choosedDevid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.datefrom:fromdate,
      ApiParams.dateto:todate,
      "ADMIN_YN":adminoruser,
      "REPORT_MODE":reportmode,
      "DEVICEID":choosedDevid


    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.get_report,params,header);

  }


  apiCollectionReportDetails(mode,devid,fromdate,todate,adminoruser,reportmode,choosedDevid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),

    };
    Map<String,dynamic> params= {
      ApiParams.datefrom:fromdate,
      ApiParams.dateto:todate,
      "MODE":mode,
      "ADMIN_YN":adminoruser,
      "REPORT_MODE":reportmode,
      "DEVICEID":choosedDevid
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.get_reportdet,params,header);

  }


  apiHistory(devid,fromdate,todate,adminoruser,reportmode,choosedDevid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.datefrom:fromdate,
      ApiParams.dateto:todate,
      "ADMIN_YN":adminoruser,
      "REPORT_MODE":reportmode,
      "DEVICEID":choosedDevid
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.get_history,params,header);

  }

  apiAmounttoPay(devid,salhead,saldet,[doctype,docnumb]) {
    dprint("Doc TYPE........in  APIiii..... ${doctype}");
    dprint("Doc Numbeerrr...IN API .. ${docnumb}");

    Map<String, String> header = {
      ApiParams.authorization: ApiParams.bearer +
          commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String, dynamic> params = {
      ApiParams.counter_salhead: salhead,
      ApiParams.counter_saldetails: saldet,
      ApiParams.brnCode: "",
      ApiParams.trn_docType: doctype??"",
      ApiParams.trn_docno: docnumb??"",
    };
    return apiBaseHelperClass.postRequest(
        true, ApiEndPoints.card_sale, params, header);
  }


  apiTapToPay(devid,salhead,saldet,[doctype,docnumb]) {
    dprint("Doc TYPE........in  APIiii..... ${doctype}");
    dprint("Doc Numbeerrr...IN API .. ${docnumb}");

    Map<String, String> header = {
      ApiParams.authorization: ApiParams.bearer +
          commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String, dynamic> params = {
      ApiParams.counter_salhead: salhead,
      ApiParams.counter_saldetails: saldet,
      ApiParams.brnCode: "",
      ApiParams.trn_docType: doctype??"",
      ApiParams.trn_docno: docnumb??"",
    };
    return apiBaseHelperClass.postRequest(
        true, ApiEndPoints.card_tapsale, params, header);
  }




  apiCardBlock(devid,cardnumb){
    Map<String, String> header = {
      ApiParams.authorization: ApiParams.bearer +
          commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String, dynamic> params = {
      ApiParams.card_number: cardnumb,
    };
    return apiBaseHelperClass.postRequest(
        true, ApiEndPoints.card_block, params, header);

  }

  apiGetPrinter(devid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.getprinters,"",header);
  }
  apiGetPrintSetup(printcode){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,

    };
    Map<String, dynamic> params = {
     "PRINT_CODE": printcode.toString(),
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.getPrintSetup,params,header);
  }


  /////RegisterDevice..........................................
  apiRegstrDevice(devid,devName,fcmtoken,company,currentdate,status){

    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.brnCode:"",
      ApiParams.company:company,
      ApiParams.device_id:devid,
      ApiParams.device_name:devName,
      ApiParams.fcmkey:fcmtoken,
      ApiParams.regdate:currentdate,
      ApiParams.ref1:"",
      ApiParams.ref2:"",
      ApiParams.ref3:"",
      ApiParams.ref4:"",
      ApiParams.ref5:"",
      ApiParams.status:status,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.registerDevice,params,header);

  }

  apiCheckDevice(devid,company,fcm){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.brnCode:"",
      ApiParams.device_id:devid,
      ApiParams.company:company,
      ApiParams.fcmkey:fcm

    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.cehckDevice,params,header);

  }

  ////NOTIFICATION TO PAYED DEVICE
  apiUpadtenotification(paidAmount,company,docno,trdocno,trnusr,trndate,response,cardnumber){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.company:company,
      ApiParams.paid_amount:paidAmount,
      ApiParams.docno:docno,
      ApiParams.doctype:"PTXN",
      ApiParams.trn_docno:trdocno,
      ApiParams.trn_docType:"CSAL",
      ApiParams.trn_cardnumber:cardnumber,
      ApiParams.trn_User:trnusr,
      ApiParams.trn_Date:trndate,
      ApiParams.response:response

    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.updatepayment,params,header);

  }


  apiPendingPayment(devid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      ApiParams.devid: devid.toString(),
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.getPendingPayment,params,header);
  }

  /////GET BISTRO.....
  apiGetbistro(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.getbistro,"",header);
  }

  // apiGetBistroToken(url){
  //   dprint("  bistrooourl  ${url}"  );
  //   Map<String,String> params= {
  //     ApiParams.grant_type: 'password',
  //     ApiParams.username: 'user@beamserp.com',
  //     ApiParams.password: '123456',
  //
  //   };
  //   return apiBaseHelperClass.bistroToken("${url+"/token"}",params);
  // }

  apiCardissueUpdateSale(devid,issuedocnumb,issuedoctype,salecompny,saledoctype,saledocnub){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      "ISSUE_DOCNO":issuedocnumb,
      "ISSUE_DOCTYPE":issuedoctype,
      "SALE_COMPANY":salecompny,
      "SALE_DOCNO":saledoctype,
      "SALE_DOCTYPE":saledocnub
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.card_issue_updatesales,params,header);
  }

  apiCardissuePending(devid,usercode){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: devid.toString(),
    };
    Map<String,dynamic> params= {
      "CREATE_USER":usercode,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.get_PendingCardIssue,params,header);
  }





  apiSaveInvoice(company,yearcode,bistrotoken,bistroUrl,rsl,rslDet,retailPay,mode,printerpath,paymode){
    // dprint("  bistrooourl  ${bistroUrl}"  );
    // dprint("  bistroootOKE  ${bistrotoken}"  );
    Map<String,String> header= {
      'Content-Type': 'application/json; charset=UTF-8',
      'COMPANY' : company,
      'YEARCODE' : yearcode,
      'Authorization': 'Bearer $bistrotoken'
    };


    Map<String,dynamic> params= {
      'RSL':rsl,
      'RSLDET':rslDet,
      'RSL_VOID':[],
      'RSL_VOIDDET':[],
      'RETAILPAY':retailPay,
      'RSL_ADDL_CHARGE':[],
      'MODE':mode,
      'CLOSE_BOOKING':"",
      "PRINTER_PATH":printerpath,
      "PAY_MODE":paymode,
      "PRINT_YN":"Y",
      "INV_MODE": "",
      "RSL_VOID_HISTORY":[],
      "RSL_VOID_HISTORY_DET":[],
      "RSL_OTHERCHARGE":[],
      "PAYMENT_DOCNO":"",
      "PAYMENT_DOCTYPE":"",
      "PAYMENT_CARD":"",
    };
    return apiBaseHelperClass.postRequest(true,"${bistroUrl+"${ApiEndPoints.saveInvoice}"}",params,header);
  }





  //////Admin  Api..StartRegion.............................................

  apiAppSettings(cardExpDays,regAmount,renewCharge,duplicatCharge){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,

    };
    Map<String,dynamic> params= {
      ApiParams.card_exp_days:cardExpDays,
      ApiParams.regAmount:regAmount,
      ApiParams.renewcharge:renewCharge,
      ApiParams.duplicate_charge:duplicatCharge,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.updateAppSetup,params,header);
  }

  apiUserCreate(username,usercode,userpasscode,userpassword,[rolecode,roledescp]){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "USERNAME":username,
      "USER_CD":usercode,
      "PASSWORD":userpassword,
      "PASSCODE":userpasscode,
      "ROLE_CODE":rolecode,
      "ROLE_DESCP":roledescp,

    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.createuser,params,header);
  }


  apiInitialAppSetting(){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"COMPANYPARA",
      "lstrSearchColumn" :"CARD_EXP_DAYS|REG_AMOUNT|RENEW_CHARGE|DUPLICATE_CHARGE|",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : []
    };

    return apiBaseHelperClass.postRequest(true,ApiEndPoints.lookupSearch,params,header);

  }

  apiViewCounter(code,mode){

    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.brnCode:"",
      ApiParams.code:code,
      ApiParams.mode:mode,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.view_countermast,params,header);

  }

  apiSaveCounter(code,mode,descrptn){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      ApiParams.brnCode:"",
      ApiParams.code:code,
      ApiParams.descp:descrptn,
      ApiParams.mode:mode,
    };
   return apiBaseHelperClass.postRequest(true,ApiEndPoints.save_countermast,params,header);

  }


  apiAdminLogin(passWord,username){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      "PASSWORD":passWord,
      "USERNAME":username,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.userlogin,params,header);
  }
  apiAdminViewRegistertion(code,mode){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      ApiParams.slcode:code,
      ApiParams.mode:mode,
      ApiParams.brnCode:'',
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.view_registration,params,header);
  }

  apiAdminViewUser(code,mode){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      "USER_CD":code,
      ApiParams.mode:mode,
      ApiParams.brnCode:'',
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.view_usermast,params,header);
  }

  apiAdminEditUser(code,username,passcode,passwrd,[rolecode,roledescp]){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      "USER_CD":code,
      "USERNAME":username,
      "PASSWORD":passwrd,
      "PASSCODE":passcode,
      "ROLE_CODE":rolecode,
      "ROLE_DESCP":roledescp,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.edituser,params,header);
  }

  apiUserSearch(value){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"USERMAST",
      "lstrSearchColumn" :"USER_CD|USERNAME|PASSCODE|PASSWORD",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : [
        { "Column": "USER_CD", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },
        { "Column": "USERNAME", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },

    ]
    };

    return apiBaseHelperClass.postRequest(false,ApiEndPoints.lookupSearch,params,header);

  }
  apiUserSearchRegister(value){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"SLMAST",
      "lstrSearchColumn" :"SLDESCP|MOBILE|EMAIL|COUNTRY|SLCODE|",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : [
        { "Column": "SLDESCP", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },
        { "Column": "MOBILE", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },
        { "Column": "SLCODE", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },

      ]
    };

    return apiBaseHelperClass.postRequest(false,ApiEndPoints.lookupSearch,params,header);

  }

  apiDeviceslist(value){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "lstrTable":"TAP_DEVICES",
      "lstrSearchColumn" :"DEVICE_ID|DEVICE_NAME|STATUS|",
      "lstrPage" : 0,
      "lstrLimit": 1000,
      "lstrFilter" : [
        { "Column": "DEVICE_ID", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },
        { "Column": "DEVICE_NAME", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },
        { "Column": "STATUS", "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" },


      ]
    };

    return apiBaseHelperClass.postRequest(false,ApiEndPoints.lookupSearch,params,header);

  }

  apiUpdateTapDevice(devid){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      ApiParams.devid:devid
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.updateTapDevices,params,header);
  }

  apiAdminRechargeReport(devid,from,to,creatuser,cardnumb){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      "DATEFROM":from,
      "DEVICEID":devid,
      "DATETO":to,
      "CREATE_USER":creatuser,
      "CARDNO":cardnumb
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.rechargeReport,params,header);
  }
  apiAdminRegistereReport(devid,from,to,creatuser,cardnumb){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      "DATEFROM":from,
      "DEVICEID":devid,
      "DATETO":to,
      "CREATE_USER":creatuser,
      "CARDNO":cardnumb
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.regReport,params,header);
  }
  apiAdminRefundReport(devid,from,to,creatuser,cardnumb){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {

      "DATEFROM":from,
      "DEVICEID":devid,
      "DATETO":to,
      "CREATE_USER":creatuser,
      "CARDNO":cardnumb
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.refundReport,params,header);
  }
  apiAdminSalesReport(devid,from,to,creatuser,cardnumb){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      // "COMPANY":company,
      "DATEFROM":from,
      "DEVICEID":devid,
      "DATETO":to,
      "CREATE_USER":creatuser,
      "CARDNO":cardnumb
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.salesReport,params,header);
  }
  apiAdminExpireReport(devid,from,to,cardnumb){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,String> params= {
      "DATEFROM":from,
      "DATETO":to,
      "CARDNO":cardnumb
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.expiryReport,params,header);
  }

  apiAdminCardUsage(days){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "DAYS":mfnInt(days),

    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.nonUsageReport,params,header);
  }
  apiAdminCardHistory(cardnumber,from,to){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
      ApiParams.devid: "",

    };
    Map<String,dynamic> params= {

      "DATEFROM":from,
      "DATETO":to,
      "CARDNO":cardnumber
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.cardhistory,params,header);
  }


  apiOpenDrawer(path){
    Map<String,String> header= {
      ApiParams.authorization: ApiParams.bearer+commonController.wstrAcessToken.value,
    };
    Map<String,dynamic> params= {
      "PRINTER_PATH":path,
    };
    return apiBaseHelperClass.postRequest(true,ApiEndPoints.openDrawer,params,header);
  }



//////Admin  Api..EndRegion.............................................


}