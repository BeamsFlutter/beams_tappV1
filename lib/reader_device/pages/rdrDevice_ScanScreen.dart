import 'dart:io';

import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../common_widgets/common_textfield.dart';
import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/styles.dart';
import '../controller/rdrDeviceQrscan_controller.dart';

class ReadrQrScanScreen extends StatefulWidget {
  const ReadrQrScanScreen({super.key});

  @override
  State<ReadrQrScanScreen> createState() => _ReadrQrScanScreenState();
}

class _ReadrQrScanScreenState extends State<ReadrQrScanScreen> {
  final ReaderQrScanController readerQrScanController = Get.put(ReaderQrScanController());

  @override
  void dispose()async {
     readerQrScanController.qrController?.dispose();
     readerQrScanController.txtCenterCode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (readerQrScanController.qrController != null) {
      debugPrint('reassemble : ${readerQrScanController.qrController}');
      if (Platform.isAndroid) {
        await readerQrScanController.qrController?.pauseCamera();
      } else if (Platform.isIOS) {
        await readerQrScanController.qrController?.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: MediaQuery.of(context).padding,
        height: size.height,
        width: size.width,
        decoration: boxDecoration( AppColors.white, 0.0),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tc("Beams", AppColors.appReaderDarkbGbLUE, 20),
                      tcS("Fungate",AppColors.appReaderDarkbGbLUE, 15),
                    ],
                  ),
                  Bounce(
                    onPressed: (){
                      Get.back();
                      Get.back();
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                          decoration: boxOutlineCustom1(AppColors.white,
                              30.0, AppColors.appReaderDarkbGbLUE, 2.0),
                          child:  Icon(
                            Icons.close,
                            color:AppColors.appReaderDarkbGbLUE,
                            size: 23,
                          )),
                    ),
                  )
                ],
              ),
              gapHC(20),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,),
                child: Column(
                  children: [
                    tc("CHOOSE CENTER", AppColors.appReaderDarkbGbLUE, 15),
                    tcn("SCAN QR CODE",Colors.black87, 25,TextAlign.center),
                    tcn("Please Scan Sitecode For Device Registration",Colors.black87, 10,TextAlign.center),
                     gapHC(5),

                   readerQrScanController.wBuildQrView(context),
                    gapHC(10),
                    Row(
                      children: [
                        Flexible(child: Divider(color: Colors.black.withOpacity(0.3),thickness: 1)),
                        tc("   OR   ", Colors.black87, 10),
                        Flexible(child: Divider(color: Colors.black.withOpacity(0.3),thickness: 1)),
                      ],
                    ),


                    gapHC(10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        tcn("Center Code",Colors.black87, 20,TextAlign.center),
                        Container(
                          decoration: boxDecoration(  AppColors.appReaderDarkbGbLUE, 20),
                          child: Row(
                            children: [
                              Expanded( 
                                child: CommonTextfield(
                                    controller: readerQrScanController.txtCenterCode,
                                    textFormFieldType: TextFormFieldType.address,
                                    shadow: 30.0,
                                    radius: 40.0,
                                    align: TextAlign.center,
                                    opacityamount: 0.0,
                                    textStyle: TextStyle(
                                      fontSize: 30,color: AppColors.appReaderDarkbGbLUE,

                                    ),
                                    hintText: ""),
                              ),
                              gapWC(3),
                              Bounce(
                                  duration: const Duration(milliseconds: 110),
                                  onPressed: (){
                                    dprint("SHOW pOPUP");

                                    if(readerQrScanController.txtCenterCode.text.isNotEmpty){
                                      readerQrScanController.fnSavetoSession(readerQrScanController.txtCenterCode.text);
                                      readerQrScanController.successfullbottomSheet();
                                    }



                                  },
                                  child: Container(

                                      padding: EdgeInsets.all(8),
                                      child: const Icon(Icons.forward,color: Colors.white,size: 26,))),
                              gapWC(10),
                            ],
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              )),
              tcn("BEAMS", AppColors.appReaderDarkbGbLUE, 12, TextAlign.center),
              tcn("VERSION V1.0", AppColors.appReaderDarkbGbLUE, 12, TextAlign.center),
              gapHC(10)
            ],
          ),
        ),
      ),
    );
  }




}

