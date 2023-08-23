import 'package:beams_tapp/ticket_pos/pages/ticket_HomeScreen.dart';
import 'package:get/get.dart';

import '../../constants/common_functn.dart';
import '../../storage/preference.dart';

class TicketLoginController extends GetxController{


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
      Get.to(() =>TicketHomeScreen());
      // fnLogin(code,commonController.wNotificationDataModel.value);
      p1.value='';
      p2.value='';
      p3.value='';
      p4.value='';

      // var sessionSiteCode = await  Prefs.getString(AppStrings.rdr_siteCode);
      //
      // Get.to(() =>
      //     ReadrCounterScreen(pr_counterslIst:readerCounterController.lstr_counterList[0],)




    }
    update();
  }



  // fnCheckSessionData()async{
  //   var sessionSiteCode = await  Prefs.getString(AppStrings.rdr_siteCode);
  //   dprint("Sitecode>>>>> ${sessionSiteCode}");
  //   sitecode.value = sessionSiteCode??"";
  //   dprint(sitecode.value);
  //
  // }

}