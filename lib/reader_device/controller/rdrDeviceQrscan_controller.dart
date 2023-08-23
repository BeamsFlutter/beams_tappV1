import 'dart:io';


import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/reader_device/pages/rdrCounterPage.dart';
import 'package:beams_tapp/reader_device/pages/rdrDevice_PasscodeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/string_constant.dart';
import '../../storage/preference.dart';

class ReaderQrScanController extends GetxController{

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  TextEditingController txtCenterCode =TextEditingController();
  var sitecode="";

  //=====================  WIDGET =============================

  Widget wBuildQrView(BuildContext context) {
    return  Container(
      height: 300,
      padding: const EdgeInsets.all(6),
      width: 300,


      child: QRView(
          key: qrKey,
          onQRViewCreated: fnOnQRViewCreated,
          overlay: QrScannerOverlayShape(
            // borderRadius: 10,
            // borderLength: 32,
            // borderWidth:15,
            borderColor: Colors.greenAccent,
            cutOutSize: MediaQuery.of(context).size.width * 0.75,


            //
            borderLength: 10 * 3.0,
            borderRadius: 10 * 1.6,
            borderWidth: 10 * 1.5,
         //   borderColor: AppColors.appReaderDarkbGbLUE,
          )),
    );
  }
  successfullbottomSheet(){
    return Get.bottomSheet(
        Stack(
          children: [
            Container(
             // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 28),
              margin: const EdgeInsets.only(left: 15,right: 15,top: 60,bottom: 15),
              decoration: boxDecoration(Colors.white, 30),
              child:   Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  gapHC(38),
                  tcn("Connected Successfully", AppColors.appReaderDarkbGbLUE, 15,TextAlign.center),
                  gapHC(10),
                  tcn("This Device Successfully Connected With Debra City Center ", Colors.black87, 10,TextAlign.center),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: boxBaseDecoration(Colors.grey.shade200 , 10),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Icon(Icons.home,color: AppColors.appReaderDarkbGbLUE,size: 30,),
                        gapWC(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc("${sitecode}", AppColors.appReaderDarkbGbLUE, 20),
                            tcn("DEIRA CITY CENTER", AppColors.appReaderDarkbGbLUE, 12,TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                  ),

                  gapHC(20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Bounce(
                            duration: const Duration(milliseconds: 110),
                            onPressed: (){
                              dprint("Moving to Nddext");
                              txtCenterCode.text="";
                               qrController?.resumeCamera();
                              Get.back();
                            },
                            child: Container(
                                decoration: boxOutlineCustom1(Colors.white, 30, AppColors.appReaderDarkbGbLUE, 0.5),
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    tcn("Retry", AppColors.appReaderDarkbGbLUE.withOpacity(0.8), 12,TextAlign.center)
                                  ],
                                )),
                          ),
                        ),
                        gapWC(10),
                        Flexible(
                          child: Bounce(
                            duration: const Duration(milliseconds: 110),
                            onPressed: (){
                              txtCenterCode.text="";
                              qrController?.resumeCamera();
                              Get.back();
                              dprint("Moving to Nasaext");
                                  Get.to(()=>const ReadrPasscodeScreen());
                                  qrController?.stopCamera();
                                  qrController?.dispose();

                            },
                            child: Container(
                                decoration: boxDecoration(AppColors.appReaderDarkbGbLUE, 30),
                                padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    tc("Continue", Colors.white, 12)
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapHC(10),


                ],
              ),
            ),
             Positioned(
                top: 25,
                right: 1,
                left: 1,
               // child: Icon(Icons.check_circle,size: 65,color: Colors.greenAccent,)
              // child: CircleAvatar(
              //   radius: 35,
              //   backgroundColor: Colors.white,
              //   child: Icon(Icons.check,size: 44,color: Colors.green),
              // )
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     width: 80,height: 80,
                     decoration: boxImageDecoration("assets/gifs/done.gif", 80),
                   ),
                 ],
               ),



            ) ,

          ],
        )
    );
  }
  failedbottomSheet(){
    return Get.bottomSheet(
        Stack(
          children: [
            Container(
             // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 28),
              margin: const EdgeInsets.only(left: 15,right: 15,top: 60,bottom: 15),
              decoration: boxDecoration(Colors.white, 30),
              child:   Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  gapHC(38),
                  tcn("No SiteCode Found", Colors.red, 15,TextAlign.center),



                  gapHC(40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: (){
                        dprint("Moving to Next");
                        Get.back();
                      },
                      child: Container(
                          decoration: boxDecoration(AppColors.appReaderDarkbGbLUE, 30),
                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              tc("Retry", Colors.white, 12)
                            ],
                          )),
                    ),
                  ),
                  gapHC(10),


                ],
              ),
            ),
             Positioned(
                top: 25,
                right: 1,
                left: 1,
               // child: Icon(Icons.check_circle,size: 65,color: Colors.greenAccent,)
              // child: CircleAvatar(
              //   radius: 35,
              //   backgroundColor: Colors.white,
              //   child: Icon(Icons.check,size: 44,color: Colors.green),
              // )
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     width: 70,height: 70,
                     decoration: boxImageDecoration("assets/gifs/close.gif", 70),
                   ),
                 ],
               ),



            ) ,

          ],
        )
    );
  }

  //=====================  FUNCTIONS =============================
  void fnOnQRViewCreated(QRViewController controller) {
    qrController = controller;
    if (Platform.isAndroid) {
      qrController?.resumeCamera();
    } else if (Platform.isIOS) {
      qrController?.resumeCamera();
    }
    qrController?.scannedDataStream.listen((scanData) {


    }).onData((scanData) {
      fnCheckIfValidQR(scanData,);
    });
  }
  void fnCheckIfValidQR(Barcode scanData) async {
    dprint("SCCCCAAN  DATAA  ${scanData.code}");
    try {
      qrController?.stopCamera();

      txtCenterCode.text = scanData.code!;
      fnSavetoSession(scanData.code);
      successfullbottomSheet();
      //failedbottomSheet();

      // Get.back();
      // fnCustomerDetails(scanData.code.toString());


    } on FormatException catch (e) {
      dprint(e.message);
    }
  }
  fnSavetoSession(value)async{
    dprint("SITECODE .. VAL >>${value}");
    sitecode=value;
    await Prefs.setString(AppStrings.rdr_siteCode,value);

  }



}