import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/string_constant.dart';
import '../../constants/styles.dart';

class RegisterQrGenerator extends StatefulWidget {
  final String ? slcode;
  final String ? name;
  final String ? mobile;
  const RegisterQrGenerator({Key? key, required this.slcode, required this.name, required this.mobile}) : super(key: key);

  @override
  State<RegisterQrGenerator> createState() => _RegisterQrGeneratorState();
}

class _RegisterQrGeneratorState extends State<RegisterQrGenerator> {
  @override
  Widget build(BuildContext context) {
    dprint("SLCODE:: >> ${widget.slcode.toString()}");
    return Scaffold(
      body: Container(
        decoration: boxImageDecoration("assets/images/bg.jpg", 0),
        child: Container(
          color: AppColors.primarycolor.withOpacity(0.9),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(),
              Container(
                width:500,

                decoration: boxDecoration(Colors.white, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(),

                    Container(
                      height: 180,
                      decoration: boxImageDecoration(AppAssets.regiter_successful, 30),
                    ),
                    const SizedBox(
                      width: 100,
                      child: Divider(height: 0.8,),
                    ),
                    gapHC(10),
                    tc("Registration", Colors.green, 20),
                    gapHC(5),
                    tc("Successful", Colors.black, 12),
                    gapHC(10),
                    tcn("SCAN & GET YOUR CARD", AppColors.lightfontcolor, 10,TextAlign.center),
                    // Center(
                    //   child: QrImage(
                    //     data: widget.slcode.toString(),
                    //     version: QrVersions.auto,
                    //     size: 180,
                    //     gapless: false,
                    //   ),
                    // ),
                    gapHC(5),
                    tc(widget.slcode.toString().toUpperCase(), AppColors.fontcolor, 10),
                    gapHC(5),
                    tc(widget.name.toString(), AppColors.fontcolor, 10),
                    tc(widget.mobile.toString(), AppColors.lightfontcolor, 10),
                    gapHC(15),

                    Container(
                      height: 50,
                      decoration: boxDecorationC(Colors.green, 0,0,30,30),
                      child: Center(
                        child: tcn('SPLASH N PARTY', AppColors.white  , 8 , TextAlign.center),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
