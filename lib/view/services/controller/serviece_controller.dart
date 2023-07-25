

import 'dart:typed_data';

 
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
   
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';

class ServieceController extends GetxController{

  final txtAmount = TextEditingController();
  RxBool isTaped = true.obs;
  RxBool payBtnPress = false.obs;
  RxBool isAvailable = false.obs ;
  String printCode  ='SALE';
  final CommonController commonController = Get.put(CommonController());
  ApiRepository apiRepository =ApiRepository();
  var doctype ="CSAL";
  var totalamount = 0.0.obs;

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
      fnTagRead(context);
    }
  }
  ValueNotifier<dynamic> result = ValueNotifier(null);

  void fnTagRead(context) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');

        dprint("identifierddff  ${serialnumb}");
        // commonController.Cardserial_number.value = serialnumb!;
        if(serialnumb != null){
          dprint("CARD rEADDDD");
          fnAmounttoPay(serialnumb,context);




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

  fnPayButton(context,netamount){
    dprint(netamount);
    payBtnPress.value = true;
    dprint("Ontap PaY  ${payBtnPress.value}");

    totalamount.value = netamount;
    dprint("TOTALAMOUNTTTTTT  ${totalamount.value}");
    fnTaped(context);
    //  Get.off(SuccessScreen(amount: amount,card_id: "cardid...",transaction_id: "tranid....",date:  setDate(16,DateTime.now()),));
  }



  fnAmounttoPay(cardnumb,context)async{
    var devid = await  Prefs.getString(AppStrings.deviceId);
    try{
      var COUNTER_SALHEAD =[];
      var COUNTER_SALDET =[];
      COUNTER_SALDET.add(
        {
          "DOCTYPE" : doctype,
          "SRNO" : 1,
          "DOCDATE" : setDate(2, DateTime.now()),
          "ITEM_CODE" : "GEN",
          "ITEM_DESCP" : "GEN",
          "QTY" : 1,
          "PRICE" : totalamount.value,
          "AMT" : totalamount.value,
        },

      );

      COUNTER_SALHEAD.add({
        "DOCNO" : "",
        "DOCTYPE" : doctype,
        "BRNCODE" : "",
        "DOCDATE" : setDate(2, DateTime.now()),
        "CARDNO" : cardnumb,
        "NETAMT" :totalamount.value,
        "CREATE_USER" : commonController.wstrUserCode.value.toString(),
        "CREATE_DATE" : setDate(2, DateTime.now()),
        "CREATE_DEVICE" :devid
      }
      );


      final responseJson = await apiRepository.apiAmounttoPay(devid,COUNTER_SALHEAD,COUNTER_SALDET);
      CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
      dprint("RES>>DDD>> ${responseJson[0]}");
      if (commonModel.sTATUS == "1") {
        CustomToast.showToast(
            commonModel.mSG.toString(), ToastType.success,
            ToastPositionType.end);
        Get.off( SuccessScreen(sldesc:"",slcode: "",amount: txtAmount.text, transaction_id: commonModel.cODE.toString(), card_id: cardnumb, printCode: printCode,date: setDate(6, DateTime.now())));
        txtAmount.clear();
        payBtnPress.value=false;


      } else {
        showDialog(
            context: context,
            builder: (context) =>  AlertDialog(
              title: tcnw("Alert!", AppColors.fontcolor, 18,TextAlign.start,FontWeight.w500),
              content: tcnw( commonModel.mSG.toString(),AppColors.fontcolor,12,TextAlign.start,FontWeight.w500),
              actions: [
                TextButton(
                  onPressed: () {
                    fnTagRead(context);
                    // fnPayButton(context,totalamount.value);
                    Get.back();

                  },
                  child: tc("Retry",AppColors.primarycolor,13),
                ),

              ],
            ));
        CustomToast.showToast(
            commonModel.mSG.toString(), ToastType.success,
            ToastPositionType.end);


      }
    } catch (e) {
      dprint("!!!!!!!!!!!!!  >>  " + e.toString());

    }

  }





}