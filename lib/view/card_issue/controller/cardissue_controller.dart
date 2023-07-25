import 'dart:io';

import 'package:beams_tapp/common_widgets/CommonAlertDialog.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/intialmode.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';

import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/model/customerDetailModel.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../model/card_detailModel.dart';

class CardIssueController extends GetxController{

  RxString initial_payment = 'Cash'.obs;
  RxBool customerdetails_enable = false.obs;
  RxBool scanCard_enable = false.obs;
  RxBool payment_enable = false.obs;
  RxBool cstmrdetailLoading = true.obs;
  ApiRepository apiRepository = ApiRepository();
 // final CommonController commonController = Get.put(CommonController());
  final TextEditingController txtAmount = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? resultbarcode;
  QRViewController? qrController;
  RxString customer_name=''.obs;
  RxString sl_code=''.obs;
  RxString customer_email=''.obs;
  RxString customer_dob=''.obs;
  RxString customer_mobile=''.obs;
  String printCode  ='ISSUE';
  RxBool card_show = false.obs;
  RxDouble reg_amount = 0.0.obs;
  RxBool isTaped = true.obs;
  RxBool isAvailable = false.obs ;
  RxString customer_city=''.obs;
  RxString cardnumber=''.obs;
  late Future <dynamic> futureform;
  RxString bistroUrl=''.obs;
  RxString bistroCompany=''.obs;
  RxString bistroYearCode=''.obs;
  RxString bistroToken ="".obs;
  RxString issueDocNumb ="".obs;
  RxString issueDocType ="".obs;
  RxString saleDocType ="".obs;
  RxString saleDocNumb ="".obs;

  RxString syncDevice ="".obs;
  RxString syncUser ="".obs;

  RxString dishCode ="".obs;
  RxString dishkDesc ="".obs;
  RxDouble dishkVat =0.0.obs;


  var paymnet_method = [
    'Cash',
    'Card',
    'Other',
    'Foc',
  ];

  fnOnChangePayment(val){
    initial_payment.value = val;
  }


  void fnOnQRViewCreated(QRViewController controller) {
    qrController = controller;
    if (Platform.isAndroid) {
      qrController?.resumeCamera();
    } else if (Platform.isIOS) {
      qrController?.resumeCamera();
    }
    qrController?.scannedDataStream.listen((scanData) {


    }).onData((scanData) {
      fnCheckIfValidQR(scanData);
    });
  }

  void fnCheckIfValidQR(Barcode scanData) async {
    dprint("SCCCCAAN  DATAA  ${scanData.code}");
    try {
      qrController?.stopCamera();
      qrController?.dispose();

      Get.back();
      fnCustomerDetails(scanData.code.toString());


    } on FormatException catch (e) {
      dprint(e.message);
    }
  }





  fnCustomerDetails(slcode)async{
    dprint("customeeeeeeeer");
    cstmrdetailLoading.value = true;
    dprint("!! Slcode "+slcode.toString());
    try{
      final responseJson = await apiRepository.apiCustomerDetails(slcode);
      dprint(responseJson.toString());
      CustomerDetailsModel customerDetailsModel = CustomerDetailsModel.fromJson(responseJson[0]);
      DateTime dob = DateTime.parse(customerDetailsModel.dOB.toString());
      print(dob); //// 2020-01-02 03:04:05.000

      ///need a StatusCode for enable ScanCard


      sl_code.value = customerDetailsModel.sLCODE.toString();
      customer_name.value = customerDetailsModel.sLDESCP.toString();
      customer_email.value = customerDetailsModel.eMAIL.toString();
      customer_dob.value = setDate(13,dob);
      customer_mobile.value = customerDetailsModel.mOBILE.toString();
      customer_city.value = customerDetailsModel.cITY.toString();
      scanCard_enable.value = true;
      cstmrdetailLoading.value = false;

    }catch(e){
      cstmrdetailLoading.value = false;
      // CustomToast.showToast(
      //     e.toString(), ToastType.error, ToastPositionType.end);
          dprint("!! @@@@::>> "+e.toString());
    }


  }

