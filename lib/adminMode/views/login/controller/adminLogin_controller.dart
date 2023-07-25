
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/commonToast.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../model/userloginModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../view/commonController.dart';
import '../../home/view/adminHome_screen.dart';

class AdminLoginController extends GetxController{
  late Future <dynamic> futureform;
  ApiRepository apiRepository= ApiRepository();
  final loginformKey = GlobalKey<FormState>();
  final CommonController commonController =Get.put(CommonController());

//======================================Controller
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtUserName = TextEditingController();




  fnClearAll(){
    txtUserName.clear();
    txtPassword.clear();
  }
  //////API CALL===================================================================
  fnLogin(){
    dprint("login........");
    if (loginformKey.currentState!.validate()) {
    try{
      futureform =  apiRepository.apiAdminLogin(txtPassword.text,txtUserName.text);
      futureform.then((value) => fnLoginRes(value));

    }catch(e){
      dprint(e.toString());
    }
    }

  }



  fnLoginRes(val){
    dprint("-------------------------");
    dprint(val);
    UserLoginModel userLoginModel = UserLoginModel.fromJson(val);
    dprint(userLoginModel.sTATUS);
    if(userLoginModel.sTATUS == "1"){
      dprint("22222222222222222222222222");
      commonController.wstrCompanyName.value = userLoginModel.dATA!.cOMPANYDESCP.toString();
      commonController.wstrCompanyCode.value = userLoginModel.dATA!.cOMPANY.toString();
      commonController.wstrUserName.value = userLoginModel.dATA!.uSERNAME.toString();
      commonController.wstrUserCode.value = userLoginModel.dATA!.uSERCD.toString();
      commonController.wstrRoleCode.value = userLoginModel.dATA!.rOLECODE.toString();
      dprint(commonController.wstrRoleCode.value);
      if(commonController.wstrRoleCode.value == "ADMIN"){
        Get.to(()=>const AdminHomeScreen());
        // fnClearAll();
      }else{
        return  Get.showSnackbar(
          const GetSnackBar(
            message: 'Donot Have Permission',
            duration: Duration(seconds: 2),
          ),
        );
        fnClearAll();
      }

      // CustomToast.showToast(
      //     "Login Successfully", ToastType.success, ToastPositionType.end);
      // Get.offAll(() => HomeScreen());
    }else{
      // isLogin.value = true;
      fnClearAll();
      CustomToast.showToast(
          'Login Failed', ToastType.error, ToastPositionType.end);
    }
  }


    }


