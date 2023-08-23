import 'dart:async';
import 'dart:convert';

import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:beams_tapp/view/login/views/login_screen.dart';
import 'package:beams_tapp/view/settings/view/setting_screen.dart';
import 'package:beams_tapp/view/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
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
  BluetoothPrinter bluetoothPrinterData = BluetoothPrinter();
  @override
  void initState() {
    // TODO: implement initState
    splashController.fnGetPageData();
    splashController.fnPhoneDetails();
    splashController.fnGettoken();
    fngetSessionData();







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

  void fngetSessionData()async {

    var printerDevice = await json.decode(Prefs.getString(AppStrings.select_bt_device)??"");
    dprint("PRE>>>pr${printerDevice}");
    try {
      BluetoothPrinter bluetoothPrinter = BluetoothPrinter.fromJson(printerDevice);
      setState(() {
        bluetoothPrinterData = bluetoothPrinter;
      });
    } catch (e) {
      dprint(e);
    }
    commonController.wBluetoothPrinter.value = bluetoothPrinterData;


  }
}