  fnClearDetails(){


    dprint("Clear Car..d details ");
    scanCard_enable.value =false;
    qrController?.dispose();
    payment_enable.value =false;
    cstmrdetailLoading.value = false;
    customer_name.value ="";
    customer_email.value="";
    customer_dob.value="";
    customer_mobile.value="";
    customer_city.value="";
    card_show.value = false;
    isTaped.value =true;
    txtAmount.text="";
    initial_payment.value = 'Cash';

    update();

  }

  fnTaped(context)async{
    fnCheckNFCAvailability(context);
    isTaped.value = false;

  }
  Future fnCheckNFCAvailability(context) async {
    // Check availability
    isAvailable.value = await NfcManager.instance.isAvailable();
    dprint("AVAILABLE  ${isAvailable.value}");
    if(isAvailable.value){
      dprint("hold..............");

      fnTagRead();
    }
  }







  ValueNotifier<dynamic> result = ValueNotifier(null);

  void fnTagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');

        dprint("identifierddff  ${serialnumb}");
        cardnumber.value = serialnumb!;

        if(cardnumber.value != null){
          ///Payment Enabled
           payment_enable.value = true;
           card_show.value = true;
           await NfcManager.instance.stopSession();
           dprint("PaymentENBABLE ${payment_enable.value}");
           update();
        }

