import 'package:beams_tapp/adminV1/controllers/counterController/counterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/masterMenus.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';

class AdminV1CounterScreen extends StatefulWidget {
  const AdminV1CounterScreen({super.key});

  @override
  State<AdminV1CounterScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<AdminV1CounterScreen> {
  final AdminV1CounterController adminV1Controller =
  Get.put(AdminV1CounterController());

  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
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
                  tSubHead("Counter",AppColors.appTicketDarkBlue, TextAlign.start),



                ],
              ),

            ),
          ),

          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          padding: const EdgeInsets.only(left: 0, right: 10),
                          child: Obx(() => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: boxBaseDecoration(Colors.white, 6),
                            child: Column(
                              children: [

                                Container(

                                  decoration: boxBaseDecoration(
                                      AppColors.appAdminBgLightBlue, 6),
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                  child: masterMenu((){
                                    adminV1Controller.wstrPageMode.value="VIEW";

                                  }, adminV1Controller.wstrPageMode.value),
                                ),
                                gapHC(20),



                              ],
                            ),
                          )),
                        ))

                  ],
                ),
              )
          )
        ]  );

  }






}