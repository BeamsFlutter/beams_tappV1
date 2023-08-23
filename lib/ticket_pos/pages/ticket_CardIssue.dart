import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:beams_tapp/ticket_pos/controller/tktCardIssueController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../common_widgets/commonbutton.dart';
import '../../constants/color_code.dart';
import '../../constants/string_constant.dart';
import '../../constants/styles.dart';

class TicketCardIssue extends StatefulWidget {
  const TicketCardIssue({super.key});

  @override
  State<TicketCardIssue> createState() => _TicketCardIssueState();
}

class _TicketCardIssueState extends State<TicketCardIssue> {
  final TicketCardIssueController ticketCardIssueController = Get.put(TicketCardIssueController());
  bool showBack = false;

  late FocusNode _focusNode;
  @override
  void initState() {

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: MediaQuery.of(context).padding,
        decoration: boxGradientCLBR(
            AppColors.appReaderBgRed, AppColors.appReaderBgBlue, 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tHead("Beams", AppColors.white, ),
                          tcnH(
                              "VERSION V1.0",
                              AppColors.appBgGreyshde.withOpacity(0.5),
                              10,
                              TextAlign.center,
                              0.11),
                        ],
                      ),
                      tcS("   Fungate ", AppColors.white, 30),
                    ],
                  ),
                  Container(
                    decoration: boxBaseDecoration(
                        AppColors.appReaderDarkBlck.withOpacity(0.36), 23),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20,
                        ),
                        gapWC(6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc("D0001", AppColors.white, 10),
                            tcnH("DEIRA CITY CENTER", AppColors.white, 10,
                                TextAlign.start, 0.95),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.wifi, color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("192.168.0.100", Colors.white, 12, TextAlign.center)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone_android_outlined,
                          color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("9787826367", Colors.white, 12, TextAlign.center)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance,
                          color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("SPLASH AND PARTY LLC.", Colors.white, 12,
                          TextAlign.start)
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: double.maxFinite,
                        decoration: boxBaseDecoration(Colors.white, 30),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tHead2("Card Issue", AppColors.appTicketDarkBlue,),
                            gapHC(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                tSubHead("Search Customer", Colors.grey,TextAlign.center),
                                gapWC(10),
                                Container(

                                  margin: const EdgeInsets.all(5),
                                  // decoration: boxBaseDecoration(Colors.grey.shade100, 30),
                                  child: TextField(
                                    cursorColor:Colors.black,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.search,color: Colors.grey,size: 35),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.black.withOpacity(0.5), width: 1.0),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide:  BorderSide(color: Colors.black.withOpacity(0.5), width: 1.0),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapWC(15),
                    Flexible(
                      flex: 4,
                      child: Obx(() => Container(
                        width: double.maxFinite,
                        decoration: boxBaseDecoration(Colors.white, 30),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 2),
                        child: Column(
                          crossAxisAlignment:ticketCardIssueController.isTapedOncard.value?CrossAxisAlignment.start: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration:boxBaseDecoration(Colors.grey.shade50, 20) ,
                              child: tSubHead("Customer Details", AppColors.appTicketDarkBlue,  TextAlign.start),
                            ),
                            gapHC(8),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [
                                      tHead2("HAKEEM MELANGADI",
                                          AppColors.appTicketDarkBlue,),
                                    ],
                                  ),
                                  gapHC(8),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone_android, size: 15,color: Colors.black,),
                                      gapWC(2),
                                      tBodyBold(
                                        "9723737373",
                                        Colors.black,

                                      ),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    children: [
                                      const Icon(Icons.alternate_email_outlined,color: Colors.black,
                                          size: 15),
                                      gapWC(2),
                                      tBodyBold(
                                        "hakeem.beams@gmail.com",
                                        Colors.black,height1: 0.9

                                      ),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month,color: Colors.black,
                                          size: 15),
                                      gapWC(2),
                                      tBodyBold(
                                        "10-10-1997",
                                        Colors.black,height1: 0.9

                                      ),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    children: [
                                      const Icon(Icons.apartment,color: Colors.black,
                                          size: 15),
                                      gapWC(2),
                                      tBodyBold(
                                        "Dubai",
                                        Colors.black,height1: 0.9
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            gapHC(30),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration:boxBaseDecoration(Colors.grey.shade50, 20) ,
                              child: tSubHead("Tap New Card", AppColors.appTicketDarkBlue,  TextAlign.start),
                            ),
                            gapHC(ticketCardIssueController.isTapedOncard.value?35:15),
                            ticketCardIssueController.isTapedOncard.value?
                            GestureDetector(
                              onTap: (){

                                setState(() {
                                  showBack=!showBack;

                                });
                              },
                              child: CreditCard(

                                  height: 220,horizontalMargin: 33,
                                  cardNumber: " ",
                                  cardHolderName: " ",
                                  cvv: "6778",
                                  bankName: "",
                                  frontTextColor: Colors.black.withOpacity(0.8),
                                  cardType: CardType.other, // Optional if you want to override Card Type
                                  showBackSide: showBack,
                                  // frontBackground: CardBackgrounds.black ,
                                  backBackground: CardBackgrounds.white,
                                  frontBackground:  Center(
                                    child: Container(


                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(AppAssets.splashCard),
                                          fit: BoxFit.cover,
                                        ),

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
                                              Flexible(
                                                child: tBodyBold(
                                                    "HAKEEM",
                                                    Colors.black.withOpacity(0.9),
                                                    ),
                                              ),
                                              const SizedBox(),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              tBody(
                                                  "Splash Card",
                                                  Colors.black.withOpacity(0.9),
                                                  TextAlign.start),
                                              tBodyBold("123123123", Colors.black.withOpacity(0.9),
                                                  ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  showShadow: true,
                                  textExpDate: "",
                                  textName: 'Name',
                                  textExpiry: ''
                              ),
                            )







                                :GestureDetector(
                                onTap: (){
                                  ticketCardIssueController.isTapedOncard.value=true;
                                },
                                child: Image.asset("assets/gifs/removeBg/tapCard1.gif",width: 250,height: 250,fit: BoxFit.contain,)),

                            const Row()



                          ],
                        ),
                      ),)

                    ),
                    gapWC(15),
                    Flexible(
                        flex: 3,
                        child:Obx(() =>  Container(
                          width: double.maxFinite,
                          decoration: boxBaseDecoration(Colors.white, 30),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 2),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tHead2("Recharge", AppColors.appTicketDarkBlue),
                                    gapHC(10),
                                    tSubHead("Enter Amount", Colors.grey, TextAlign.start),
                                    gapHC(5),
                                    Container(
                                      decoration: boxDecoration(Colors.white, 30),

                                      child: TextField(
                                        textAlign: TextAlign.end,controller: ticketCardIssueController.txtAmount,
                                        style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(

                                          contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    gapHC(25),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(child: fixedAmountBox(context, "50")),
                                          gapWC(10),
                                          Flexible(child: fixedAmountBox(context, "100")),
                                        ],
                                      ),
                                    ),
                                    gapHC(15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(child: fixedAmountBox(context, "200")),
                                          gapWC(10),
                                          Flexible(child: fixedAmountBox(context, "500")),
                                        ],
                                      ),
                                    ),
                                    gapHC(25),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            tBody( "Recharge Amount", Colors.black, TextAlign.center),
                                            tHead2("124.00", Colors.black,)
                                          ],
                                        ),
                                        gapHC(10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            tBody( "Registration Amount", Colors.black, TextAlign.center),
                                            tHead2("5.00", Colors.black, )
                                          ],
                                        ),
                                        gapHC(10),
                                        Divider(thickness: 2,color: Colors.black.withOpacity(0.2)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            tHead2("Total Amount", Colors.black, ),
                                            tHead2("129.00", Colors.black, )
                                          ],
                                        ),
                                        Divider(thickness: 2,color: Colors.black.withOpacity(0.2)),
                                        gapHC(10),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.3,
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Colors.greenAccent,
                                                shape:const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(3))) ,
                                                value: ticketCardIssueController.foc.value,
                                                onChanged: (bool? value) {
                                                  ticketCardIssueController.foc.value = value!;

                                                },

                                              ),
                                            ),
                                            tBody("FOC", Colors.black,TextAlign.start)
                                          ],
                                        ),


                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              TcketCommonButton(
                                buttoncolor: AppColors.appTicketColor1,
                                buttonText: "PAY 834.00",
                                icon_need: false,
                                border: Border.all(color:AppColors.appTicketColor1,),
                                radius: 40,buttonTextSize: 18,
                                buttonTextColor: Colors.white,

                                onpressed: (){


                                },


                              ),
                              gapHC(20)


                            ],
                          ),
                        ))

                    )
                  ],
                ),
              ),
            ),
            gapHC(20)
          ],
        ),
      ),
    );
  }

  Widget fixedAmountBox(context,value){
    Size size = MediaQuery.of(context).size;
    return Bounce(
      duration: const Duration(milliseconds: 110),
      onPressed: (){
        ticketCardIssueController.txtAmount.text=value;
      },
      child: Container(

        decoration: boxBaseDecoration(Colors.grey.shade200, 20),
        height: size.height*0.08,width: size.height*0.2,
        child: Center(
          child: tc(value, Colors.black, 16),
        ),
      ),
    );

  }



  //
  // Bounce(
  // duration: const Duration(milliseconds: 110),
  // onPressed: () {
  // ticketCardIssueController.isTapedOncard.value=false;
  // },
  // child: Center(
  // child: Container(
  // margin: EdgeInsets.only(bottom:  ticketCardIssueController.isTapedOncard.value?50:0),
  // height: 160,
  // width: 300,
  // decoration: BoxDecoration(
  // image: const DecorationImage(
  // image: AssetImage(AppAssets.splashCard),
  // fit: BoxFit.cover,
  // ),
  // borderRadius: BorderRadius.circular(25.0),
  // ),
  // padding: const EdgeInsets.only(
  // top: 8, bottom: 8, left: 15, right: 15),
  // child: Column(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceBetween,
  // children: [
  // Row(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceBetween,
  // children: [
  // Flexible(
  // child: tc(
  // "HAKEEM",
  // Colors.black.withOpacity(0.9),
  // 11),
  // ),
  // const SizedBox(),
  // ],
  // ),
  // Row(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceBetween,
  // children: [
  // tc(
  // "Splash Card",
  // Colors.black.withOpacity(0.7),
  // 11),
  // tc("123123123", AppColors.white,
  // 11),
  // ],
  // )
  // ],
  // ),
  // ),
  // ),
  // )
  //



}









//
// Bounce(
// duration: const Duration(milliseconds: 110),
// onPressed: () {
// ticketCardIssueController.isTapedOncard.value=false;
// },
// child: Center(
// child: Container(
// margin: EdgeInsets.only(bottom:  ticketCardIssueController.isTapedOncard.value?50:0),
// height: 160,
// width: 300,
// decoration: BoxDecoration(
// image: const DecorationImage(
// image: AssetImage(AppAssets.splashCard),
// fit: BoxFit.cover,
// ),
// borderRadius: BorderRadius.circular(25.0),
// ),
// padding: const EdgeInsets.only(
// top: 8, bottom: 8, left: 15, right: 15),
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Flexible(
// child: tc(
// "HAKEEM",
// Colors.black.withOpacity(0.9),
// 11),
// ),
// const SizedBox(),
// ],
// ),
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// tc(
// "Splash Card",
// Colors.black.withOpacity(0.7),
// 11),
// tc("123123123", AppColors.white,
// 11),
// ],
// )
// ],
// ),
// ),
// ),
// )