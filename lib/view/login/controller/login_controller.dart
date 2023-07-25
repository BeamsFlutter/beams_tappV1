 
  
  
import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/constants/string_constant.dart';
   
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/model/userloginModel.dart';
import 'package:beams_tapp/notification/notification.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/device%20_register_screen.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';

class LoginController extends GetxController{

  final CommonController commonController = Get.put(CommonController());
  NotificationService notification = NotificationService();
  ApiRepository apiRepository = ApiRepository();
  RxString p1=''.obs;
  RxString p2=''.obs;
  RxString p3=''.obs;
  RxString p4=''.obs;

  RxBool isLogin = false.obs;


  //

  fnNumberPress(String val){
    debugPrint("inFunction ${val}");
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

      fnLogin(code,commonController.wNotificationDataModel.value);


      // Get.offAll(() => HomeScreen());
    }
    update();
  }

  void fnLogin(code,notificationDataModel)async {
    try{

      var devid = await  Prefs.getString(AppStrings.deviceId);
      var devname= await  Prefs.getString(AppStrings.phonmodel);
      final responseJson = await apiRepository.apiUserLogin(code,devid);
      dprint(responseJson.toString());
      UserLoginModel userLoginModel = UserLoginModel.fromJson(responseJson);
      if(userLoginModel.sTATUS == "1"){
        dprint("!!!!  ${ commonController.mfnNullable(commonController.wstrCompanyName.value, userLoginModel.dATA!.cOMPANYDESCP.toString()) }");
       await Prefs.setString(AppStrings.phonmodel, (userLoginModel.dATA!.deviceName ??"").toString().isEmpty?devname.toString() : userLoginModel.dATA!.deviceName.toString());



        commonController.wstrCompanyName.value = userLoginModel.dATA!.cOMPANYDESCP.toString();
        commonController.wstrCompanyCode.value = userLoginModel.dATA!.cOMPANY.toString();
        commonController.wstrUserName.value = userLoginModel.dATA!.uSERNAME.toString();
        commonController.wstrUserCode.value = userLoginModel.dATA!.uSERCD.toString();
        commonController.wstrRoleCode.value = userLoginModel.dATA!.rOLECODE.toString();
       // fnCheckDevice(commonController.wstrCompanyCode.value,notificationDataModel);



        CustomToast.showToast(
            "Login Successfully", ToastType.success, ToastPositionType.end);
        Get.offAll(() => HomeScreen(notificationDataModel: commonController.wNotificationDataModel.value,));
      }else{
        // isLogin.value = true;
        // fnClearAll();
        // CustomToast.showToast(
        //     'Login Failed', ToastType.error, ToastPositionType.end);
      }
    }catch(e){
      fnClearAll();
      CustomToast.showToast(
          e.toString(), ToastType.error, ToastPositionType.end);
      dprint("^6666666 "+e.toString());
    }
  }


  fnCheckDevice(company,notificationDataModel)async{
    dprint("Compannnnyy   ${company}");
    try{
      var devid = await  Prefs.getString(AppStrings.deviceId);
      var devName= await  Prefs.getString(AppStrings.phonmodel);
      String? fcmToken = await notification.getFcmToken();
      final responseJson = await apiRepository.apiCheckDevice(devid,company,fcmToken);
      CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
      if(commonModel.sTATUS=="1"){
        Get.offAll(() => HomeScreen(notificationDataModel: notificationDataModel,));
      } else{
        isLogin.value = true;
        fnClearAll();
        CustomToast.showToast(
            commonModel.mSG.toString(), ToastType.success, ToastPositionType.end);
        Get.to(() =>  DeviceRegScreen(deviceName: devName, deviceId: devid,companyCode:company ,));

      }
      dprint("reeeeeeeess ${responseJson}");

    }catch(e){
      dprint(e.toString());
    }
  }


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
  // fnTakeAmount(String val){
  //   amountController.text=val;
  //
  // }

}

