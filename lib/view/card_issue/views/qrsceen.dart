import 'dart:io';

import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/view/card_issue/controller/cardissue_controller.dart';
import 'package:beams_tapp/view/register/controller/registerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScren extends StatefulWidget {
  const QrScren({Key? key}) : super(key: key);

  @override
  State<QrScren> createState() => _QrScrenState();
}

class _QrScrenState extends State<QrScren> {
  final CardIssueController cardIssueController = Get.put(CardIssueController());



  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (cardIssueController.qrController != null) {
      debugPrint('reassemble : ${cardIssueController.qrController}');
      if (Platform.isAndroid) {
        await cardIssueController.qrController?.pauseCamera();
      } else if (Platform.isIOS) {
        await cardIssueController.qrController?.resumeCamera();
      }
    }
  }


  // @override
  // void reassemble() {
  //   super.reassemble();
  //
  //   // if (cardIssueController.qrController != null) {
  //   //   debugPrint('reassemble : ${cardIssueController.qrController}');
  //   //   if (Platform.isAndroid) {
  //   //      cardIssueController.qrController!.pauseCamera();
  //   // } else if (Platform.isIOS) {
  //   //  cardIssueController.qrController!.resumeCamera();
  //   // }
  //   // }
  //
  //
  //   if (Platform.isAndroid) {
  //     cardIssueController.qrController?.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     cardIssueController.qrController?.resumeCamera();
  //   }
  // }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          wBuildQrView(context),
          const Positioned(
            bottom: 10,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Scan QR code \fFor Card-Issue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget wBuildQrView(BuildContext context) {
    return  QRView(
        key: cardIssueController.qrKey,
        onQRViewCreated: cardIssueController.fnOnQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.75,
          borderLength: 10 * 3.0,
          borderRadius: 10 * 1.6,
          borderWidth: 10 * 1.0,
          borderColor: AppColors.primarycolor,
        ));
  }
}
