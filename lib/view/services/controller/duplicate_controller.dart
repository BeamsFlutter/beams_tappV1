 
  
import 'package:beams_tapp/constants/dateformates.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/card_detailModel.dart';
import 'package:beams_tapp/notification/notification.dart';
   
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';

class DuplicateController extends GetxController{
  ApiRepository apiRepository =ApiRepository();
  late Future <dynamic> futureform;
  RxBool old_card_show = false.obs;
  RxBool new_card_show = false.obs;

  RxBool isOldCardAvailable = false.obs ;
  RxBool isNewCardAvailable = false.obs ;
  RxString old_cardnumb=''.obs;
  RxString new_cardnumb=''.obs;

  RxString initial_payment = 'Cash'.obs;
  RxDouble servieceCharge =0.0.obs;
  RxBool showCardDetails=false.obs;

  RxString customer_name=''.obs;
  RxString sl_code=''.obs;
  RxString customer_email=''.obs;
  RxString customer_dob=''.obs;
  RxString customer_mobile=''.obs;
  RxDouble customer_remaingblnce=0.0.obs;
  RxBool newCardenable =false.obs;
  String printCode  ='DUPL';

  RxBool isOldCradTaped = true.obs;
  RxBool isNewCardCradTaped = true.obs;


  //rsl save
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
  fnTaped(context,mode)async{
    if(mode=="O"){
      fnCheckNFCAvailability(context,mode);
      isOldCradTaped.value = false;
    }else{
      fnCheckNFCAvailability(context,mode);
      isNewCardCradTaped.value = false;
    }
    print("moooode ${mode}");


    }



  Future fnCheckNFCAvailability(context,mode) async {
    // Check availability
    if(mode=="O"){
      isOldCardAvailable.value = await NfcManager.instance.isAvailable();
      dprint("Oldd AVAILABLE  ${isOldCardAvailable.value}");
    }else{
      isNewCardAvailable.value = await NfcManager.instance.isAvailable();
      dprint("Newww AVAILABLE  ${isOldCardAvailable.value}");
    }
    if(isOldCardAvailable.value==true || isNewCardAvailable.value==true){
      dprint("hold..............");
      fnTagRead(mode);
    }
  }
  ValueNotifier<dynamic> result = ValueNotifier(null);
  fnOnChangePayment(val){
    initial_payment.value = val;
  }
  void fnTagRead(mode) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');
        dprint("identifierddff  ${serialnumb}");
        if(mode=="O"){
          old_cardnumb.value = serialnumb!;
        }else{
          new_cardnumb.value =serialnumb!;
        }

        // commonController.Cardserial_number.value = serialnumb!;

