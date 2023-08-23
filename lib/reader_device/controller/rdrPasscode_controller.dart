import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/reader_device/controller/rdrCounterPage_controller.dart';
import 'package:beams_tapp/reader_device/pages/rdrCounterPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/string_constant.dart';
import '../../storage/preference.dart';
import '../pages/rdrDevice_ScanScreen.dart';

class ReaderPasscodeController extends GetxController{
  final ReaderCounterController readerCounterController = Get.put(ReaderCounterController());
  RxString p1=''.obs;
  RxString p2=''.obs;
  RxString p3=''.obs;
  RxString p4=''.obs;
  RxString sitecode=''.obs;

  RxBool isLogin = false.obs;
  fnBackspace(){
    if(p1.isEmpty){
      return;
    }

    if(p4.isNotEmpty){
      p4.value = "";
    }else if(p3.isNotEmpty){
      p3.value = "";
    }else if(p2.isNotEmpty){
      p2.value = "";
    }else if(p1.isNotEmpty){
      p1.value = "";
    }
  }
  fnClearAll(){
    // isLogin.value=false;
    p1.value = "";
    p2.value = "";
    p3.value = "";
    p4.value = "";
  }
  fnNumberPress(String val)async{
   dprint(val);
    if(p4.isNotEmpty){
      // fnClearAll();
      return;
    }
    if(p1.isEmpty){
      p1.value = val;
    }else if(p2.isEmpty){
      p2.value = val;
    }else if(p3.isEmpty){
      p3.value = val;
    }else if(p4.isEmpty){
      p4.value= val;
      //login api call
      dprint("Call login Api");
      var code = p1.value+p2.value+p3.value+p4.value;
      dprint(code);
      dprint("token function");

      // fnLogin(code,commonController.wNotificationDataModel.value);
      p1.value='';
      p2.value='';
      p3.value='';
      p4.value='';

      var sessionSiteCode = await  Prefs.getString(AppStrings.rdr_siteCode);

     Get.to(() =>
         ReadrCounterScreen(pr_counterslIst:readerCounterController.lstr_counterList[0],)

         // ReadrCounterScreen(
         //   title: "KIDS TRAIN",
         //   activeGuestCount: 34,
         //   price: 23.4,
         //   bgColor: Colors.yellow,
         //   counterName: "DEIRA CITY CENTER",
         //   countyercode: (sessionSiteCode??"").toString(),
         //   imageUrl: "https://clipart-library.com/images/8ixK8bzBT.png",
         //   sitecode: "DDA12",
         //
         //
         // )

     );
    }
    update();
  }

  fnCheckSessionData()async{
    var sessionSiteCode = await  Prefs.getString(AppStrings.rdr_siteCode);
    dprint("Sitecode>>>>> ${sessionSiteCode}");
    sitecode.value = sessionSiteCode??"";
    dprint(sitecode.value);

  }
  }
