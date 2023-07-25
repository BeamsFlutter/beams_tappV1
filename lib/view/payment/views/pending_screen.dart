import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';

import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/payment/controller/payment_controller.dart';
import 'package:beams_tapp/view/payment/controller/pending_controller.dart';
import 'package:beams_tapp/view/payment/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';


wDisplayDialog(BuildContext context) {
  return showGeneralDialog(
      context: context,
      transitionBuilder: (context,a1, a2, child) {
        return Transform.scale(
          scale: Curves.easeInOut.transform(a1.value),
          child: AlertDialog(
              titlePadding: const EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              contentPadding: EdgeInsets.zero,
              elevation: 1.2,
              insetPadding: const EdgeInsets.all(8),
              title: SizedBox(
                height: 150,
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
                            height: 25, width: 25,
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
                        ts("Doc No:38947593753", AppColors.lightfontcolor, 12),
                        gapHC(2),
                        ts("10-10-2023", AppColors.lightfontcolor, 12),
                        gapHC(2),
                        tsw("500 AED", AppColors.fontcolor, 17,FontWeight.w600),
                        gapHC(16),
                        Bounce(
                          duration: const Duration(milliseconds: 110),
                          onPressed: (){
                            Get.to(()=>const PaymentScreen(amount: 500.0,));

                          },

                          child: Container(
                            width: 80,height: 25,
                            padding: const EdgeInsets.only(left: 13,right: 13,top: 4,bottom: 4),
                            decoration: BoxDecoration(
                                color: AppColors.secondarycolor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: tsw("Pay", AppColors.white, 12,FontWeight.w700)),
                          ),
                        )
                      ],
                    ),
                    gapHC(20)








                  ],
                ),
              )
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Container();
      });
}



class PendingPayScreen extends StatefulWidget {
  const PendingPayScreen({Key? key}) : super(key: key);

  @override
  State<PendingPayScreen> createState() => _PendingPayScreenState();
}

class _PendingPayScreenState extends State<PendingPayScreen> {

  final PendingController pendingController = Get.put(PendingController());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      pendingController.fnPendingPayment();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw("Pending Payment",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
                Get.back();
            }
        ),
        actions: [
          IconButton(
              icon:  const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                pendingController.fnPendingPayment();
              }
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          padding: const EdgeInsets.only(top: 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithUnderLine(title: "Pending Payment",),
                gapHC(20),
               Obx(() =>   Expanded(
                 child: pendingController.pendingList.isNotEmpty? ListView.builder(
                     physics: const BouncingScrollPhysics(),
                     itemCount: pendingController.pendingList.length,
                     itemBuilder: (context,index){
                       var pendingList =pendingController.pendingList.value[index];
                       dprint("eeeeeeeeee adas ${pendingList.toString()}");
                       var doctype =pendingList.dOCTYPE.toString();
                       dprint("dddoctype in pendingscreeeeen........ ${doctype}");
                       var docdate= "";
                       var date =DateTime.now();
                       var expdate =DateTime.now();
                       try{

                         date = DateTime.parse(pendingList.dOCDATE.toString());
                         expdate = DateTime.parse(pendingList.eXPDATE.toString());
                         docdate =setDate(15, DateTime.parse(pendingList.dOCDATE.toString()));
                       }catch(e){}

                       return Padding(
                         padding: const EdgeInsets.only(top: 8.0),
                         child: Material(
                           elevation: 9,
                           // shadowColor: AppColors.lightfontcolor.withOpacity(0.20),
                           borderRadius:BorderRadius.circular(5.0),
                           shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
                           child: Container(
                               width: double.infinity,
                               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       tsw(mfnDbl(pendingList.aMOUNT).toString(), AppColors.fontcolor, 14,FontWeight.w600),
                                       gapHC(2),
                                       //transaction id
                                       ts(pendingList.dOCNO.toString(), AppColors.lightfontcolor, 12),
                                       gapHC(2),
                                       Row(
                                         children: [
                                           const Icon(Icons.date_range_outlined,size: 12,color: AppColors.lightfontcolor),
                                           ts(docdate, AppColors.lightfontcolor, 12),
                                         ],
                                       )
                                     ],
                                   ),
                                   Bounce(
                                     duration: const Duration(milliseconds: 110),
                                     onPressed: (){
                                       Get.to(()=> PaymentScreen(amount:pendingList.aMOUNT,cuDate: date,expDate: expdate,transactionId:pendingList.dOCNO.toString()
                                         ,transactiondoctype: doctype,));
                                     },

                                     child: Container(
                                       padding: const EdgeInsets.only(left: 13,right: 13,top: 4,bottom: 4),
                                       decoration: BoxDecoration(
                                           color: AppColors.secondarycolor,
                                           borderRadius: BorderRadius.circular(5)
                                       ),
                                       child: tsw("Pay", AppColors.white, 12,FontWeight.w700),
                                     ),
                                   ),
                                 ],
                               )
                           ),
                         ),
                       );
                     }):
                 Center(
                   child: tc("No Data Found", AppColors.lightfontcolor, 14),
                 ),
               )


               )

              ]

              ),),
        ),
      ),
    );
  }






}

