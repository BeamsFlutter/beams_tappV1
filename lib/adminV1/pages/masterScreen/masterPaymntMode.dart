import 'package:awesome_card/awesome_card.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/masterMenus.dart';
import '../../../constants/string_constant.dart';
import '../../controllers/masterController/masterCardController.dart';
import '../../controllers/masterController/masterPaymentMode.dart';

class MasterPaymentMode extends StatefulWidget {
  const MasterPaymentMode({super.key});

  @override
  State<MasterPaymentMode> createState() => _MasterPaymentModeState();
}

class _MasterPaymentModeState extends State<MasterPaymentMode> {
  final MasterPaymentController masterPaymentController =
  Get.put(MasterPaymentController());
  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: boxBaseDecoration(Colors.white, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tBody("Search", AppColors.appAdminColor2, TextAlign.start),
                  gapHC(2),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        suffixIcon:
                        const Icon(Icons.search, color: Colors.black, size: 20),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.appAdminBgLightBlue),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        fillColor: AppColors.appAdminBgLightBlue,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.appAdminBgLightBlue),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
            flex: 7,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 6,right:10,top: 6),
                child:  Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  decoration: boxBaseDecoration(Colors.white, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(

                        decoration: boxBaseDecoration(
                            AppColors.appAdminBgLightBlue, 6),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: masterMenu((){
                          masterPaymentController.wstrPageMode.value="VIEW";

                        }, masterPaymentController.wstrPageMode.value),
                      ),
                      gapHC(20),

                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Flexible(
                      //       flex: 3,
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           tBody("Code", AppColors.appAdminColor2,
                      //               TextAlign.start),
                      //           SizedBox(
                      //             height: 40,
                      //
                      //             child: Material(
                      //               elevation: 2.0,
                      //               shadowColor: Colors.grey.shade100,
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                   BorderRadius.circular(20)),
                      //               child: TextField(
                      //                 controller: masterPaymentController
                      //                     .txtCode.value,
                      //                 cursorColor: Colors.black,
                      //                 decoration: InputDecoration(
                      //                   enabledBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                         color: AppColors.white),
                      //                     borderRadius:
                      //                     BorderRadius.circular(30.0),
                      //                   ),
                      //                   fillColor: AppColors.white,
                      //                   contentPadding: EdgeInsets.only(
                      //                       bottom: 5, left: 8),
                      //                   focusedBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                         color: AppColors.white),
                      //                     borderRadius:
                      //                     BorderRadius.circular(30.0),
                      //                   ),
                      //                 ),
                      //                 // onChanged: (String value) {
                      //                 //   masterPlayAreaController
                      //                 //       .lstrCounterName.value = value;
                      //                 //
                      //                 //   // masterPlayAreaController.txtCounterName.value.text=value;
                      //                 // },
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     gapWC(20),
                      //     Flexible(
                      //       flex: 7,
                      //       child:  Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           tBody("Detail Description", AppColors.appAdminColor2,
                      //               TextAlign.start),
                      //           SizedBox(
                      //             height: 100,
                      //
                      //             width: MediaQuery.of(context).size.width/3,
                      //             child: Material(
                      //               elevation: 2.0,
                      //               shadowColor: Colors.grey.shade100,
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                   BorderRadius.circular(20)),
                      //               child: TextField(
                      //                 maxLines: 5,
                      //                 controller: masterPaymentController
                      //                     .txtdiscrption.value,
                      //                 cursorColor: Colors.black,
                      //                 decoration: InputDecoration(
                      //                   enabledBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                         color: AppColors.white),
                      //                     borderRadius:
                      //                     BorderRadius.circular(30.0),
                      //                   ),
                      //                   fillColor: AppColors.white,
                      //                   contentPadding: EdgeInsets.only(
                      //                       bottom: 5, left: 8,top: 10),
                      //                   focusedBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                         color: AppColors.white),
                      //                     borderRadius:
                      //                     BorderRadius.circular(30.0),
                      //                   ),
                      //                 ),
                      //                 // onChanged: (String value) {
                      //                 //   masterPlayAreaController
                      //                 //       .lstrCounterName.value = value;
                      //                 //
                      //                 //   // masterPlayAreaController.txtCounterName.value.text=value;
                      //                 // },
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     tBody("Detail Description", AppColors.appAdminColor2,
                      //         TextAlign.start),
                      //     SizedBox(
                      //       height: 100,
                      //
                      //       width: MediaQuery.of(context).size.width/3,
                      //       child: Material(
                      //         elevation: 2.0,
                      //         shadowColor: Colors.grey.shade100,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius:
                      //             BorderRadius.circular(20)),
                      //         child: TextField(
                      //           maxLines: 5,
                      //           controller: masterPaymentController
                      //               .txtDetailDisc.value,
                      //           cursorColor: Colors.black,
                      //           decoration: InputDecoration(
                      //             enabledBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //                   color: AppColors.white),
                      //               borderRadius:
                      //               BorderRadius.circular(30.0),
                      //             ),
                      //             fillColor: AppColors.white,
                      //             contentPadding: EdgeInsets.only(
                      //                 bottom: 5, left: 8,top: 10),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //                   color: AppColors.white),
                      //               borderRadius:
                      //               BorderRadius.circular(30.0),
                      //             ),
                      //           ),
                      //           // onChanged: (String value) {
                      //           //   masterPlayAreaController
                      //           //       .lstrCounterName.value = value;
                      //           //
                      //           //   // masterPlayAreaController.txtCounterName.value.text=value;
                      //           // },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tBody("Code", AppColors.appAdminColor2,
                              TextAlign.start),

                          wCommonTextFieldAdminV1(masterPaymentController
                              .txtCode.value, 200.0,)

                        ],
                      ),
                      gapHC(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tBody("Description", AppColors.appAdminColor2,
                              TextAlign.start),


                          wCommonTextFieldAdminV1(masterPaymentController
                              .txtdiscrption.value,
                              MediaQuery.of(context).size.width/3,)
                        ],
                      ),


                    ],
                  ),
                )
            ))
      ],
    );
  }



}
