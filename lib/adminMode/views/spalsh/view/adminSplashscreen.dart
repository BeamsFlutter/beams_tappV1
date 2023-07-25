
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../constants/color_code.dart';
import '../../../../constants/string_constant.dart';
import '../../../../constants/styles.dart';
import '../../../../view/splash/controller/splash_controller.dart';
import '../controller/adminSplash_controller.dart';

class AdminSplashScreen extends StatefulWidget {
  const AdminSplashScreen({Key? key}) : super(key: key);

  @override
  State<AdminSplashScreen> createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> {
  final AdminSplashController adminSplashController = Get.put(AdminSplashController());
  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    // TODO: implement initState
    //
    // splashController.fnGetPageData();
    splashController.fnPhoneDetails();
    adminSplashController.fnGettoken();

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
