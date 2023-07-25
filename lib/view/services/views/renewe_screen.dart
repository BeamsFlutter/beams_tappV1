import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/services/controller/renew_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class RenewScreen extends StatefulWidget {
  const RenewScreen({Key? key}) : super(key: key);

  @override
  State<RenewScreen> createState() => _RenewScreenState();
}

class _RenewScreenState extends State<RenewScreen> {
  final RenewController renewController = Get.put(RenewController());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      renewController.fnRenewAmount();


    });
    // TODO: implement initState
    super.initState();
  }
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
                        title: "Renewal",
                      ),
                      gapHC(20),
                      Center(
                        child: Obx(
                              () => renewController.card_show.value == false
                              ? GestureDetector(
                              onTap: () {
                                renewController.isTaped.value
                                    ? renewController.fnTaped(context)
                                    : (renewController.isAvailable.value
                                    ? null
                                    : renewController.fnTaped(context));
                              },
                              child: renewController.isTaped.value
                                  ? wTaphere()
                                  : (renewController.isAvailable.value
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
                                              tc(renewController.customer_name.value.toString().toUpperCase(), AppColors.white, 11)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              tc(renewController.cardnumb.value.toUpperCase(),
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
                                    renewController.fnResetCard(context);
                                    renewController.fnTaped(context);
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
                      renewController.showCardDetails.value?    Container(
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
                                ts(renewController.customer_name.value.toString().toUpperCase(),
                                    AppColors.fontcolor, 12),
                              ],
                            ),
                            gapHC(3),
                            Row(
                              children: [
                                ts("Email:", AppColors.fontcolor, 12),
                                gapWC(5),
                                ts(renewController.customer_email.value.toString(),
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
                            gapHC(3),
                            Row(
                              children: [
                                ts("Mobile:", AppColors.fontcolor, 12),
                                gapWC(5),
                                ts(renewController.customer_mobile.value.toString(),
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
                          ],
                        ),

                      ):SizedBox(),
                      gapHC(20),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          th("Renewal Charge", AppColors.fontcolor, 15),
                          th( '${renewController.renewCharge.value.toStringAsFixed(2)} AED', AppColors.fontcolor, 15),
                        ],
                      ),
                      gapHC(20),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          ts(
                              "Payment Method",
                              AppColors.fontcolor,
                              12),
                          gapWC(10),
                          Obx(
                                () => Container(
                              height: 23,
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.primarycolor,
                                  )),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                borderRadius:
                                const BorderRadius.all(
                                    Radius.circular(10)),
                                // Initial Value
                                value: renewController
                                    .initial_payment.value
                                    .toString(),
                                // Down Arrow Icon
                                // icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),
                                // Array list of items
                                items: renewController
                                    .paymnet_method
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: tcnw(
                                        items,
                                        AppColors.fontcolor,
                                        12,
                                        TextAlign.center,
                                        FontWeight.w300),
                                  );
                                }).toList(),
                                onChanged: (dynamic value) {
                                  renewController.fnOnChangePayment(value);
                                },
                                // onChanged: (String? newValue) {
                                //   // setState(() {
                                //   //   dropdownvalue = newValue!;
                                //   // });
                                // },
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: CommonButton(
                    buttoncolor: AppColors.primarycolor,
                    icon_need: false,
                    buttonText: "Renew",
                    onpressed: () {
                        renewController.cardnumb.value.isNotEmpty? renewController.fnRenewCard(renewController.renewCharge.value,context):null;

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
