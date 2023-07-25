import 'dart:io';

import 'package:beams_tapp/adminMode/views/spalsh/view/adminSplashscreen.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/splash/views/splash_screen.dart';
import 'package:beams_tapp/webRegistrationMode/views/webRegisteration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    dprint(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appMode = "user";
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeamsTapp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary:  AppColors.primarycolor,
          ),

        ),
        // home: WebRegisatrtionScreen()
        home:appMode=="admin"? const AdminSplashScreen():appMode=="user"? const SplashScreen():appMode=="webreg"?const WebRegisatrtionScreen():const SizedBox()
    );
  }
}

