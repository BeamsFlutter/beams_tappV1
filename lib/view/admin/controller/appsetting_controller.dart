import 'dart:convert';

import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingController extends GetxController{


  final TextEditingController cardExpDays_controller = TextEditingController();
  final TextEditingController regAmount_controller = TextEditingController();
  final TextEditingController renewCharge_controller = TextEditingController();
  final TextEditingController duplicateCharge_controller = TextEditingController();
  ApiRepository apiRepository = ApiRepository();
  final settingformKey = GlobalKey<FormState>();


  fnUpdateAppSettings()async {
    if (settingformKey.currentState!.validate()) {
      try {
        final responseJson = await apiRepository.apiAppSettings(
            cardExpDays_controller.text, regAmount_controller.text,
            renewCharge_controller.text, duplicateCharge_controller.text);
        dprint(responseJson);
        CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
        if (commonModel.sTATUS == "1") {
          CustomToast.showToast("Successfully Updated", ToastType.success,
              ToastPositionType.end);
          fnInitialAppsettingData();


        } else {
          CustomToast.showToast(commonModel.mSG.toString(), ToastType.success,
              ToastPositionType.end);
        }
      } catch (e) {
        dprint("@error@  ${e.toString()}");
      }
    }
  }

  fnInitialAppsettingData()async{
    try{
      final responseJson = await apiRepository.apiInitialAppSetting();
      dprint(responseJson);
      cardExpDays_controller.text = mfnInt(responseJson[0]["CARD_EXP_DAYS"]).toString();
      regAmount_controller.text = mfnDbl(responseJson[0]["REG_AMOUNT"]).toString();
      renewCharge_controller.text = mfnDbl(responseJson[0]["RENEW_CHARGE"]).toString();
      duplicateCharge_controller.text = mfnDbl(responseJson[0]["DUPLICATE_CHARGE"]).toString();


    }catch(e){
      dprint("@error@  ${e.toString()}");
    }

  }


}