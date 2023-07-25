 
  
import 'package:beams_tapp/constants/dateformates.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/card_detailModel.dart';
   
     
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

class RenewController extends GetxController{
 ApiRepository apiRepository =ApiRepository();
  RxBool card_show = false.obs;
  RxBool isTaped = true.obs;
  RxBool isAvailable = false.obs ;
  RxString cardnumb=''.obs;
  RxString initial_payment = 'Cash'.obs;
  RxDouble renewCharge =0.0.obs;
 String printCode  ='RENW';
 RxString customer_name=''.obs;
 RxString sl_code=''.obs;
 RxString customer_email=''.obs;
 RxString customer_dob=''.obs;
 RxString customer_mobile=''.obs;
 RxString customer_city=''.obs;
 RxBool showCardDetails=false.obs;


  var paymnet_method = [
    'Cash',
    'Card',
    'Other',
    'Foc',
  ];

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
  fnOnChangePayment(val){
    initial_payment.value = val;
  }
  void fnTagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');

        dprint("identifierddff  ${serialnumb}");
        // commonController.Cardserial_number.value = serialnumb!;
        cardnumb.value = serialnumb!;
        if(serialnumb != null){
          ///Payment Enabled
          card_show.value = true;
          fnCardDetails(serialnumb,"N");
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

  fnResetCard(context){
    isTaped.value=true;
    card_show.value =false;
    showCardDetails.value =false;
    // initial_payment.value ='Cash';
    cardnumb.value="";

  }

  fnCardDetails(cardnumb,histrymode)async{
    dprint("!! cardnumb "+cardnumb.toString());
    var devid = await  Prefs.getString(AppStrings.deviceId);
    dprint("DEVICE IDDD ${devid}");
    try{
      final responseJson = await apiRepository.apiCardDetails(cardnumb,devid,histrymode);
      dprint(responseJson.toString());
      CardDetailsModel cardDetailsModel = CardDetailsModel.fromJson(responseJson);
      if(cardDetailsModel.sTATUS=="1"){
        showCardDetails.value = true;
        customer_name.value = cardDetailsModel.dATA![0].sLDESCP!;
        customer_email.value =cardDetailsModel.dATA![0].eMAIL!;
        customer_mobile.value =cardDetailsModel.dATA![0].mOBILE!;
        sl_code.value =cardDetailsModel.dATA![0].sLCODE!;

        update();
      }else {
        showCardDetails.value = false;
        card_show.value =false;
        CustomToast.showToast(
            cardDetailsModel.mSG.toString(), ToastType.error, ToastPositionType.end);
        fnTagRead();

      }



      //   DateTime dob = DateTime.parse(customerDetailsModel.dOB.toString());
      //  print(dob); // 2020-01-02 03:04:05.000


    }catch(e){
      // cstmrdetailLoading.value = false;
      // CustomToast.showToast(
      //     e.toString(), ToastType.error, ToastPositionType.end);
      dprint("!! @@@@::>> "+e.toString());
    }


  }

  fnRenewCard(renewCharge,context)async{
    var devid = await  Prefs.getString(AppStrings.deviceId);
    try{
      final responseJson = await apiRepository.apiCardRenew(devid,renewCharge,cardnumb.value, initial_payment.value);
      CommonModel commonModel =CommonModel.fromJson(responseJson[0]);
      if(commonModel.sTATUS=="1"){
        CustomToast.showToast(
            "Card Renewed", ToastType.success,
            ToastPositionType.end);
        // fnClearDetails();
        Get.off(SuccessScreen(sldesc:customer_name.value,slcode: sl_code.value ,amount: renewCharge,transaction_id: commonModel.cODE,printCode: printCode,card_id:cardnumb.value,date: setDate(16,DateTime.now())));
        fnResetCard(context);
      }else if(commonModel.sTATUS=="0"){
        dprint("Clear Car..d details ");



        CustomToast.showToast(
            commonModel.mSG.toString(), ToastType.error,
            ToastPositionType.end);
        fnResetCard(context);
      }

    }catch(e){
      // cstmrdetailLoading.value = false;
      // CustomToast.showToast(
      //     e.toString(), ToastType.error, ToastPositionType.end);
      dprint("!&*&&:>> "+e.toString());
    }

  }

   fnRenewAmount()async{
   // reg_amount
   dprint("renew amouvvvnt");
   try{
     final responseJson = await apiRepository.apiRenewAmount();
     print("eeee "+responseJson.toString());
     var res= responseJson[0];
     renewCharge.value = res["RENEW_CHARGE"];
   }catch(e){
     dprint(e);
   }


 }


}