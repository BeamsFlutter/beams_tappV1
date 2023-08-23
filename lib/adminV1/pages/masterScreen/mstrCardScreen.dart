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

class MasterCard extends StatefulWidget {
  const MasterCard({super.key});

  @override
  State<MasterCard> createState() => _MasterCardState();
}

class _MasterCardState extends State<MasterCard> {
  final MasterCardController mastercardcontroller =
  Get.put(MasterCardController());
  @override
  void initState() {
    mastercardcontroller.focusNode = FocusNode();
    mastercardcontroller.focusNode.addListener(() {

        mastercardcontroller.focusNode.hasFocus ? mastercardcontroller.showBack.value = true :
        mastercardcontroller.showBack.value = false;

    });

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
              child:  Column(
                children: [
                  Container(
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
                            mastercardcontroller.wstrPageMode.value="VIEW";

                          }, mastercardcontroller.wstrPageMode.value),
                        ),
                        gapHC(20),

                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tBody("Code", AppColors.appAdminColor2,
                                      TextAlign.start),
                                  wCommonTextFieldAdminV1(mastercardcontroller
                                      .txtCode.value,)
                                ],
                              ),
                            ),
                            gapWC(20),
                            Flexible(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tBody("Card Name", AppColors.appAdminColor2,
                                      TextAlign.start),
                                  wCommonTextFieldAdminV1(mastercardcontroller
                                      .txtCardName.value,
                                     double.maxFinite,)
                                ],
                              ),
                            ),
                          ],
                        ),
                        gapHC(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tBody("Detail Description", AppColors.appAdminColor2,
                                TextAlign.start),

                            wCommonTextFieldAdminV1(mastercardcontroller
                                .txtDetailDisc.value,
                                MediaQuery.of(context).size.width/3,)

                          ],
                        ),
                        gapHC(20),





                      ],
                    ),
                  ),
                  gapHC(10),

                  Expanded(
                    child: Container(        padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                      decoration: boxBaseDecoration(Colors.white, 6),

                      child: Column(
                        children: [
                          Container(
                              width: double.maxFinite,

                              decoration: boxBaseDecoration(
                                  AppColors.appAdminBgLightBlue, 6),
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              child: tBodyBold("Choose Theme", Colors.black)
                          ),
                          gapHC(20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tBody("Background Image", AppColors.appAdminColor2,
                                        TextAlign.start),
                                    Container(
                                      width: 250,
                                      decoration: boxOutlineCustom(Colors.white, 30,Colors.black87),
                                      child: const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Icon(Icons.image_outlined,color: Colors.black,),
                                          )
                                        ],
                                      ),

                                    ),
                                    gapHC(10),
                                    tBody("Font Color", AppColors.appAdminColor2,
                                        TextAlign.start),
                                    Obx(() =>   Bounce(
                                      duration: Duration(milliseconds: 110),
                                      onPressed: (){
                                        mastercardcontroller.wPickerDialog();
                                      },
                                      child: Container(
                                        width: 250,
                                        decoration: boxOutlineCustom(Colors.white, 30,Colors.black87),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.circle,color: mastercardcontroller.currentColor.value,),
                                                  gapWC(5),
                                                  tBody("#${mastercardcontroller.lstrFontColor.value.toString().substring(0,mastercardcontroller.lstrFontColor.value.length-1)}", AppColors.appAdminColor2, TextAlign.start)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                      ),
                                    ),)
                                  ],
                                ),
                              ),
                              Flexible(flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tBody("       Preview", AppColors.appAdminColor2,
                                        TextAlign.start),
                                    gapHC(10),
                                    Obx(() =>  GestureDetector(
                                      onTap: (){


                                        mastercardcontroller.showBack.value=!mastercardcontroller.showBack.value;

                                      },
                                      child: CreditCard(

                                          height: 170,
                                          cardNumber: " ",
                                          cardHolderName: " ",
                                          cvv: "6778",


                                          frontTextColor: Colors.black.withOpacity(0.8),
                                          cardType: CardType.other, // Optional if you want to override Card Type
                                          showBackSide: mastercardcontroller.showBack.value,
                                          // frontBackground: CardBackgrounds.black ,
                                          backBackground: CardBackgrounds.white,
                                          frontBackground:  Container(
                                            decoration:  BoxDecoration(
                                              color: mastercardcontroller.currentColor.value,
                                              borderRadius: BorderRadius.circular(10),
                                              // image: DecorationImage(
                                              //   image: AssetImage(AppAssets.splashCard),
                                              //   fit: BoxFit.cover,
                                              // ),

                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 15, bottom: 8, left: 20, right: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [


                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // tBody("Splash Card", Colors.black, TextAlign.start),
                                                    tBodyBold("SPLASH", Colors.black,),
                                                    tBodyBold("12312 34355", Colors.black),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          showShadow: false,
                                          textExpDate: "",
                                          textName: 'Name',
                                          textExpiry: ''
                                      ),
                                    ),)
                                  ],
                                ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ))
      ],
    );
  }



}