        if(serialnumb != null){
          ///Payment Enabled
          dprint("mmmmooo ${mode}");
          if(mode=="O"){
            old_card_show.value = true;
            fnCardDetails(serialnumb,"N",mode);
          }else{
            new_card_show.value = true;
          }

          await NfcManager.instance.stopSession();
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

  fnResetOldCard(context){
    isOldCradTaped.value=true;
    old_card_show.value =false;
    showCardDetails.value =false;

    // initial_payment.value ='Cash';
    old_cardnumb.value="";

  }
  fnResetNewCard(context){
    isNewCardCradTaped.value=true;
    new_card_show.value =false;

    // initial_payment.value ='Cash';
    new_cardnumb.value="";

  }

  fnCardDetails(cardnumb,histrymode,mode)async{
    dprint("!! cardnumb "+cardnumb.toString());
    var devid = await  Prefs.getString(AppStrings.deviceId);
    dprint("DEVICE IDDD ${devid}");
    try{
      final responseJson = await apiRepository.apiCardDetails(cardnumb,devid,histrymode);
      dprint(responseJson.toString());
      CardDetailsModel cardDetailsModel = CardDetailsModel.fromJson(responseJson);
      if(mode=="O"){
        if(cardDetailsModel.sTATUS=="1" ){
          showCardDetails.value = true;
          isOldCradTaped.value = true;
          isNewCardCradTaped.value = true;
          newCardenable.value =true;
          customer_name.value = cardDetailsModel.dATA![0].sLDESCP!;
          customer_email.value =cardDetailsModel.dATA![0].eMAIL!;
          customer_mobile.value =cardDetailsModel.dATA![0].mOBILE!;
          customer_remaingblnce.value = mfnDbl(cardDetailsModel.dATA![0].aMOUNT!);
          sl_code.value = cardDetailsModel.dATA![0].sLCODE!;
          update();


        }
        else if(cardDetailsModel.sTATUS=="0"){
          showCardDetails.value = false;
          old_card_show.value =false;
          fnTagRead(mode);
          CustomToast.showToast(
              cardDetailsModel.mSG.toString(), ToastType.error, ToastPositionType.end);
          // fnTagRead("N");
        }

      }



      else{

        // fnTagRead("N");
        CustomToast.showToast(
            cardDetailsModel.mSG.toString(), ToastType.error, ToastPositionType.end);
      }



    }catch(e){
      // cstmrdetailLoading.value = false;
      // CustomToast.showToast(
      //     e.toString(), ToastType.error, ToastPositionType.end);
      dprint("!! @@@@::>> "+e.toString());
    }


  }

  fnDuplicate(slcode,cardnumb)async{
      if (slcode!=null){
        try{
          var devid = await  Prefs.getString(AppStrings.deviceId);
          dprint("DEVICE IDDD ${devid}");
        //  var totalamount=int.parse(topup)+regcharge;
       //   dprint("TotalAmount ${totalamount}");
          final responseJson = await apiRepository.apiCardDuplicate(customer_remaingblnce.value, servieceCharge.value, initial_payment.value, cardnumb,slcode, devid,old_cardnumb.value);
          CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
          if(commonModel.sTATUS=="1"){
            CustomToast.showToast(
                commonModel.mSG.toString(), ToastType.success,
                ToastPositionType.end);

            issueDocNumb.value = commonModel.cODE.toString();
            issueDocType.value = commonModel.dOCTYPE.toString();

            fnGetbistro(servieceCharge.value);
            //Get.off(()=>(SuccessScreen(slcode:slcode,sldesc:customer_name.value,amount: servieceCharge.value,transaction_id: commonModel.cODE.toString(),printCode: printCode,card_id:new_cardnumb.value,date: setDate(16,DateTime.now()))));
          }else if(commonModel.sTATUS=="0"){
            dprint("Clear Car..d details ");
            CustomToast.showToast(
                commonModel.mSG.toString(), ToastType.success,
                ToastPositionType.end);
          }
        }catch(e){
          dprint("EEEEEE  ${e.toString()}");
        }
      }
    }

  fnGetbistro(totalamount)async {

    dprint("bistroooooooooooo...........");
    try{
      futureform =  apiRepository.apiGetbistro();
      futureform.then((value) => fnGetBistroRes(value,totalamount));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }
  fnGetBistroRes(value,totalamount) {
    dprint("bistroooo ${value}");
    dprint(value);
    bistroUrl.value = value["BISTRO_URL"];
    bistroCompany.value = value["BISTRO_COMPANY"];
    bistroYearCode.value = value["BISTRO_YEARCODE"];
    bistroToken.value = value["BISTRO_TOKEN"];
    dprint(bistroUrl.value);
    dprint("BISTROOOO TOKENN :>>>${ bistroToken.value}");
    fnSaveInvoice(totalamount);


    // try{
    //   futureform =  apiRepository.apiGetBistroToken(bistroUrl.value);
    //   futureform.then((value) => fnGetBistroTokenRes(value));
    //   // dprint("Token :: > "+commonController.acessToken.value);
    // }catch(e){
    //   dprint(e.toString());
    // }

  }

  fnSaveInvoice(totalamount)async {
    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);
    try{
      var RSL = [];
      var RSLDET = [];
      var RETAILPAY = [];
      var taxableAmount=0.0;
      var taxAmount=0.0;
      var netTotal = servieceCharge.value;

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
        "GRAMT": servieceCharge.value,//  Registration amount
        "GRAMTFC":  servieceCharge.value,
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
        "NETAMT": servieceCharge.value,
        "NETAMTFC": servieceCharge.value,
        "PAID_AMT": servieceCharge.value,
        "PAID_AMTFC": servieceCharge.value,
        "BAL_AMT": 0.0,
        "BAL_AMTFC": 0.0,
        "ADV_AMT": 0.0,
        "AC_AMTFC": 0,
        "AC_AMT": 0,
        "REMARKS": "",
        "REF1": "",
        "REF2": "",
        "REF3": servieceCharge.value,
        "REF4": 0.0,
        "REF5": devid,
        "REF6": servieceCharge.value,
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
        "RATE": servieceCharge.value,   //regamnt
        "RATEFC": servieceCharge.value,
        "GRAMT": servieceCharge.value,
        "GRAMTFC": servieceCharge.value,
        "DISC_AMT": 0.0,
        "DISC_AMTFC": 0.0,
        "DISCPERCENT": null,
        "AMT": servieceCharge.value,
        "AMTFC": servieceCharge.value,
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
        "AMT": servieceCharge.value,
        "AMTFC": servieceCharge.value,
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
      futureform.then((value) => fnSaveInvoiceRes(value,totalamount));

      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }
  }
  fnSaveInvoiceRes(val,totalamount){
    dprint("fnSaveInvoiceRes..........");
    dprint(val);
    CommonModel commonModel = CommonModel.fromJson(val[0]);
    if(commonModel.sTATUS=="1"){

      saleDocNumb.value = commonModel.cODE.toString();
      saleDocType.value = commonModel.dOCTYPE.toString();

      fnCardissueUpdateSale(totalamount);


    }
    // dprint(val);
    // fnClearDetails();
  }

  fnCardissueUpdateSale(totalamount)async{
    try{
      dprint("--------------pdateSaleRes...---------------");
      var devid = await  Prefs.getString(AppStrings.deviceId);
      futureform =  apiRepository.apiCardissueUpdateSale(devid, issueDocNumb.value, issueDocType.value, bistroCompany.value, saleDocType.value, saleDocNumb.value);
      futureform.then((value) => fnCardissueUpdateSaleRes(value,totalamount));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }
  fnCardissueUpdateSaleRes(val,totalamount){

    dprint("fnCardissueUpdateSaleRes...---------------");
    dprint(val);
    CommonModel commonModel = CommonModel.fromJson(val[0]);

    if(commonModel.sTATUS=="1"){
      Get.off(SuccessScreen(sldesc: customer_name.value,slcode:sl_code.value,amount: totalamount,transaction_id: issueDocNumb.value ,card_id:new_cardnumb.value,date: setDate(16,DateTime.now()),printCode: printCode,));

    }

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

  fnServieceCharge()async{
    // reg_amount
    dprint("serviece amouvvvnt");
    final responseJson = await apiRepository.apiServieceCharge();
    var res= responseJson[0];
    servieceCharge.value = res["DUPLICATE_CHARGE"];
    fnGetCaradStockDetails();
  }
  }

