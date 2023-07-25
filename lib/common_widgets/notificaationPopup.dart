


import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/payment/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

wDisplayDialog(date,amount,docnumb,expdate,doctype) {
  dprint("Doctypeee in Alerttt.....${doctype}");
  dprint("DocNumber in  Alerttt....${docnumb}");
  return Get.dialog(

    barrierDismissible: false,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: AlertDialog(
          titlePadding: const EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          contentPadding: EdgeInsets.zero,
          elevation: 1.2,
          insetPadding: const EdgeInsets.all(8),
          title: SizedBox(
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Bounce(
                    onPressed: (){
                      Get.back();
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                        height: 30, width: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)

                          ),
                        ),

                        child: const Icon(Icons.clear,color: Colors.red,size: 19)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ts(docnumb.toString(), AppColors.lightfontcolor, 12),
                    gapHC(2),
                    ts(mfnDate(date, 6), AppColors.lightfontcolor, 12),
                    gapHC(2),
                    tsw("${amount.toString()} AED", AppColors.fontcolor, 25,FontWeight.w600),
                    gapHC(16),
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: (){
                        Get.back();
                        Get.to(()=> PaymentScreen(amount: mfnDbl(amount),transactionId: docnumb,expDate:expdate,cuDate:date,transactiondoctype: doctype.toString(),));

                      },

                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.only(left: 13,right: 13,top: 6,bottom: 6),
                        decoration: BoxDecoration(
                            color: AppColors.secondarycolor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: tsw("Pay", AppColors.white, 17,FontWeight.w700)),
                      ),
                    )
                  ],
                ),
                gapHC(20)




              ],
            ),
          )
      ),
    ),
  );
}