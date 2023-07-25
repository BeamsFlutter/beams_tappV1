
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/commonbutton.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/enums/txt_field_type.dart';
import '../../../../constants/string_constant.dart';
import '../../../../constants/styles.dart';
import '../../../../utils/textfieldValidator.dart';
import '../controller/adminLogin_controller.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final AdminLoginController adminLoginController = Get.put(AdminLoginController());
@override
  void dispose() {
  //adminLoginController.fnClearAll();
  // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: boxImageDecoration("assets/images/bg.jpg", 0),
                child: Container(
                  decoration: boxBaseDecoration(AppColors.primarycolor.withOpacity(0.9), 0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      tc('BEAMS TAPP', Colors.white, 50),
                      tcn('MANAGEMENT APPLICATION', Colors.white, 12,TextAlign.center),
                      tcn('V 1.0.0', Colors.white, 10,TextAlign.center),
                    ],
                  ),
                ),
              ),
            ) ,
            const VerticalDivider(thickness: 0.5,),
            SingleChildScrollView(
              child:  Container(
                height: size.height,
                decoration: boxBaseDecoration(Colors.white, 0),
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Form(
                  key: adminLoginController.loginformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 100 ,width: 100,
                          child: Image.asset(AppAssets.tappLogo,)),
                      gapHC(10),
                      tc('BEAMS TAPP', Colors.black, 20),
                      tcn('MANAGEMENT APPLICATION', Colors.black, 12,TextAlign.center),
                      tcn('Please sign-in to your account', AppColors.lightfontcolor, 12,TextAlign.center),
                      gapHC(20),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: adminLoginController.txtUserName,
                          decoration: InputDecoration(
                            filled: true,
                            label: const Text("username"),
                            hintText: "username",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)
                            ),

                          ),
                          validator: (String? value) {
                            return FormValidator.isValid(TextFormFieldType.adminUsername, value ?? "");

                          },

                        ),
                      ),
                      gapHC(20),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: adminLoginController.txtPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            label: const Text("password"),
                            hintText: "password",

                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          validator: (String? value) {
                            return FormValidator.isValid(TextFormFieldType.adminUserPassword, value ?? "");

                          },
                        ),
                      ),
                      gapHC(20),

                      SizedBox(
                        width: 300,
                        height: 40,
                        child: CommonButton(buttoncolor: AppColors.primarycolor,buttonTextSize: 13,icon_need:false, buttonText: "Sign In",onpressed: (){
                          adminLoginController.fnLogin();

                        }),
                      ),
                      gapHC(20),
                      const SizedBox(
                        width: 300,
                        child: Divider(height: 0.1,),
                      ),
                      gapHC(15),
                      SizedBox(
                        width: 300,
                        child: Center(
                          child: tcn('Beams V1.0.0', Colors.black, 10,TextAlign.center),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
