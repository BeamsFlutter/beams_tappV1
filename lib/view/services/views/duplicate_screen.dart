import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/services/controller/duplicate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class DuplicateScreen extends StatefulWidget {
  const DuplicateScreen({Key? key}) : super(key: key);

  @override
  State<DuplicateScreen> createState() => _DuplicateScreenState();
}

class _DuplicateScreenState extends State<DuplicateScreen> {
  final DuplicateController duplicateController =
      Get.put(DuplicateController());
  @override
  void dispose() {
    duplicateController.fnResetOldCard(context);
    duplicateController.fnResetNewCard(context);
    // TODO: implement dispose
    super.dispose();
  }
@override
  void initState() {
  Future.delayed(const Duration(seconds: 2), () {
    duplicateController.fnServieceCharge();


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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              dprint("search");
              Get.to(() => LookupSearch(
                callbackfn: (data) {
                  if(data!=null){
                    duplicateController.isOldCradTaped.value =true;
                    duplicateController.old_card_show.value = true;
                    dprint("CARDNUMBER:>>>  ${data["CARDNO"]}");
                    duplicateController.fnCardDetails(data["CARDNO"],"N","O");
                    duplicateController.old_cardnumb.value = data["CARDNO"];
                    duplicateController.sl_code.value = data["SLCODE"];
                    Get.back();
                  }


                },
                table_name: "(SELECT A.SLCODE,B.SLDESCP,B.MOBILE,B.EMAIL,A.CARDNO FROM CUSTOMER_CARDS A LEFT JOIN SLMAST B ON (A.SLCODE =  B.SLCODE)) AS TABLE1",
                column_names: const [
                  {"COLUMN": "CARDNO", 'DISPLAY': "Card No: "},
                  {"COLUMN": "SLDESCP", 'DISPLAY': "Name: "},
                  {"COLUMN": "SLCODE", 'DISPLAY': "Slcode: "},
                  {"COLUMN": "MOBILE", 'DISPLAY':"Mobile No:"}
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
              child: Obx(() => Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleWithUnderLine(
                            title: "Duplicate",
                          ),
                          gapHC(20),
                          Center(
                            child: Obx(
                              () => duplicateController.old_card_show.value == false
                                  ? GestureDetector(
                                      onTap: () {
                                        duplicateController.isOldCradTaped.value

                                            ? duplicateController.fnTaped(
                                                context, "O")
                                            : (duplicateController
                                                        .isOldCardAvailable.value
                                                ? null
                                                : duplicateController.fnTaped(
                                                    context, "O"));
                                      },
                                      child: duplicateController.isOldCradTaped.value
                                              ? wTaphere()
                                              : (duplicateController.isOldCardAvailable.value
                                                  ? wHoldcard()
                                                  : wNotAvilble()))
                                  : Align(
                                      heightFactor: 0.86,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Bounce(
                                              duration: const Duration(
                                                  milliseconds: 110),
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 8,
                                                    left: 15,
                                                    right: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(),
                                                        tc(
                                                            duplicateController
                                                                .customer_name
                                                                .value
                                                                .toString().toUpperCase(),
                                                            AppColors.white,
                                                            11)
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        tc(
                                                            duplicateController
                                                                .old_cardnumb
                                                                .value
                                                                .toString().toUpperCase(),
                                                            AppColors.white,
                                                            11),
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
                                            duration: const Duration(
                                                milliseconds: 110),
                                            onPressed: () {
                                              dprint("reset");
                                              duplicateController.fnResetOldCard(context);
                                              // duplicateController.fnTaped(
                                              //     context, "O");
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightfontcolor
                                                        .withOpacity(0.20),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
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
                          duplicateController.showCardDetails.value
                              ? Container(
                                  width: size.width,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightfontcolor
                                          .withOpacity(0.20),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ts("Name:", AppColors.fontcolor, 12),
                                          gapWC(5),
                                          ts(
                                              duplicateController
                                                  .customer_name.value
                                                  .toString().toUpperCase(),
                                              AppColors.fontcolor,
                                              12),
                                        ],
                                      ),
                                      gapHC(3),
                                      Row(
                                        children: [
                                          ts("Email:", AppColors.fontcolor, 12),
                                          gapWC(5),
                                          ts(
                                              duplicateController
                                                  .customer_email.value
                                                  .toString(),
                                              AppColors.fontcolor,
                                              12),
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
                                          ts("Mobile:", AppColors.fontcolor,
                                              12),
                                          gapWC(5),
                                          ts(
                                              duplicateController
                                                  .customer_mobile.value
                                                  .toString(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          tcnw(
                                              "Remaining Bal:",
                                              AppColors.fontcolor,
                                              18,
                                              TextAlign.center,
                                              FontWeight.w600),
                                          th(duplicateController.customer_remaingblnce.value.toString(), AppColors.fontcolor, 18),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          gapHC(20),
                          Divider(thickness: 3),
                          gapHC(10),
                          AbsorbPointer(
                            absorbing: duplicateController.newCardenable.value
                                ? false
                                : true,
                            child: Column(
                              children: [
                                wIconwithTitle(
                                    Icons.credit_card,
                                    "New Card",
                                    duplicateController.newCardenable.value ==
                                            false
                                        ? Colors.grey
                                        : AppColors.fontcolor,
                                    duplicateController.newCardenable.value ==
                                            false
                                        ? Colors.grey
                                        : AppColors.fontcolor),
                                gapHC(10),
                                Center(
                                  child: Obx(
                                    () => duplicateController.new_card_show.value ==
                                            false
                                        ? GestureDetector(
                                            onTap: () {
                                              duplicateController.isNewCardCradTaped.value
                                                  ? duplicateController.fnTaped(
                                                      context, "N")
                                                  : (duplicateController
                                                          .isNewCardAvailable.value
                                                      ? null
                                                      : duplicateController
                                                          .fnTaped(
                                                              context, "N"));
                                            },
                                            child: duplicateController
                                                    .isNewCardCradTaped.value
                                                ? wTaphere()
                                                : (duplicateController
                                                        .isNewCardAvailable.value
                                                    ? wHoldcard()
                                                    : wNotAvilble()))
                                        : Align(
                                            heightFactor: 0.86,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Bounce(
                                                    duration: const Duration(
                                                        milliseconds: 110),
                                                    onPressed: () {},
                                                    child: Container(
                                                      height:
                                                          150,
                                                      decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                              AppAssets.splashCard),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 8,
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const SizedBox(),
                                                              tc(
                                                                  "",
                                                                  AppColors
                                                                      .white,
                                                                  11)
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              tc(
                                                                  duplicateController
                                                                      .new_cardnumb
                                                                      .value
                                                                      .toString().toUpperCase(),
                                                                  AppColors
                                                                      .white,
                                                                  11),
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
                                                  duration: const Duration(
                                                      milliseconds: 110),
                                                  onPressed: () {
                                                    dprint("reset");
                                                    duplicateController.fnResetNewCard(context);
                                                    // duplicateController.fnTaped(context, "N");
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .lightfontcolor
                                                              .withOpacity(
                                                                  0.20),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Icon(
                                                          Icons
                                                              .refresh_outlined,
                                                          size: 15,
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                  ),
                                ),

                                /////////////
                                gapHC(10),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    th(
                                        "Service Charge",
                                        duplicateController
                                                    .newCardenable.value ==
                                                false
                                            ? Colors.grey
                                            : AppColors.fontcolor,
                                        15),
                                    th(
                                        '${duplicateController.servieceCharge.toStringAsFixed(2)} AED',
                                        duplicateController
                                                    .newCardenable.value ==
                                                false
                                            ? Colors.grey
                                            : AppColors.fontcolor,
                                        15),
                                  ],
                                ),
                                gapHC(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ts(
                                        "Payment Method",
                                        duplicateController
                                                    .newCardenable.value ==
                                                false
                                            ? Colors.grey
                                            : AppColors.fontcolor,
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
                                              color: duplicateController
                                                          .newCardenable
                                                          .value ==
                                                      false
                                                  ? Colors.grey
                                                  : AppColors.primarycolor,
                                            )),
                                        child: DropdownButton(
                                          underline: const SizedBox(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          // Initial Value
                                          value: duplicateController
                                              .initial_payment.value
                                              .toString(),
                                          // Down Arrow Icon
                                          // icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),
                                          // Array list of items
                                          items: duplicateController
                                              .paymnet_method
                                              .map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: tcnw(
                                                  items,
                                                  duplicateController
                                                              .newCardenable
                                                              .value ==
                                                          false
                                                      ? Colors.grey
                                                      : AppColors.fontcolor,
                                                  12,
                                                  TextAlign.center,
                                                  FontWeight.w300),
                                            );
                                          }).toList(),
                                          onChanged: (dynamic value) {
                                            duplicateController
                                                .fnOnChangePayment(value);
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
                          )
                        ],
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CommonButton(
                          buttoncolor:
                              duplicateController.newCardenable.value == false
                                  ? Colors.grey
                                  : AppColors.primarycolor,
                          icon_need: false,
                          buttonText: "Duplicate",
                          onpressed: () {
                             duplicateController.new_cardnumb.value.isNotEmpty? duplicateController.fnDuplicate(duplicateController.sl_code.value, duplicateController.new_cardnumb.value):null;
                          },
                        ),
                      ),
                      gapHC(10)
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  ///////Widget.......................................

  wIconwithTitle(IconData icon, String title, iconColor, textColor) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
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
