import 'package:beams_tapp/common_widgets/masterMenus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../constants/color_code.dart';
import '../../../constants/common_functn.dart';
import '../../../constants/inputFormattor.dart';
import '../../../constants/styles.dart';
import '../../controllers/masterController/masterPlayAreaController.dart';

class MasterPlayAreaScreen extends StatefulWidget {
  const MasterPlayAreaScreen({super.key});

  @override
  State<MasterPlayAreaScreen> createState() => _MasterPlayAreaScreenState();
}

class _MasterPlayAreaScreenState extends State<MasterPlayAreaScreen> {
  final MasterPlayAreaController masterPlayAreaController =
      Get.put(MasterPlayAreaController());

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Obx(() => Container(
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
                              masterPlayAreaController.wstrPageMode.value =
                                  "VIEW";
                            }, masterPlayAreaController.wstrPageMode.value),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 6,
                                  child: Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        gapHC(20),
                                        tBody("Code", AppColors.appAdminColor2,
                                            TextAlign.start),

                                        wCommonTextFieldAdminV1(
                                          Get.find<MasterPlayAreaController>()
                                              .txtCountercode
                                              .value,
                                          200.0,
                                        ),
                                        gapHC(10),
                                        tBody("Name", AppColors.appAdminColor2,
                                            TextAlign.start),
                                        SizedBox(
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.6,
                                          child: TextField(
                                            controller: masterPlayAreaController
                                                .txtCounterName.value,
                                            cursorColor: Colors.black,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 13),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .appAdminColor2),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 5,
                                                      left: 8,
                                                      top: 15),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .appAdminColor2),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                            onChanged: (String? value) {
                                              masterPlayAreaController
                                                  .lstrCounterName
                                                  .value = value!;
                                            },
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 40,
                                        //   width: 300,
                                        //   child: Material(
                                        //     elevation: 2.0,
                                        //     shadowColor: Colors.grey.shade100,
                                        //     shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //         BorderRadius.circular(20)),
                                        //     child: TextField(
                                        //       controller: masterPlayAreaController
                                        //           .txtCounterName.value,
                                        //       cursorColor: Colors.black,
                                        //       decoration: InputDecoration(
                                        //         enabledBorder: OutlineInputBorder(
                                        //           borderSide: BorderSide(
                                        //               color: AppColors.white),
                                        //           borderRadius:
                                        //           BorderRadius.circular(30.0),
                                        //         ),
                                        //         fillColor: AppColors.white,
                                        //         contentPadding: EdgeInsets.only(
                                        //             bottom: 5, left: 8),
                                        //         focusedBorder: OutlineInputBorder(
                                        //           borderSide: BorderSide(
                                        //               color: AppColors.white),
                                        //           borderRadius:
                                        //           BorderRadius.circular(30.0),
                                        //         ),
                                        //       ),
                                        //       onChanged: (String value) {
                                        //         masterPlayAreaController
                                        //             .lstrCounterName.value = value;
                                        //
                                        //         // masterPlayAreaController.txtCounterName.value.text=value;
                                        //       },
                                        //     ),
                                        //   ),
                                        // ),

                                        gapHC(10),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  tBody(
                                                      "Duration",
                                                      AppColors.appAdminColor2,
                                                      TextAlign.start),
                                                  wCommonTextFieldAdminV1(
                                                    Get.find<
                                                            MasterPlayAreaController>()
                                                        .txtduration
                                                        .value,
                                                    100.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            gapWC(10),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  tBody(
                                                      "Max.Guest",
                                                      AppColors.appAdminColor2,
                                                      TextAlign.start),
                                                  wCommonTextFieldAdminV1(
                                                    Get.find<
                                                            MasterPlayAreaController>()
                                                        .txtMaxGuest
                                                        .value,
                                                    100.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            gapWC(10),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  tBody(
                                                      "Price",
                                                      AppColors.appAdminColor2,
                                                      TextAlign.start),

                                                  SizedBox(
                                                    height: 35,
                                                    width: 100,
                                                    child: TextField(
                                                      controller:
                                                          masterPlayAreaController
                                                              .txtCounterPrice
                                                              .value,
                                                      cursorColor: Colors.black,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      inputFormatters:
                                                          InputFormattor
                                                              .mfnInputDecFormatters(),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          borderSide: BorderSide(
                                                              color: AppColors
                                                                  .appAdminColor2),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5,
                                                                left: 8,
                                                                top: 15),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: AppColors
                                                                  .appAdminColor2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                      ),
                                                      onChanged:
                                                          (String? value) {
                                                        masterPlayAreaController
                                                            .lstrCounterPrice
                                                            .value = value!;
                                                      },
                                                    ),
                                                  ),

                                                  // SizedBox(
                                                  //   height: 40,
                                                  //   width: 100,
                                                  //   child: Material(
                                                  //     elevation: 2.0,
                                                  //     shadowColor: Colors.grey.shade100,
                                                  //     shape: RoundedRectangleBorder(
                                                  //         borderRadius:
                                                  //         BorderRadius.circular(20)),
                                                  //     child: TextField(
                                                  //       controller: Get.find<
                                                  //           MasterPlayAreaController>()
                                                  //           .txtCounterPrice
                                                  //           .value,
                                                  //       cursorColor: Colors.black,
                                                  //       inputFormatters: InputFormattor
                                                  //           .mfnInputDecFormatters(),
                                                  //       decoration: InputDecoration(
                                                  //         enabledBorder:
                                                  //         OutlineInputBorder(
                                                  //           borderSide: BorderSide(
                                                  //               color: AppColors
                                                  //                   .white),
                                                  //           borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(30.0),
                                                  //         ),
                                                  //         fillColor:
                                                  //         AppColors.white,
                                                  //         contentPadding:
                                                  //         EdgeInsets.only(
                                                  //             bottom: 5,
                                                  //             left: 8),
                                                  //         focusedBorder:
                                                  //         OutlineInputBorder(
                                                  //           borderSide: BorderSide(
                                                  //               color: AppColors
                                                  //                   .white),
                                                  //           borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(30.0),
                                                  //         ),
                                                  //       ),
                                                  //       onChanged: (value) {
                                                  //         masterPlayAreaController
                                                  //             .lstrCounterPrice
                                                  //             .value = value;
                                                  //       },
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        gapHC(25),
                                        tBody(
                                            "Choose Theme",
                                            AppColors.appAdminColor2,
                                            TextAlign.start),
                                        gapHC(20),
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  wThemeSelectionbutton(() {
                                                    masterPlayAreaController
                                                        .selectTheme
                                                        .value = "a";
                                                  }, "a", Colors.amber),
                                                  gapWC(20),
                                                  wThemeSelectionbutton(() {
                                                    masterPlayAreaController
                                                        .selectTheme
                                                        .value = "b";
                                                  }, "b", Colors.blue),
                                                  gapWC(20),
                                                  wThemeSelectionbutton(() {
                                                    masterPlayAreaController
                                                        .selectTheme
                                                        .value = "o";
                                                  }, "o", Colors.orange),
                                                ],
                                              ),
                                              gapHC(20),
                                              Row(
                                                children: [
                                                  wThemeSelectionbutton(() {
                                                    masterPlayAreaController
                                                        .selectTheme
                                                        .value = "g";
                                                  }, "g", Colors.green),
                                                  gapWC(20),
                                                  wThemeSelectionbutton(() {
                                                    masterPlayAreaController
                                                        .selectTheme
                                                        .value = "r";
                                                  },
                                                      "r",
                                                      AppColors
                                                          .appTicketLIGHTRED),
                                                  gapWC(20),
                                                  wThemeSelectionbutton(() {
                                                    masterPlayAreaController
                                                        .selectTheme
                                                        .value = "br";
                                                  }, "br", Colors.brown),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              masterPlayAreaController.phoneMode.value == true
                                  ? Obx(() => Flexible(
                                        flex: 4,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 30, bottom: 20),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: boxDecoration1(
                                                    Colors.blueAccent
                                                        .withOpacity(0.2),
                                                    30),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Container(
                                                    decoration:
                                                        boxBaseDecoration(
                                                            (masterPlayAreaController
                                                                        .selectTheme
                                                                        .value ==
                                                                    'a')
                                                                ? Colors.amber
                                                                : (masterPlayAreaController
                                                                            .selectTheme
                                                                            .value ==
                                                                        'g')
                                                                    ? Colors
                                                                        .greenAccent
                                                                    : (masterPlayAreaController.selectTheme.value ==
                                                                            'b')
                                                                        ? Colors
                                                                            .blue
                                                                        : (masterPlayAreaController.selectTheme.value ==
                                                                                'r')
                                                                            ? AppColors.appTicketLIGHTRED
                                                                            : (masterPlayAreaController.selectTheme.value == 'o')
                                                                                ? Colors.orange
                                                                                : (masterPlayAreaController.selectTheme.value == 'br')
                                                                                    ? Colors.brown
                                                                                    : null,
                                                            30),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        10),
                                                                child: Stack(
                                                                    clipBehavior:
                                                                        Clip
                                                                            .none,
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    children: [
                                                                      Container(
                                                                        width: double
                                                                            .maxFinite,
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                40,
                                                                            vertical:
                                                                                30),
                                                                        decoration: boxBaseDecoration(
                                                                            Colors.white,
                                                                            20),
                                                                        child: Image
                                                                            .network(
                                                                          "https://clipart-library.com/images/8ixK8bzBT.png",
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          width:
                                                                              80,
                                                                          height:
                                                                              90,
                                                                          errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Container(
                                                                              color: Colors.white,
                                                                              alignment: Alignment.center,
                                                                              child: Container(
                                                                                child: Image.asset(
                                                                                  "assets/gifs/train.gif",
                                                                                  fit: BoxFit.contain,
                                                                                  width: 70,
                                                                                  height: 70,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        bottom:
                                                                            -12,
                                                                        left: 1,
                                                                        right:
                                                                            1,
                                                                        child:
                                                                            Bounce(
                                                                          duration:
                                                                              const Duration(milliseconds: 110),
                                                                          onPressed:
                                                                              () {
                                                                            dprint("ONtAP EDIT");
                                                                            masterPlayAreaController.pickImage();
                                                                          },
                                                                          child:
                                                                              CircleAvatar(
                                                                            radius:
                                                                                15,
                                                                            backgroundColor:
                                                                                AppColors.appTicketColor1,
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Icon(Icons.edit, color: Colors.white, size: 12),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),

                                                              tcTone(
                                                                  masterPlayAreaController
                                                                      .lstrCounterName
                                                                      .value,
                                                                  Colors.white
                                                                      .withOpacity(
                                                                          0.9),
                                                                  30),
                                                              gapHC(10),

                                                              Column(
                                                                children: [
                                                                  Text("PRICE",
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight: FontWeight
                                                                              .w200,
                                                                          color: Colors.black87.withOpacity(
                                                                              0.9),
                                                                          height:
                                                                              0.9),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start),
                                                                  // tcSH(

                                                                  //   AppColors.white
                                                                  //       .withOpacity(0.9),40,
                                                                  //   0.9
                                                                  // ),
                                                                  gapHC(2),
                                                                  Text(
                                                                      masterPlayAreaController
                                                                          .lstrCounterPrice
                                                                          .toString(),
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              40,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: AppColors.white.withOpacity(
                                                                              0.9),
                                                                          height:
                                                                              0.9),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start)
                                                                ],
                                                              ),
                                                              gapHC(10),
                                                              Column(
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/gifs/removeBg/tap.gif",
                                                                      width: 70,
                                                                      height:
                                                                          70,
                                                                      color: Colors
                                                                          .black38),
                                                                  tcn(
                                                                      "Tap to Play",
                                                                      Colors
                                                                          .black38,
                                                                      20,
                                                                      TextAlign
                                                                          .center),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              boxBaseDecoration(
                                                                  Colors.grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  20),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 12),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 15,
                                                                  left: 15),
                                                          child: tHead2(
                                                            "ACTIVE GUEST  34",
                                                            AppColors
                                                                .appReaderDarkbGbLUE,
                                                          ),
                                                        ),
                                                        gapHC(10)
                                                      ],
                                                    )),
                                              ),
                                              Positioned(
                                                  top: 1,
                                                  right: 1,
                                                  child: Bounce(
                                                    onPressed: () {
                                                      masterPlayAreaController
                                                          .phoneMode
                                                          .value = false;
                                                    },
                                                    duration: Duration(
                                                        milliseconds: 110),
                                                    child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundColor:
                                                          Colors.black,
                                                      child: Icon(Icons.close,
                                                          color: Colors.white,
                                                          size: 14),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ))
                                  : Flexible(
                                      flex: 4,

                                      child: Bounce(
                                        duration: Duration(milliseconds: 110),
                                        onPressed: () {
                                          masterPlayAreaController
                                              .phoneMode.value = true;
                                          dprint(masterPlayAreaController
                                              .phoneMode.value);
                                        },
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: boxDecoration1(
                                                Colors.blueAccent
                                                    .withOpacity(0.2),
                                                30),
                                            child: Center(
                                                child:        Icon(
                                                  Icons.phone_android_rounded,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),                                          ),
                                        ),),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ))
      ],
    );
  }

  Widget wThemeSelectionbutton(VoidCallback ontap, themeVal, color) {
    return Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: ontap,
      child: Container(
        width: 90,
        height: 110,
        decoration: boxDecoration1(Colors.grey.shade200, 15),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 8,
                backgroundColor:
                    (masterPlayAreaController.selectTheme.value == themeVal)
                        ? AppColors.appTicketColor1
                        : Colors.grey,
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 7),
              decoration: boxBaseDecoration(color, 10),
              child: Center(child: tcn("H", Colors.white, 25, TextAlign.start)),
            )
          ],
        ),
      ),
    );
  }
}
