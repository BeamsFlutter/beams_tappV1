import 'package:beams_tapp/adminV1/controllers/reportController/reportController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/masterMenus.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';

class Adminv1ReportScreen extends StatefulWidget {
  const Adminv1ReportScreen({super.key});

  @override
  State<Adminv1ReportScreen> createState() => _Adminv1ReportScreenState();
}

class _Adminv1ReportScreenState extends State<Adminv1ReportScreen> {
  final Adminv1ReportController adminv1reportController = Get.put(Adminv1ReportController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
          child: Container(

            decoration: boxBaseDecoration(Colors.white, 6),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            child: Row(
              children: [
                tSubHead("Report",AppColors.appTicketDarkBlue, TextAlign.start),



              ],
            ),

          ),
        ),

        Expanded(
          child: Row(
            children: [
              Flexible(
                  child: Column(
                    children: [

                      Expanded(
                          child:Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
                                              Icon(Icons.search, color: Colors.black, size: 20),
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
                                    padding: const EdgeInsets.only(bottom: 6, right: 10, top: 6),
                                    child:Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: boxBaseDecoration(Colors.white, 6.0),
                                      child: Column(
                                        children: [
                                          Obx(
                                                () => Container(
                                              decoration: boxBaseDecoration(
                                                  AppColors.appAdminBgLightBlue, 6),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4, vertical: 6),
                                              child: masterMenu(() {
                                                adminv1reportController.wstrPageMode.value = "VIEW";
                                              }, adminv1reportController.wstrPageMode.value),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [


                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          )
                      )     ],
                  )
              )
            ],
          ),
        ),
      ],
    );



  }
}
