import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_PasscodeScreen.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_ScanScreen.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:get/get.dart';

import '../../constants/string_constant.dart';
import '../../storage/preference.dart';

class ReaderSplashController extends GetxController{

  final CommonController commonController = Get.put(CommonController());
  var sitecode="".obs;


  fnCheckSessionData()async{
    var sessionSiteCode = await  Prefs.getString(AppStrings.rdr_siteCode);
    dprint("Sitecode>>>>> ${sessionSiteCode}");
    sitecode.value = sessionSiteCode??"";
    commonController.wstrSiteCode.value = sitecode.value;
    dprint(sitecode.value);
    if(sitecode.value.isEmpty){
      Future.delayed(const Duration(
          seconds: 2
      ),
              () =>  Get.to(()=>const ReadrQrScanScreen())
      );

    }else{

      Future.delayed(const Duration(
          seconds: 2
      ),
              () =>  Get.to(()=>const ReadrPasscodeScreen())
      );
    }

  }
}