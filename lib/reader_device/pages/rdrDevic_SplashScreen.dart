import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_PasscodeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller/rdrSplash_Controller.dart';

class ReadrSplashScreen extends StatefulWidget {
  const ReadrSplashScreen({super.key});

  @override
  State<ReadrSplashScreen> createState() => _ReadrSplashScreenState();
}

class _ReadrSplashScreenState extends State<ReadrSplashScreen> {
  
  final ReaderSplashController readerSplashController = Get.put(ReaderSplashController());
  @override
  void initState() {

    readerSplashController.fnCheckSessionData();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration:  boxGradientTCBC(AppColors.appReaderBgRed,
            AppColors.appReaderBgBlue,0.0),
        child: Column(
          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tc("Beams", AppColors.white, 50),
                  tcS("Fungate", AppColors.white, 30),

                ],
              ),
            ),
            Obx(() => readerSplashController.sitecode.value.isNotEmpty? Container(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              decoration: boxBaseDecoration(AppColors.appReaderDarkBlck, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home,color: AppColors.white,size: 35,),
                  gapWC(3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tc((readerSplashController.sitecode.value??"").toString(), AppColors.white, 12),
                      tcn("DEIRA CITY CENTER", AppColors.white, 12,TextAlign.center),
                    ],
                  )
                ],
              ),

            ):gapHC(0),
            
            
            ),
            gapHC(40),
            const SpinKitThreeBounce(
              color: AppColors.white,
              size: 35.0,


            ),
            gapHC(50),
            tcn("VERSION V1.0", AppColors.white, 12, TextAlign.center),
            gapHC(10)
          ],
        ),
      ),
    );
  }
}
