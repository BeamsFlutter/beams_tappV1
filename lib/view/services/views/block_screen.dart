import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/services/controller/block_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({Key? key}) : super(key: key);

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  final BlockController blockController = Get.put(BlockController());

  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        // title: tsw(AppStrings.services,AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,size: 25,),
            onPressed: () {
              dprint("search");
              Get.to(() => LookupSearch(
                callbackfn: (data) {
                  if(data!=null){
                    blockController.isTaped.value =true;
                    dprint("CARDNUMBER:>>>  ${data["CARDNO"]}");
                    blockController.fnCardDetails(data["CARDNO"],"N");
                    Get.back();
                  }


                },
                table_name: "CUSTOMER_CARDS",
                column_names: const [
                  {"COLUMN": "CARDNO", 'DISPLAY': "Card No: "},
                  {"COLUMN": "SLDESCP", 'DISPLAY': "Name: "},
                  {"COLUMN": "SLCODE", 'DISPLAY': "Slcode: "},
                ],
                filter: [],
              )
              );

            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: commonBoxDecoration(AppColors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
            child: Obx(() => Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWithUnderLine(
                        title: "Block",
                      ),
                      gapHC(20),
                      Center(
                        child: Obx(
                              () => blockController.card_show.value == false
                              ? GestureDetector(
                              onTap: () {
                                blockController.isTaped.value
                                    ? blockController.fnTaped(context)
                                    : (blockController.isAvailable.value
                                    ? null
                                    : blockController.fnTaped(context));
                              },
                              child: blockController.isTaped.value
                                  ? wTaphere()
                                  : (blockController.isAvailable.value
                                  ? wHoldcard()
                                  : wNotAvilble()))
                              : Align(
                            heightFactor: 0.86,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Bounce(
                                    duration: const Duration(milliseconds: 110),
                                    onPressed: () {},
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(
                                             AppAssets.splashCard),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 15,
                                          right: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              tc(blockController.customer_name.value.toString(), AppColors.white, 11)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              tc(blockController.cardnumb.value.toString(),
                                                  AppColors.white, 11),
                                              const SizedBox(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                gapWC(8),
                                Bounce(
                                  duration: const Duration(milliseconds: 110),
                                  onPressed: () {
                                    dprint("reset");
                                    blockController.fnResetCard(context);
                                    blockController.fnTaped(context);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.lightfontcolor
                                              .withOpacity(0.20),
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.refresh_outlined,
                                          size: 15,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      gapHC(20),
                      blockController.showCardDetails.value?    Container(
                        width: size.width,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: AppColors.lightfontcolor.withOpacity(0.20),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ts("Name:", AppColors.fontcolor, 12),
                                gapWC(5),
                                ts(blockController.customer_name.value.toString(),
                                    AppColors.fontcolor, 12),
                              ],
                            ),
                            gapHC(3),
                            Row(
                              children: [
                                ts("Email:", AppColors.fontcolor, 12),
                                gapWC(5),
                                ts(blockController.customer_email.value.toString(),
                                    AppColors.fontcolor, 12),
                              ],
                            ),
                            gapHC(3),
                            // Row(
                            //   children: [
                            //     ts("DOB:", AppColors.fontcolor, 12),
                            //     gapWC(5),
                            //     ts("10/10/1997",
                            //         AppColors.fontcolor, 12),
                            //   ],
                            // ),

                            Row(
                              children: [
                                ts("Mobile:", AppColors.fontcolor, 12),
                                gapWC(5),
                                ts(blockController.customer_mobile.value.toString(),
                                    AppColors.fontcolor,
                                    12),
                              ],
                            ),
                            // gapHC(3),
                            // Row(
                            //   children: [
                            //     ts("City:", AppColors.fontcolor, 12),
                            //     gapWC(5),
                            //     ts("Dubai",
                            //         AppColors.fontcolor, 12)
                            //   ],
                            // ),
                            gapHC(3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tcnw("Remaining Bal:", AppColors.fontcolor, 18,TextAlign.center,FontWeight.w600),
                                th(blockController.customer_remaingblnce.value.toString(), AppColors.fontcolor, 18),
                              ],
                            ),
                          ],
                        ),

                      ):SizedBox(),



                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: CommonButton(
                    buttoncolor: AppColors.primarycolor,
                    icon_need: false,
                    buttonText: "Block",
                    onpressed: () {
                       blockController.cardnumb.value.isNotEmpty? blockController.fnBlockCard(context):null;

                    },
                  ),
                ),
                gapHC(10)
              ],
            )),
          ),
        ),
      ),
    );
  }

  ///////Widget.......................................

  wIconwithTitle(IconData icon, String title, iconColor, textColor) {
    return Row(
      children: [
        Icon(Icons.menu_outlined, size: 20, color: iconColor),
        gapWC(3),
        tcnw(title, textColor, 16, TextAlign.center, FontWeight.w600),
      ],
    );
  }

  Widget wTaphere() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.tap_here, 70.2),
        gapHC(1),
        tsw("Tap here..", AppColors.lightfontcolor, 15, FontWeight.w500)
      ],
    );
  }

  Widget wHoldcard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.hold_card, 70.2),
        gapHC(1),
        tsw("Hold Near Reader", AppColors.lightfontcolor, 15, FontWeight.w500)
      ],
    );
  }

  Widget wNotAvilble() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        imageSet(AppAssets.not_availble, 50.2),
        gapHC(7),
        tsw("NFC may not be supported or \n may be temporarily turned off",
            AppColors.lightfontcolor, 15, FontWeight.w500),
        gapHC(7),
        tsw("Retry", AppColors.lightfontcolor, 15, FontWeight.w500)
      ],
    );
  }
}
