

import 'dart:async';
import 'dart:io' show Platform;
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/model/tokenModel.dart';
import 'package:beams_tapp/notification/notification.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/login/views/login_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';

import '../../home/views/home_screen.dart';

class SplashController extends GetxController{

  ApiRepository apiRepository = ApiRepository();
  final CommonController commonController = Get.put(CommonController());
  NotificationService notification = NotificationService();
  late Future <dynamic> futureform;
  var deviceId;
  fnGetPageData()async{
    commonController.wstrPrinterCode.value = await  Prefs.getString(AppStrings.printer_code)??"" ;
    commonController.wstrPrinterName.value = await  Prefs.getString(AppStrings.printer_name)??"" ;
    commonController.wstrPrinterPath.value = await  Prefs.getString(AppStrings.printer_path)??"" ;


  }

  Future fnPhoneDetails()async {
    dprint("fnPhoneDetails................");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      if(kIsWeb){
       debugPrint("WEB Platform.... ${deviceId}");
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

        await Prefs.setString(AppStrings.deviceId,(webBrowserInfo.browserName.name??"").toString());
       //  await Prefs.setString(AppStrings.deviceId,'3453242');
        await Prefs.setString(AppStrings.phonDevice, webBrowserInfo.userAgent!);
        await Prefs.setString(AppStrings.phonmodel, webBrowserInfo.platform!);
        print('Running on ${ webBrowserInfo.platform!}');
        print('Device ${ webBrowserInfo.appName!}');
        print('browserName.. ${ webBrowserInfo.browserName}');
        print('deviceiddddddddddd ${webBrowserInfo.userAgent!}');
      }

      else if (Platform.isAndroid) {
        debugPrint("ANDROID............");
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        dprint('ANDROID ID ${deviceId}');
        dprint('ANDROID device ${androidInfo.device}');
        dprint('ANDROID model ${androidInfo.model}');
        dprint('ANDROID product ${androidInfo.product}');
        dprint('ANDROID manufacturer ${androidInfo.manufacturer}');
        await Prefs.setString(AppStrings.phonmodel, androidInfo.model);
        await Prefs.setString(AppStrings.deviceId, deviceId);
        await Prefs.setString(AppStrings.phonProduct, androidInfo.product);
      }
      else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
        await Prefs.setString(AppStrings.phonmodel, iosInfo.model);
        await Prefs.setString(AppStrings.deviceId, iosInfo.identifierForVendor!);
        await Prefs.setString(AppStrings.phonProduct, iosInfo.utsname.machine);
      }
      else if(Platform.isWindows){
        WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
        // await Prefs.setString(AppStrings.phonmodel, windowsDeviceInfo.computerName??"");
        // await Prefs.setString(AppStrings.deviceId, windowsDeviceInfo.computerName??"");
        // await Prefs.setString(AppStrings.phonProduct, windowsDeviceInfo.computerName??"");
      }

    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }




  }

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
    if(commonController.wstrAcessToken.value.isNotEmpty ){
      Future.delayed(const Duration(seconds:  3), () {
        dprint("ACESSSSS TOKREN  ${commonController.wstrAcessToken.value}");
        Get.offAll(() =>  LoginScreen());


      });
    }else{
      /////toast  connect ypour administartion
    }

  }
  
  





}

