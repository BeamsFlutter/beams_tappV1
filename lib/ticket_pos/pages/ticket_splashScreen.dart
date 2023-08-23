import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_PasscodeScreen.dart';
import 'package:beams_tapp/ticket_pos/controller/tktLoginController.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';



class TicketSplashScreen extends StatefulWidget {
  const TicketSplashScreen({super.key});

  @override
  State<TicketSplashScreen> createState() => _TicketSplashScreenState();
}

class _TicketSplashScreenState extends State<TicketSplashScreen> {


  @override
  void initState() {

    Future.delayed(const Duration(
        seconds: 2
    ),
            () =>  Get.to(()=>const TicketLoginScreeen())
    );

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(

      body: Container(
        padding: MediaQuery.of(context).padding,
        height: size.height,
        width: size.width,
        decoration:  boxGradientCLBR(AppColors.appReaderBgRed,
            AppColors.appTicketDarkBlue,0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcH("Beams", AppColors.white, 90,0.97),
                  tcSH("Fungate ", AppColors.white, 40,0.65),

                ],
              ),
            ),

            gapHC(40),
            const SpinKitThreeBounce(
              color: AppColors.white,
              size: 35.0,
            ),
            gapHC(40),
            tcn("VERSION V1.0",  AppColors.appBgGreyshde.withOpacity(0.4), 10, TextAlign.center),
            gapHC(10)
          ],
        ),
      ),
    );
  }
}
