import 'package:beams_tapp/common_widgets/code_input.dart';
import 'package:beams_tapp/common_widgets/numbers.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/view/home/controller/home_controller.dart';
import 'package:beams_tapp/view/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {

   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // var p1 = "",p2 ="",p3 = "",p4 ="";

  final LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            heightFactor: 0.3,
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                color:AppColors.primarycolor
              ),
              child:  Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Center(child: th(AppStrings.appName,AppColors.white, 35)),
              ),
            ),
          ),
          FractionallySizedBox(
            heightFactor: 0.8,
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration:  BoxDecoration(
                  color:AppColors.appBgGreyshde,
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    gapHC(10),
                    tcnw("Enter code", AppColors.fontcolor, 20,TextAlign.center,FontWeight.w500),

                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        wCodeInput(loginController.p1.toString()),
                        gapW(),
                        wCodeInput(loginController.p2.toString()),
                        gapW(),
                        wCodeInput(loginController.p3.toString()),
                        gapW(),
                        wCodeInput(loginController.p4.toString()),

                      ],
                    )),
                    Obx(() =>    loginController.isLogin.value ? tcn("Login failed, Please try again..", Colors.red, 13,TextAlign.center):SizedBox(),),

                    tcn("Can't submit code?", AppColors.lightfontcolor, 13,TextAlign.center),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:   [
                        Numbers(value: "1"),
                        Numbers(value: '2'),
                        Numbers(value: '3'),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        Numbers(value: '4'),
                        Numbers(value: '5'),
                        Numbers(value: '6'),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        Numbers(value: '7'),
                        Numbers(value: '8'),
                        Numbers(value: '9'),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        Numbers(value: 'C'),
                        Numbers(value: '0'),
                        Numbers(value: 'B'),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  //====================================
 Widget wCodeInput(String inputValue){
    return Card(
      elevation: 20,
      shadowColor: Colors.grey.shade50,
      color:inputValue==""?Colors.white:AppColors.primarycolor,
      child:  const SizedBox(
        height: 40,
        width: 40,
      ),
    );
 }


}
