
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/commonToast.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../model/commonModel.dart';
import '../../../../servieces/api_repository.dart';

class AdminSettingsController extends GetxController{


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
      regAmount_controller.text = mfnDbl(responseJson[0]["REG_AMOUNT"]).toStringAsFixed(2);
      renewCharge_controller.text = mfnDbl(responseJson[0]["RENEW_CHARGE"]).toStringAsFixed(2);
      duplicateCharge_controller.text = mfnDbl(responseJson[0]["DUPLICATE_CHARGE"]).toStringAsFixed(2);


    }catch(e){
      dprint("@error@  ${e.toString()}");
    }

  }


}