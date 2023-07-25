import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/numbers.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/card_issue/controller/cardissue_controller.dart';
import 'package:beams_tapp/view/card_issue/views/cardissuepending_screen.dart';
import 'package:beams_tapp/view/card_issue/views/qrsceen.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class CardIssueScreen extends StatefulWidget {
  const CardIssueScreen(
      {Key? key, required this.cardIssueFrom, required this.slCode})
      : super(key: key);
  final CardIssueFrom cardIssueFrom;
  final String slCode;

  @override
  State<CardIssueScreen> createState() => _CardIssueScreenState();
}

class _CardIssueScreenState extends State<CardIssueScreen> {

  final CardIssueController cardIssueController = Get.put(CardIssueController());
 // final CommonController commonController = Get.put(CommonController());



  @override
  void initState() {
    dprint("SLCODDDDDDDE>>> ${widget.slCode}");
    dprint("coomm  >>> ${widget.cardIssueFrom}");
    cardIssueController.sl_code.value = widget.slCode;
    cardIssueController.fnClearDetails;
    if (cardIssueController.sl_code.value.isNotEmpty) {
      dprint("Slcode is not empty..........");
      cardIssueController.cstmrdetailLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        cardIssueController.fnCustomerDetails(widget.slCode);
        cardIssueController.fnRegisterAmount();
        Get.back();

      });
    }
    else {
      cardIssueController.cstmrdetailLoading.value = false;
      dprint("Slcode is empty");
      Future.delayed(const Duration(seconds: 2), () {
        cardIssueController.fnRegisterAmount();
      });


    }

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    cardIssueController.fnClearDetails();

  //  cardIssueController.fnClearDetails();
    // cardIssueController.customer_mobile.value = "";
    // cardIssueController.customer_city.value = "";
    // cardIssueController.customer_email.value = "";
    // cardIssueController.customer_dob.value = "";
    // cardIssueController.customer_name.value = "";
    // cardIssueController.cstmrdetailLoading.value = false;
    // cardIssueController.card_show.value = false;
    // cardIssueController.scanCard_enable.value = false;
    // cardIssueController.payment_enable.value = false;
    // cardIssueController.isTaped.value =true;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dprint("PAGE:::>>> ${widget.cardIssueFrom}");
    dprint("SLco::>>> ${widget.slCode}");

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()  {
        return cardIssueController.fnBack(context);

      },
      child: Scaffold(
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(
          title: th(AppStrings.card_issue, AppColors.white, 20),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              cardIssueController.fnBack(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert_rounded, color: Colors.white),
              onPressed: () {
                Get.to(()=>const CardIssuePendingScreen());
              },
            ),
            IconButton(onPressed: (){
              Get.to(() => const QrScren());
            },
                icon: const Icon(Icons.qr_code_scanner,color: AppColors.white,size: 25,))
          ],
          elevation: 0,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleWithUnderLine(title: AppStrings.card_issue),
                  gapHC(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wIconwithTitle(Icons.account_circle_outlined,
                          'Customer Details:', Colors.black, AppColors.fontcolor),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          Get.to(() => LookupSearch(
                            callbackfn: (data) {
                              if(data!=null){
                                dprint("---------------cardisssue");
                                dprint(data);
                                dprint("name:>>>  ${data["SLDESCP"]}");
                                dprint("email:>>>  ${data["EMAIL"]}");
                                dprint("dob:>>>  ${data["DOB"]}");
                                dprint("MOBILE:>>>  ${data["MOBILE"]}");
                                DateTime dob = DateTime.parse(data["DOB"].toString());
                                cardIssueController.customer_mobile.value = data["MOBILE"]??"";
                                cardIssueController.customer_city.value = data["CITY"]??"";
                                cardIssueController.customer_email.value = data["EMAIL"]??"";
                                cardIssueController.customer_dob.value = setDate(13,dob);
                                cardIssueController.customer_name.value = data["SLDESCP"]??"";
                                cardIssueController.sl_code.value = data["SLCODE"]??"";
                                cardIssueController. scanCard_enable.value = true;
                                Get.back();
                              }


                            },
                            table_name: "SLMAST",
                            column_names: const [
                              {"COLUMN": "SLCODE", 'DISPLAY': "Code#: "},
                              {"COLUMN": "SLDESCP", 'DISPLAY': "Name: "},
                              {"COLUMN": "MOBILE", 'DISPLAY': "Mobile No: "},
                              {"COLUMN": "DOB", 'DISPLAY': "N"},
                              {"COLUMN": "EMAIL", 'DISPLAY': "Email: "},
                              {"COLUMN": "CITY", 'DISPLAY': "N"},
                            ],
                            filter: [],
                          )

                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.search,color: AppColors.fontcolor,)),



                      )
                    ],
                  ),


                  gapHC(5),
                  AbsorbPointer(
                    absorbing:
                        widget.cardIssueFrom == CardIssueFrom.home ? true : false,
                    child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: AppColors.lightfontcolor.withOpacity(0.20),
                            borderRadius: BorderRadius.circular(5)),
                        child: Obx(
                          () => (cardIssueController.cstmrdetailLoading.value)
                              ? const Center(
                                  child: SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ts("Name :", AppColors.fontcolor, 12),
                                        gapWC(2),
                                        Expanded(
                                          child: ts(cardIssueController.customer_name.value,
                                              AppColors.fontcolor, 12),
                                        ),
                                      ],
                                    ),
                                    gapHC(3),
                                    Row(
                                      children: [
                                        ts("Email :", AppColors.fontcolor, 12),
                                        gapWC(2),
                                        ts(cardIssueController.customer_email.value,
                                            AppColors.fontcolor, 12),
                                      ],
                                    ),
                                    gapHC(3),
                                    Row(
                                      children: [
                                        ts("DOB :", AppColors.fontcolor, 12),
                                        gapWC(2),
                                        ts(cardIssueController.customer_dob.value??"",
                                            AppColors.fontcolor, 12),
                                      ],
                                    ),
                                    gapHC(3),
                                    Row(
                                      children: [
                                        ts("Mobile :", AppColors.fontcolor, 12),
                                        gapWC(2),
                                        ts(
                                            cardIssueController
                                                .customer_mobile.value,
                                            AppColors.fontcolor,
                                            12),
                                      ],
                                    ),
                                    gapHC(3),
                                    Row(
                                      children: [
                                        ts("City :", AppColors.fontcolor, 12),
                                        gapWC(2),
                                        ts(cardIssueController.customer_city.value,
                                            AppColors.fontcolor, 12)
                                      ],
                                    ),
                                    gapHC(3),
                                  ],
                                ),
                        )),
                  ),
                  gapHC(8),
                  Column(
                    children: [
                      Obx(() =>  AbsorbPointer(
                        absorbing: cardIssueController.scanCard_enable.value == true
                            ? false
                            : true,
                        child: Container(
                          color: AppColors.white,
                          child: Column(
                            children: [
                              wIconwithTitle(
                                  Icons.account_circle_outlined,
                                  'Scan Card',
                                  cardIssueController.scanCard_enable.value == false
                                      ? Colors.grey
                                      : Colors.black,
                                  cardIssueController.scanCard_enable.value == false
                                      ? Colors.grey
                                      : AppColors.fontcolor),
                              gapHC(14),
                              Center(
                                child: Obx(
                                      () => cardIssueController.card_show == false
                                      ? GestureDetector(
                                      onTap: () {
                                        cardIssueController.isTaped.value
                                            ? cardIssueController
                                            .fnTaped(context)
                                            : (cardIssueController
                                            .isAvailable.value
                                            ? null
                                            : cardIssueController
                                            .fnTaped(context));
                                      },
                                      child: cardIssueController.isTaped.value
                                          ? wTaphere()
                                          : (cardIssueController
                                          .isAvailable.value
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
                                                      Flexible(
                                                        child: tc(
                                                            cardIssueController
                                                                .customer_name
                                                                .value,
                                                            AppColors.white,
                                                            11),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      tc(
                                                          cardIssueController
                                                              .cardnumber
                                                              .value.toUpperCase(),
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
                                            cardIssueController.fnResetCard(context);
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
                            ],
                          ),
                        ),
                      ),),
                      gapHC(cardIssueController.card_show == false ? 15 : 12),
                      Obx(() =>   AbsorbPointer(
                        absorbing: cardIssueController.payment_enable.value == true
                            ? false
                            : true,
                        child: Column(
                          children: [
                            wIconwithTitle(
                                Icons.account_circle_outlined,
                                'Payment',
                                cardIssueController.payment_enable.value == true
                                    ? Colors.black
                                    : Colors.grey,
                                cardIssueController.payment_enable.value == true
                                    ? AppColors.fontcolor
                                    : Colors.grey),
                            gapHC(5),
                            Container(
                              width: size.width,
                              height: 300,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: AppColors.lightfontcolor.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        gapHC(5),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            th(
                                                "Register Amount",
                                                cardIssueController
                                                    .payment_enable.value ==
                                                    false
                                                    ? Colors.grey
                                                    : AppColors.fontcolor,
                                                15),
                                            th(
                                                '${cardIssueController.reg_amount.value.toStringAsFixed(2)} AED',
                                                cardIssueController
                                                    .payment_enable ==
                                                    false
                                                    ? Colors.grey
                                                    : AppColors.fontcolor,
                                                15),
                                          ],
                                        ),
                                        gapHC(5),
                                        tsw(
                                            "Top-up card",
                                            cardIssueController.payment_enable.value ==
                                                false
                                                ? Colors.grey
                                                : AppColors.fontcolor,
                                            15,
                                            FontWeight.w700),
                                        gapHC(5),
                                        CommonTextfield(
                                          controller: cardIssueController.txtAmount,
                                          textFormFieldType: TextFormFieldType.amount,
                                          shadow: 30.0,
                                          opacityamount: 0.4,
                                          hintText: 'Enter the amount you want to pay',
                                          paymentEnable:  cardIssueController.payment_enable.value,
                                        ),
                                        gapHC(18),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            wCardAmount("50") ,
                                            wCardAmount("100"),
                                            wCardAmount("300"),
                                            wCardAmount("500"),
                                          ],
                                        ),
                                        gapHC(18),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            ts(
                                                "Payment Method",
                                                cardIssueController
                                                    .payment_enable.value ==
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
                                                      color: cardIssueController
                                                          .payment_enable.value ==
                                                          false
                                                          ? Colors.grey
                                                          : AppColors.primarycolor,
                                                    )),
                                                child: DropdownButton(
                                                  underline: const SizedBox(),
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                                  // Initial Value
                                                  value: cardIssueController
                                                      .initial_payment.value
                                                      .toString(),
                                                  // Down Arrow Icon
                                                  // icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),
                                                  // Array list of items
                                                  items: cardIssueController
                                                      .paymnet_method
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: tcnw(
                                                          items,
                                                          cardIssueController.payment_enable.value ? AppColors.fontcolor:Colors.grey ,
                                                          12,
                                                          TextAlign.center,
                                                          FontWeight.w300),
                                                    );
                                                  }).toList(),
                                                  onChanged: (dynamic value) {
                                                    cardIssueController
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
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                    child: CommonButton(
                                      buttoncolor:
                                      cardIssueController.payment_enable.value ==
                                          false
                                          ? Colors.grey
                                          : AppColors.primarycolor,
                                      icon_need: false,
                                      buttonText: "Pay  ${cardIssueController.reg_amount.value+ mfnDbl(cardIssueController.txtAmount.value.text) }",
                                      onpressed: () {

                                        cardIssueController.fnPay(context, cardIssueController.cardnumber.value,
                                            cardIssueController.initial_payment.value, cardIssueController.reg_amount.value,cardIssueController.sl_code.value,cardIssueController.txtAmount.text);
                                      },
                                    ),
                                  ),
                                  gapHC(10)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),),

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
        tsw("Retry",AppColors.lightfontcolor, 15,FontWeight.w500)

      ],
    );
  }
  wCardAmount(value){
    return Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: (){
          cardIssueController.txtAmount.text =value;
          setState(() {

          });
        },
        child: Material(
          elevation: 30,
          shadowColor:  AppColors.lightfontcolor.withOpacity(0.4),
          child: Container(

              height: 45,width: 45,
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius:BorderRadius.circular(1)
              ),
              child: Center(child:  tcnw(value,cardIssueController.payment_enable.value ? AppColors.fontcolor:Colors.grey ,16, TextAlign.center, FontWeight.w500))),
        )
    );
  }
  // Widget wBuildQrView(BuildContext context,) {
  //   return QRView(
  //     key: registerController.qrKey,
  //     overlay: QrScannerOverlayShape(
  //       cutOutSize:MediaQuery.of(context).size.width * 0.75,
  //       borderLength: 10 * 3.0,
  //       borderRadius: 2,
  //       borderWidth: 10 * 1.0,
  //
  //     ),
  //     onQRViewCreated: registerController.fnOnQRViewCreated,);
  // }

}