        result.value = tag.data;
        if (result.value == null) return;
        await NfcManager.instance.stopSession();
      } catch (e) {
        await NfcManager.instance.stopSession();
      }
      NfcManager.instance.stopSession();
    });
  }

  fnResetCard(context){
    card_show.value =false;
    payment_enable.value = false;
    fnTaped(context);
  }


  fnCardIssue(topup,cardnumbr,paymentmode,regcharge,slcode)async{
    dprint("_ topup___ ${topup} cardnumbr _ ${cardnumbr}- paymentmode-${paymentmode}_regcharge _ ${regcharge} ----slcode-${slcode}");
    if (slcode!=null){
      try{
        var devid = await  Prefs.getString(AppStrings.deviceId);
        dprint("DEVICE IDDD ${devid}");
        if(topup==""){
          topup ="0";
        }
        dprint("Topupppppp ${topup}");
        var totalamount=mfnDbl(topup)+regcharge;
        dprint("TotalAmount ${totalamount}");
        final responseJson = await apiRepository.apiCardIssue(topup, totalamount,regcharge,paymentmode,cardnumbr,slcode,devid);
        CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
        if(commonModel.sTATUS=="1"){
          // CustomToast.showToast(commonModel.mSG.toString(), ToastType.success, ToastPositionType.end);
          issueDocNumb.value = commonModel.cODE.toString();
          issueDocType.value = commonModel.dOCTYPE.toString();
          var balance = commonModel.bALANCE.toString();

          fnGetbistro(totalamount,balance);

        }else {
          dprint("Clear Card...... details ");
          payment_enable.value =false;
          cstmrdetailLoading.value = false;
          card_show.value = false;
          isTaped.value =true;
          txtAmount.text="";
          initial_payment.value ='Cash';

          CustomToast.showToast(
              commonModel.mSG.toString(), ToastType.success,
              ToastPositionType.end);

        }
      }catch(e){
        dprint("EEEEEE  ${e.toString()}");
      }
    }





  }

  fnRegisterAmount()async{
   // reg_amount
    try{
      dprint("Register amouvvvnt");
      final responseJson = await apiRepository.apiRegAmount();
      var res= responseJson[0];
      reg_amount.value = res["REG_AMOUNT"];
      syncDevice.value = res["SYNC_DEVICEID"]??"Chrome";
      syncUser.value = res["SYNC_USERCD"]??"Admin";
      fnGetCaradStockDetails();
    }catch(e){
      dprint("registeramount catch ${e.toString()}");
    }

  }

  fnPay(context,cardnumbr,paymentmode,regcharge,slcode,topup) {
    dprint("Slcooooooyoooode ${slcode}");
    try{
      if ((slcode??"").toString().isNotEmpty) {
        return showDialog(
            context: context,
            builder: (context) =>
                CommonAlertDialog(onpressed: () {

                  fnCardIssue(topup,cardnumbr,paymentmode,regcharge,slcode);

                  // Get.back();
                }, alertmode: Alertmode.proceed,
                )
        );
      } else{
        dprint("nooovalidate");
      }
    }catch(e){
      dprint("Cardissuecontroller..... ${e.toString()}");
    }

  }

  fnBack(context){
    return showDialog(
        context: context,
        builder: (context) => CommonAlertDialog(onpressed: (){
          Get.offAll( HomeScreen(notificationDataModel: NotificationDataModel(DateTime.now(), 0.0, "","",DateTime.now())));
        },
          alertmode: Alertmode.exit,
        )
    );
  }

  fnGetbistro(totalamount,balance)async {

    dprint("bistroooooooooooo...........");
     try{
       futureform =  apiRepository.apiGetbistro();
       futureform.then((value) => fnGetBistroRes(value,totalamount,balance));
       // dprint("Token :: > "+commonController.acessToken.value);
     }catch(e){
       dprint(e.toString());
     }

   }
  fnGetBistroRes(value,totalamount,balance) {
    dprint("bistroooo ${value}");
    dprint(value);
    bistroUrl.value = value["BISTRO_URL"];
    bistroCompany.value = value["BISTRO_COMPANY"];
    bistroYearCode.value = value["BISTRO_YEARCODE"];
    bistroToken.value = value["BISTRO_TOKEN"];
    dprint(bistroUrl.value);
    dprint("BISTROOOO TOKENN :>>>${ bistroToken.value}");
    fnSaveInvoice(totalamount,balance);


    // try{
    //   futureform =  apiRepository.apiGetBistroToken(bistroUrl.value);
    //   futureform.then((value) => fnGetBistroTokenRes(value));
    //   // dprint("Token :: > "+commonController.acessToken.value);
    // }catch(e){
    //   dprint(e.toString());
    // }

  }

  fnSaveInvoice(totalamount,balance)async {
    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);
    try{
      var RSL = [];
      var RSLDET = [];
      var RETAILPAY = [];
      var taxableAmount=0.0;
      var taxAmount=0.0;
      var netTotal = reg_amount.value;

      if(dishkVat.value > 0){
        var dvd = 100 /(100+dishkVat.value);
        taxableAmount =  netTotal * dvd;

      }
      taxAmount = netTotal-taxableAmount;


      RSL.add({
        "COMPANY": bistroCompany.value,
        "YEARCODE":  bistroYearCode.value,
        "DUEDATE": "",
        "PARTYCODE": sl_code.value,
        "PARTYNAME":customer_name.value,
        "GUESTCODE": "",
        "GUESTNAME": "",
        "PRVDOCNO": "",
        "PRVDOCTYPE": "",
        "CASH_CREDIT": "",
        "CURR": "AED",
        "CURRATE": 1,
        "GRAMT": reg_amount.value,//  Registration amount
        "GRAMTFC":  reg_amount.value,
        "ADDL_AMT": 0.0,
        "ADDL_AMTFC": 0.0,
        "PAID_MOD1": "",
        "PAID_AMT1": 0,
        "PAID_AMT1FC": 0,
        "PAID_MOD2": "",
        "PAID_AMT2": 0,
        "PAID_AMT2FC": 0,
        "DISC_PERCENT": 0.0,
        "DISC_AMT": 0.0,
        "DISC_AMTFC": 0.0,
        "CHG_CODE": "",
        "CHG_AMT": 0,
        "CHG_AMTFC": 0,
        "EXHDIFF_AMT": 0,
        "NETAMT": reg_amount.value,
        "NETAMTFC": reg_amount.value,
        "PAID_AMT": reg_amount.value,
        "PAID_AMTFC": reg_amount.value,
        "BAL_AMT": 0.0,
        "BAL_AMTFC": 0.0,
        "ADV_AMT": 0.0,
        "AC_AMTFC": 0,
        "AC_AMT": 0,
        "REMARKS": "",
        "REF1": "",
        "REF2": "",
        "REF3": reg_amount.value,
        "REF4": 0.0,
        "REF5": devid,
        "REF6": cardnumber.value,
        "EDIT_USER": commonController.wstrUserCode.value,
        "SHIFNO": "01",
        "GUEST_TEL": "",
        "CARD_TYPE": "",
        "CARDHOLDER_NAME": "",
        "CARD_AC": "",
        "CARD_DETAILS": "",
        "NOOF_PRINT": "",
        "GIFT_VOUCHER_NO": "",
        "GIFT_VOUCHER_AMT": "",
        "GIFT_VOUCHER_AMTFC": "",
        "LOYALTY_CARD_NO": "",
        "VAT_PERC": "",
        "COUNTER_NO": syncDevice.value,  //devid
        "MACHINENAME": syncDevice.value,  //devname
        "DOCUMENT_STATUS": "",
        "TAX_AMT": taxAmount,
        "TAX_AMTFC": taxAmount,
        "TAXABLE_AMT": taxableAmount,
        // netanount -taxamount
        "TAXABLE_AMTFC": taxableAmount

      });
      RSLDET.add({
        "COMPANY": bistroCompany.value,
        "YEARCODE": bistroYearCode.value,
        "SRNO": 1,
        "DUEDATE": "",
        "STKCODE": dishCode.value.toString(),
        "STKDESCP": dishCode.value.toString(),
        "STKBARCODE": "",
        "RETURNED_YN": "",
        "FOC_YN": "",
        "LOC": "",
        "UNIT1": "NOS",
        "QTY1": "1",
        "UNITCF": null,
        "RATE": reg_amount.value,   //regamnt
        "RATEFC": reg_amount.value,
        "GRAMT": reg_amount.value,
        "GRAMTFC": reg_amount.value,
        "DISC_AMT": 0.0,
        "DISC_AMTFC": 0.0,
        "DISCPERCENT": null,
        "AMT": reg_amount.value,
        "AMTFC": reg_amount.value,
        "ADDL_AMT": 0.0,
        "ADDL_AMTFC": 0.0,
        "AC_AMT": "",
        "AC_AMTFC": "",
        "PRVDOCTABLE": "",
        "PRVYEARCODE": "",
        "PRVDOCNO": "",
        "PRVDOCTYPE": "",
        "PRVDOCSRNO": 0,
        "PRVDOCQTY": 0,
        "PRVDOCPENDINGQTY": 0,
        "PENDINGQTY": 0,
        "CLEARED_QTY": 0,
        "REF1": "",
        "REF2": "",
        "REF3": "",
        "EXPIRYDATE": "",
        "AVGCOST": "",
        "AVGCOSTFC": "",
        "LASTCOST": "",
        "LASTCOSTFC": "",
        "HEADER_DISC_AMT": 0.0,
        "HEADER_DISC_AMTFC": 0.0,
        "HEADER_GIFT_VOUCHER_AMT": "",
        "HEADER_GIFT_VOUCHER_AMTFC": "",
        "TOT_TAX_AMT": taxAmount,
        "TOT_TAX_AMTFC": taxAmount,
        "GIFT_VOUCHER_NO": "",
        "GIFT_VOUCHER_AMT": "",
        "GIFT_VOUCHER_AMTFC": "",
        "HEADER_DISC_TAX_AMTFC": "",
        "HEADER_DISC_TAX_AMT": "",
        "RATE_INCLUDE_TAX": "Y",
        "EX_VATAMTFC": "",
        "EX_VATAMT": "",
        "ADVANCE_AMTFC": "",
        "ADVANCE_AMT": "",
        "TAXABLE_AMT":taxableAmount,
        "TAXABLE_AMTFC":taxableAmount,
        "ORDER_TYPE": "TAKEAWAY",
        "ADDON_STKCODE": "",
        "ADDON_SRNO": 0,
        "COUPON_DOCNO": "",
        "COUPON_DOCTYPE": "",
        "COUPON_YEARCODE": "",
        "COUPON_NO": "",
        "COUPON_GROUP": ""
      });
      RETAILPAY.add({
        "COMPANY": bistroCompany.value,
        "SRNO": 1,
        "PAYMODE":initial_payment.value,
        "CURR": "AED",
        "CURRATE": 1,
        "AMT": reg_amount.value,
        "AMTFC": reg_amount.value,
        "CHANGE_AMT": 0.0,
        "CHANGE_AMTFC": 0.0,
        "PRINT_YN": "",
        "POST_YN": "",
        "POSTDATE": "",
        "POST_FLAG": "",
        "AUTH_YN": "",
        "CLOSED_YN": "",
        "CARD_NO": ""
      });



      futureform =  apiRepository.apiSaveInvoice(bistroCompany.value,bistroYearCode.value,bistroToken.value,bistroUrl.value, RSL, RSLDET, RETAILPAY,"ADD",commonController.wstrPrinterPath.value,initial_payment.value);
      futureform.then((value) => fnSaveInvoiceRes(value,totalamount,balance));

      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }
  }
  fnSaveInvoiceRes(val,totalamount,balance){
    dprint("fnSaveInvoiceRes..........");
    dprint(val);
    CommonModel commonModel = CommonModel.fromJson(val[0]);
    if(commonModel.sTATUS=="1"){

      saleDocNumb.value = commonModel.cODE.toString();
      saleDocType.value = commonModel.dOCTYPE.toString();

     fnCardissueUpdateSale(totalamount,balance);


    }
    // dprint(val);
    // fnClearDetails();
  }


  fnCardissueUpdateSale(totalamount,balance)async{
    try{
      dprint("--------------pdateSaleRes...---------------");
      var devid = await  Prefs.getString(AppStrings.deviceId);
      futureform =  apiRepository.apiCardissueUpdateSale(devid, issueDocNumb.value, issueDocType.value, bistroCompany.value, saleDocType.value, saleDocNumb.value);
      futureform.then((value) => fnCardissueUpdateSaleRes(value,totalamount,balance));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }
  fnCardissueUpdateSaleRes(val,totalamount,balance){

    dprint("fnCardissueUpdateSaleRes...---------------");
    dprint(val);
    CommonModel commonModel = CommonModel.fromJson(val[0]);

    if(commonModel.sTATUS=="1"){
      Get.off(SuccessScreen(sldesc: customer_name.value,slcode:sl_code.value,amount: totalamount,transaction_id: issueDocNumb.value ,card_id:cardnumber.value,date: setDate(16,DateTime.now()),printCode: printCode,balance: balance.toString(),));
      if(initial_payment.value.toString() == "Cash"){
        fnOpenDrawer();
      }
    }

     fnClearDetails();
  }

  fnGetCaradStockDetails(){
    try{
      futureform =  apiRepository.apiGetCardStockDet();
      futureform.then((value) => fnGetCaradStockDetailsRes(value));
    }catch(e){
      dprint("fnGetCaradStockDetails ${e.toString()}");
    }
  }
  fnGetCaradStockDetailsRes(val){
    dprint("fnGetCaradStockDetailsRes...................");
     dishCode.value = val[0]["DISHCODE"];
     dishkDesc.value =val[0]["DISHDESCP"];
     dishkVat.value =  mfnDbl(val[0]["VAT"]);
     dprint(dishkVat.value);

  }

  fnOpenDrawer(){
    if(commonController.wstrPrinterPath.value.isEmpty){
      return;
    }
    futureform = apiRepository.apiOpenDrawer(commonController.wstrPrinterPath.value);
  }








}



