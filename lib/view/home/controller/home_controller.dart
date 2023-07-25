
import 'dart:typed_data';
import 'package:beams_tapp/common_widgets/notificaationPopup.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/view/card_issue/controller/cardissue_controller.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/recharge/views/recharge_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class HomeController extends GetxController{


  final CommonController commonController = Get.put(CommonController());



  // String phonemodel='';
  final TextEditingController search_controller = TextEditingController();
  RxBool isTaped = true.obs;
  RxBool isAvailable = false.obs ;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  fnOpenDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  fnCloseDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }


  //
  // fnGetPhoneDetails() async{
  //   // isLoading.value = true;
  //   // phonemodel = (await  Prefs.getString(AppStrings.phonmodel))!;
  //   // dprint("phonemodel :::>>>   ${phonemodel}");
  //
  // }

  fnNotificationPopup(NotificationDataModel notificationDataModel){
    if(notificationDataModel.transactionid!.isNotEmpty){
      Future.delayed(Duration(seconds: 2),(){
        wDisplayDialog(notificationDataModel.dateTime, notificationDataModel.amount, notificationDataModel.transactionid,notificationDataModel.expiryDate,notificationDataModel.doctype);
      });
    }
  }


  Future fnCheckNFCAvailability(context) async {
    // Check availability
    isAvailable.value = await NfcManager.instance.isAvailable();
    dprint("AVAILABLE  ${isAvailable.value}");
    if(isAvailable.value){
      dprint("hold..............");
      // ///Payment Enabled
      // cardIssueController.payment_enable.value = true;
      fnTagRead();
    }
  }

  fnTaped(context)async{
    fnCheckNFCAvailability(context);
    isTaped.value = false;
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

        dprint("identifierd_homeee ${serialnumb}");

        if(serialnumb != null){

          Get.to(()=>RechargeScreen(cardserailnumb:serialnumb,));
          isTaped.value =true;
          await NfcManager.instance.stopSession();
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

}


