import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../common_widgets/CommonAlertDialog.dart';
import '../../common_widgets/commonToast.dart';
import '../../constants/common_functn.dart';
import '../../constants/enums/toast_type.dart';
import '../../constants/string_constant.dart';
import '../../model/commonModel.dart';
import '../../model/tokenModel.dart';
import '../../servieces/api_repository.dart';
import '../../storage/preference.dart';
import '../../view/commonController.dart';
import '../views/registerQrGenertor.dart';

class WebRegistrtionController extends GetxController{

  late Future <dynamic> futureform;
  ApiRepository apiRepository= ApiRepository();
  final registerformKey = GlobalKey<FormState>();
  List gender = ["Male", "Female", "Other"];
  RxString gender_select = ''.obs;
  RxBool isAvailbleSlcode = false.obs;
  RxString slcode ="".obs;
  final CommonController commonController = Get.put(CommonController());
  RxList registerList = [].obs;
  var deviceId;

  ////=================================================Controller
  final TextEditingController f_name_controller = TextEditingController();
  final TextEditingController mail_controller = TextEditingController();
  final TextEditingController phone_controller = TextEditingController();
  final TextEditingController address_controller = TextEditingController();
  final TextEditingController city_controller = TextEditingController();
  final TextEditingController txtSearch = TextEditingController();

  // Future fnPhoneDetails()async {
  //   dprint("fnPhoneDetails................");
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   try {
  //     deviceId = await PlatformDeviceId.getDeviceId;
  //     if(kIsWeb){
  //       debugPrint("WEB Platform.... ${deviceId}");
  //       WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
  //
  //       await Prefs.setString(AppStrings.deviceId,(webBrowserInfo.browserName.name??"").toString());
  //       //  await Prefs.setString(AppStrings.deviceId,'3453242');
  //       await Prefs.setString(AppStrings.phonDevice, webBrowserInfo.userAgent!);
  //       await Prefs.setString(AppStrings.phonmodel, webBrowserInfo.platform!);
  //       print('Running on ${ webBrowserInfo.platform!}');
  //       print('Device ${ webBrowserInfo.appName!}');
  //       print('browserName.. ${ webBrowserInfo.browserName}');
  //       print('deviceiddddddddddd ${webBrowserInfo.userAgent!}');
  //     }
  //
  //     else if (Platform.isAndroid) {
  //       debugPrint("ANDROID............");
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //
  //       dprint('ANDROID ID ${deviceId}');
  //       dprint('ANDROID device ${androidInfo.device}');
  //       dprint('ANDROID model ${androidInfo.model}');
  //       dprint('ANDROID product ${androidInfo.product}');
  //       dprint('ANDROID manufacturer ${androidInfo.manufacturer}');
  //       await Prefs.setString(AppStrings.phonmodel, androidInfo.model!);
  //       await Prefs.setString(AppStrings.deviceId, deviceId);
  //       await Prefs.setString(AppStrings.phonProduct, androidInfo.product!);
  //     }
  //     else if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //       print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
  //       await Prefs.setString(AppStrings.phonmodel, iosInfo.model!);
  //       await Prefs.setString(AppStrings.deviceId, iosInfo.identifierForVendor!);
  //       await Prefs.setString(AppStrings.phonProduct, iosInfo.utsname.machine!);
  //     }
  //     else if(Platform.isWindows){
  //       WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
  //       // await Prefs.setString(AppStrings.phonmodel, windowsDeviceInfo.computerName??"");
  //       // await Prefs.setString(AppStrings.deviceId, windowsDeviceInfo.computerName??"");
  //       // await Prefs.setString(AppStrings.phonProduct, windowsDeviceInfo.computerName??"");
  //     }
  //
  //   } on PlatformException {
  //     deviceId = 'Failed to get deviceId.';
  //   }
  //
  //
  //
  //
  // }

  fnGettoken(){
    dprint("token function");
    try{
      futureform =  apiRepository.apiGetToken();
      futureform.then((value) => fnGetTokenRes(value));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }

  fnGetTokenRes(val){
    TokenModel tokenModel = TokenModel.fromJson(val);
    commonController.wstrAcessToken.value = tokenModel.accessToken.toString();
    // if(commonController.wstrAcessToken.value.isNotEmpty ){
    //   // Future.delayed(const Duration(seconds:  3), () {
    //   //   dprint("ACESSSSS TOKREN  ${commonController.wstrAcessToken.value}");
    //   //   Get.offAll(() =>  LoginScreen());
    //   //
    //   //
    //   // });
    // }else{
    //   /////toast  connect ypour administartion
    // }

  }

  fnClear(){
    f_name_controller.clear();
    mail_controller.clear();
    phone_controller.clear();
    address_controller.clear();
    city_controller.clear();
    isAvailbleSlcode.value=false;
    commonController.selectcountry.value="+971";
    gender_select.value="";
    slcode.value='';
  }



  fnGettoken1(genderval,dob){
    dprint("token function");
    try{
      futureform =  apiRepository.apiGetToken();
      futureform.then((value) => fnGetTokenRes1(value,genderval,dob));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }

  fnGetTokenRes1(val,genderval,dob){
    TokenModel tokenModel = TokenModel.fromJson(val);
    commonController.wstrAcessToken.value = tokenModel.accessToken.toString();
    apiReg(genderval,dob);
  }


  apiRegister(String ? genderval,DateTime dob) async {

    if (registerformKey.currentState!.validate()) {
      fnGettoken1(genderval,dob);
    }else{
      dprint("Not vlidateee");
    }
  }

  apiReg(String ? genderval,DateTime dob) async{
    var gend, dateofbirth;
    try {
      dateofbirth = DateFormat('yyyy-MM-dd').format(dob);
      dprint("DOOOBB ${dateofbirth}");
      if (genderval == "Male") {
        gend = "M";
      } else if (genderval == "Female") {
        gend = "F";
      } else if (genderval == "Other") {
        gend = "O";
      }

      final responseJson = await apiRepository.apiRegistration(
          slcode.value,
          f_name_controller.text,
          mail_controller.text,
          phone_controller.text,
          dateofbirth,
          gend,
          address_controller.text,
          city_controller.text="",
          commonController.selectcountry.value);
      dprint("regisretionnn ${responseJson[0]}");
      CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
      if (commonModel.sTATUS == "1") {
        dprint("SLCODE....... ${commonModel.cODE.toString()}");
        Get.to(RegisterQrGenerator(slcode:commonModel.cODE.toString() ,name: f_name_controller.text.toString(),mobile: phone_controller.text.toString(),));
        fnClear();
      } else {
        CustomToast.showToast(commonModel.mSG.toString(), ToastType.error, ToastPositionType.end);
      }
    } catch (e) {
      dprint("!!!!!!!!!!!!!  >>  " + e.toString());
      CustomToast.showToast(e.toString(), ToastType.error, ToastPositionType.end);
    }
  }



}