import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/login/controller/login_controller.dart';
import 'package:beams_tapp/view/recharge/controller/recharge_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class Numbers extends StatelessWidget {
  final String value;
  Numbers({Key? key,required this.value,}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return  Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: (){
          // dprint("VaAALUEEE  :  ${value}");

            if(value == "B"){
              loginController.fnBackspace();
            }else if(value == "C"){
              loginController.fnClearAll();
            }else{
              loginController.fnNumberPress(value);
            }


        },
        child: Material(
          elevation: 0,
            shadowColor:  Colors.white,
          child: Container(
           height: 50,width: 50,
            decoration: BoxDecoration(
                color: AppColors.primarycolor,
              borderRadius:BorderRadius.circular(30)
            ),
              child: Center(child:value =="B"?
               const Icon(Icons.backspace,color: Colors.white,size: 20,):
              value == "C"?  const Icon(Icons.close,color: Colors.white,size: 20,): tcnw(value,AppColors.white,20, TextAlign.center, FontWeight.w500))),
        )
    );
  }
}
