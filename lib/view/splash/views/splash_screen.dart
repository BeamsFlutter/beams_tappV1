import 'dart:async';

import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:beams_tapp/view/login/views/login_screen.dart';
import 'package:beams_tapp/view/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../constants/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController splashController = Get.put(SplashController());
  final CommonController commonController = Get.put(CommonController());
  @override
  void initState() {
    // TODO: implement initState
    splashController.fnGetPageData();
    splashController.fnPhoneDetails();
    splashController.fnGettoken();


    // Timer(Duration(seconds: 5),
    //         ()=>Get.offAll(() => LoginScreen())
    // );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          tcnw(AppStrings.appName, AppColors.primarycolor,60,TextAlign.center,FontWeight.w600),
          gapHC(15),
          const SpinKitThreeBounce(color: AppColors.primarycolor,size: 25.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: tcn("Powered by beams", AppColors.lightfontcolor, 13,TextAlign.center)
      ),
    );
  }
}
