import 'dart:io';
import 'dart:ui';
import 'package:beams_tapp/adminMode/views/spalsh/view/adminSplashscreen.dart';
import 'package:beams_tapp/adminV1/pages/masterScreen/mstrCardScreen.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/printerNewPackageForTest/homeScreen.dart';
import 'package:beams_tapp/reader_device/pages/rdrCounterPage.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevic_SplashScreen.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_PasscodeScreen.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_ScanScreen.dart';
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/test.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket%20HistoryDetailScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_CardIssue.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_HistoryScanScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_HomeScreen.dart';

import 'package:beams_tapp/ticket_pos/pages/ticket_LoginScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_RechargeScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_RechargeTapScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_splashScreen.dart';

import 'package:beams_tapp/view/splash/views/splash_screen.dart';
import 'package:beams_tapp/webRegistrationMode/views/webRegisteration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'adminV1/pages/adminHomeScreen.dart';
import 'adminV1/pages/adminLoginScreen.dart';
import 'adminV1/pages/adminSplashScreen.dart';
import 'adminV1/pages/masterScreen/masterScreen.dart';
import 'constants/common_functn.dart';


//12.07.2023

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    if(Platform.isAndroid || Platform.isIOS){
      await NotificationService().init();
      await Prefs.init();
    }
  }catch(e){

    dprint("CATCH ERROR>>>>>>>>>>>>>> "+e.toString());
  }
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(MyApp()));


 // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appMode = "admin";
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeamsTapp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary:  AppColors.primarycolor,
          ),
        ),
        //home: ReadrQrScanScreen()
     //
         // home: TicketSplashScreen()


  home: const AdminV1HomeScreen()

//  home: const AdminV1SplashScreen()
      // home: ReadrSplashScreen()
 // home:appMode=="admin"? const AdminSplashScreen():appMode=="user"? const SplashScreen():appMode=="webreg"?const WebRegisatrtionScreen():const SizedBox()
    );
  }
}









class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}
















