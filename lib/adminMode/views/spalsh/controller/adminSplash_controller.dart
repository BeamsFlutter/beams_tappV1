
import 'package:get/get.dart';

import '../../../../constants/common_functn.dart';
import '../../../../constants/string_constant.dart';
import '../../../../model/tokenModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../storage/preference.dart';
import '../../../../view/commonController.dart';
import '../../login/view/adminlogin_screen.dart';

class AdminSplashController extends GetxController{

  ApiRepository apiRepository = ApiRepository();
  late Future <dynamic> futureform;
  final CommonController commonController = Get.put(CommonController());

  fnGettoken(){
    dprint("token function.......admin");
    try{
      futureform =   apiRepository.apiGetToken();
      futureform.then((value) => fnGetTokenRes(value));

      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }

  fnGetTokenRes(val){
    dprint("############################ ${val}");
    dprint(val);
    TokenModel tokenModel = TokenModel.fromJson(val);
    commonController.wstrAcessToken.value = tokenModel.accessToken.toString();
    if(commonController.wstrAcessToken.value.isNotEmpty ){

      Future.delayed(const Duration(seconds:  3), () {
        dprint("ACESSSSS TOCKEN  ${commonController.wstrAcessToken.value}");
        Get.off(() =>  const AdminLoginScreen());
      });

    }else{
      /////toast  connect ypour administartion
    }

  }

  fnGetPageData()async{
    commonController.wstrPrinterCode.value = await  Prefs.getString(AppStrings.printer_code)??"" ;
    commonController.wstrPrinterName.value = await  Prefs.getString(AppStrings.printer_name)??"" ;
    commonController.wstrPrinterPath.value = await  Prefs.getString(AppStrings.printer_path)??"" ;


  }

}