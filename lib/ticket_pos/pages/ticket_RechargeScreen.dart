import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/view/services/views/numPad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../common_widgets/commonbutton.dart';
import '../../common_widgets/tabButton.dart';
import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/string_constant.dart';
import '../../constants/styles.dart';
import '../controller/tktRechargeController.dart';

class TicketRechargeScreen extends StatefulWidget {
  const TicketRechargeScreen({super.key});

  @override
  State<TicketRechargeScreen> createState() => _TicketRechargeScreenState();
}

class _TicketRechargeScreenState extends State<TicketRechargeScreen> {
  final TicketRechargeController ticketRechargeController =
  Get.put(TicketRechargeController());
  bool showBack = false;
  late FocusNode _focusNode;



  @override
  void initState() {
    ticketRechargeController.pageController = PageController();
    ticketRechargeController.selectedPage.value = 0;
    ticketRechargeController.lstrSelectedPage.value = "AP";
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
    dprint("Call Dispose...");
    _focusNode.dispose();
    // ticketRechargeController.txtAmount.dispose();

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => Container(
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
                          tHead("Beams", AppColors.white,),
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
                      tcn("192.168.0.100", Colors.white, 12,
                          TextAlign.center)
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: boxBaseDecoration(Colors.white, 30),
                        padding: const EdgeInsets.only(
                            left: 20,right: 20,top: 10,bottom: 2
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tHead2("Recharge", AppColors.appTicketDarkBlue),
                            gapHC(10),
                            GestureDetector(
                              onTap: (){

                                setState(() {
                                  showBack=!showBack;

                                });
                              },
                              child: CreditCard(

                                  height: 170,
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
                                                child: tBodyBold("HAKEEM", Colors.black,),
                                              ),
                                              const SizedBox(),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              tBody("Splash Card", Colors.black, TextAlign.start),
                                              tBodyBold("12312 34355", Colors.black),
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
                            ),
                            gapHC(10),
                            Row(
                              children: [
                                tHead2("HAKEEM MELANGADI",
                                    Colors.black,),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.phone_android, size: 13),
                                gapWC(2),
                                tBodyBold(
                                  "9723737373",
                                  Colors.grey.shade500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.alternate_email_outlined,
                                    size: 13),
                                gapWC(2),
                                tBodyBold(
                                  "hakeem.beams@gmail.com",
                                   Colors.grey.shade500,
                                  height1: 0.8

                                ),
                              ],
                            ),
                            gapHC(10),

                            Container(
                              decoration: boxBaseDecoration(
                                  Colors.greenAccent.withOpacity(0.8), 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  tSubHead("Balance", Colors.black,
                                      TextAlign.center),
                                  tHead2("300.00",
                                      Colors.black.withOpacity(0.7))
                                ],
                              ),
                            ),
                            //     Divider(thickness: 2,indent: 50,endIndent: 50),
                            gapHC(20),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              decoration: boxDecoration(Colors.white, 30),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: TabButton(
                                      radius: 30.0,              tabColor: AppColors.appTicketDarkBlue,
                                      width: 0.3,
                                      text: "Package",
                                      pageNumber: 0,
                                      selectedPage: ticketRechargeController
                                          .selectedPage.value,
                                      onPressed: () {
                                        ticketRechargeController
                                            .lstrSelectedPage.value = "AP";
                                        changePage(0);
                                      },
                                    ),
                                  ),
                                  gapWC(3),
                                  Flexible(
                                    child: TabButton(
                                      radius: 30.0,
                                      width: 0.3,              tabColor: AppColors.appTicketDarkBlue,
                                      text: "Last Transaction",
                                      pageNumber: 1,
                                      selectedPage: ticketRechargeController
                                          .selectedPage.value,
                                      onPressed: () {
                                        ticketRechargeController
                                            .lstrSelectedPage.value = "LT";
                                        changePage(1);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                onPageChanged: (int page) {
                                  ticketRechargeController
                                      .selectedPage.value = page;
                                },
                                controller:
                                ticketRechargeController.pageController,
                                children: [
                                  wActivePackage(),
                                  wLastTransaction(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapWC(20),
                    Flexible(
                      flex: 7,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: 20,right: 20,top: 10,bottom: 2
                        ),
                        decoration: boxBaseDecoration(Colors.white, 30),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tHead2("Choose Package", Colors.black),
                            gapHC(3),
                            Obx(() =>    Flexible(
                                flex: 4,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: ticketRechargeController.lstrPackages.value.length,
                                    itemBuilder: (context,index){
                                      var packageName = ticketRechargeController
                                          .lstrPackages.value[index]["title"];
                                      var packageRate = ticketRechargeController
                                          .lstrPackages.value[index]["packageRate"];
                                      var itemName1 = ticketRechargeController
                                          .lstrPackages.value[index]["itemName1"];
                                      var itemName2 = ticketRechargeController
                                          .lstrPackages.value[index]["itemName2"];
                                      var itemName3 = ticketRechargeController.lstrPackages.value[index]["itemName3"];
                                      var count = (ticketRechargeController.lstrPackages[index]["count"]??"").toString();
                                      var itemCode = (ticketRechargeController.lstrPackages.value[index]["code"]??"").toString();


                                      return Padding(
                                        padding: const EdgeInsets.only(right: 20,top: 12),
                                        child: Column(
                                          children: [
                                            badges.Badge(
                                              badgeAnimation: badges.BadgeAnimation.fade(),

                                              position: badges.BadgePosition.bottomEnd(bottom: 5, end: -6),
                                              showBadge: mfnInt(ticketRechargeController.lstrPackages[index]["count"])==0?false:true,
                                              ignorePointer: false,
                                              badgeContent: tc(count.toString(), AppColors.appTicketDarkBlue, 16),
                                              badgeStyle: badges.BadgeStyle(
                                                shape: badges.BadgeShape.circle,
                                                badgeColor: Colors.yellow,
                                                padding: EdgeInsets.all(6),

                                                borderRadius: BorderRadius.circular(4),
                                                elevation: 1,
                                              ),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),

                                                width: 220,
                                                decoration: BoxDecoration(
                                                    color: AppColors.appTicketDarkBlue.withOpacity(0.1),
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                                                ),
                                                child:   Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(child: Center(child:tBodyBold(packageName.toString(), AppColors.appTicketDarkBlue),)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),

                                            gapHC(6),
                                            Expanded(
                                              child: Bounce(
                                                onPressed: () {
                                                  ticketRechargeController.fnChangePackageCount("A",itemCode);
                                                },
                                                duration: Duration(milliseconds: 110),
                                                child: Container(
                                                  width: 220,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.appTicketDarkBlue.withOpacity(0.1),
                                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            tBody(itemName1.toString(), Colors.black, TextAlign.start),
                                                            tBody(itemName2.toString(), Colors.black,  TextAlign.start),
                                                            tBody(itemName3.toString(), Colors.black,  TextAlign.start),

                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                decoration: boxBaseDecoration(AppColors.appTicketLIGHTRED, 20),
                                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                                                child: tBodyBold("AED  ${packageRate.toString()}", Colors.white, ),
                                                              ),
                                                            ),
                                                            gapWC(7),
                                                            mfnInt(ticketRechargeController.lstrPackages[index]["count"]) !=0? Bounce(
                                                              duration: const Duration(milliseconds: 110),
                                                              onPressed: (){

                                                                ticketRechargeController.fnChangePackageCount("D",itemCode);
                                                              },
                                                              child: CircleAvatar(
                                                                radius: 22,
                                                                backgroundColor: AppColors.appReaderDarkbGbLUE,
                                                                child: const Text("-",style: TextStyle(
                                                                    color: Colors.white,fontSize: 40,height: 0.9
                                                                )),
                                                              ),
                                                            ):gapHC(0)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                            ),),
                            gapHC(10),
                            Flexible(
                              flex: 6,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Row(
                                      children: [

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              tHead2("Enter Amount", Colors.black),
                                              gapHC(5),
                                              Column(
                                                children: [ 
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextField(
                                                      cursorColor:Colors.black,

                                                      keyboardType: TextInputType.number,
                                                      controller: ticketRechargeController.txtAmount,
                                                      decoration: InputDecoration(
                                                        focusColor: Colors.black,
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
                                                  gapHC(10),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(child: Numbers(value: "1",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "2",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "3",)),

                                                        ],
                                                      ),
                                                      gapHC(10),
                                                      Row(                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(child: Numbers(value: "4",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "5",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "6",)),
                                                        ],
                                                      ),
                                                      gapHC(10),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(child: Numbers(value: "7",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "8",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "9",)),
                                                        ],
                                                      ),
                                                      gapHC(10),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children:  [
                                                          Flexible(child: Numbers(value: "C",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "0",)),
                                                          gapWC(5),
                                                          Flexible(child: Numbers(value: "B",)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  gapHC(10),

                                                ],
                                              ),
                                            ],
                                          ),)



                                      ],
                                    ),
                                  ),
                                  gapWC(20),
                                  Flexible(
                                      flex: 1,

                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.end,

                                        children: [

                                          Row(),

                                          fixedAmountBox(context,"50"),
                                          gapHC(10),
                                          fixedAmountBox(context,"100"),
                                          gapHC(10),
                                          fixedAmountBox(context,"200"),
                                          gapHC(10),
                                          fixedAmountBox(context,"500"),
                                          gapHC(20),

                                        ],
                                      )),
                                  gapWC(10),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30,bottom: 20),
                                    child: VerticalDivider(
                                      color: Colors.black.withOpacity(0.5),
                                      thickness: 0.2,
                                    ),
                                  ),
                                  gapWC(10),

                                  Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30),               child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [



                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    tBody( "Recharge Amount", Colors.black, TextAlign.start),
                                                    tHead2("${ticketRechargeController.txtAmount.text.toString()}", Colors.black)
                                                  ],
                                                ),
                                                gapHC(10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    tBody( "Package Amount", Colors.black, TextAlign.start),
                                                    tHead2("999.00", Colors.black,)
                                                  ],
                                                ),
                                                gapHC(10),
                                                Divider(thickness: 2,color: Colors.black.withOpacity(0.2)),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    tHead2("Total Amount", Colors.black,),
                                                    tHead2("1124.00", Colors.black, )
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
                                                        shape:RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(3))) ,
                                                        value: ticketRechargeController.oldbalance.value,
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            ticketRechargeController.oldbalance.value = value!;
                                                          });
                                                        },

                                                      ),
                                                    ),
                                                    tBody("Use old Balance(300.00)", Colors.black,  TextAlign.start)
                                                  ],
                                                ),
                                                gapHC(2),
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 1.3,
                                                      child: Checkbox(
                                                        checkColor: Colors.white,
                                                        activeColor: Colors.greenAccent,
                                                        shape:RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(3))) ,
                                                        value: ticketRechargeController.foc.value,
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            ticketRechargeController.foc.value = value!;
                                                          });
                                                        },

                                                      ),
                                                    ),
                                                    tBody("FOC", Colors.black,TextAlign.start)
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

                                              ticketRechargeController.wSelectPaymentModeBottomsheet(context);
                                            },


                                          ),
                                          gapHC(20)
                                        ],
                                      ),
                                      ))
                                ],
                              ),
                            )

                          ],
                        ),
                      ),


                    ),
                  ],
                ),
              ),
            ),
            gapHC(20)
          ],
        ),
      )),
    );
  }

  wActivePackage() {
    return Column(
      children: [
        gapHC(15),
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: ticketRechargeController
                  .lstrPackages.length,
              itemBuilder: (context,index){
                //   {
                //     "title":"GOLDEN PACKAGE",
                //   "itemName1":"Kids Train 2/5",
                //   "itemName2":"Jump 4/5",
                //   "itemName3":"Arts 3/5",
                //   "packageRate":"999.00"
                // },
                var packageName = ticketRechargeController
                    .lstrPackages.value[index]["title"];
                var packageRate = ticketRechargeController
                    .lstrPackages.value[index]["packageRate"];
                var itemName1 = ticketRechargeController
                    .lstrPackages.value[index]["itemName1"];
                var itemName2 = ticketRechargeController
                    .lstrPackages.value[index]["itemName2"];
                var itemName3 = ticketRechargeController
                    .lstrPackages.value[index]["itemName3"];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Container(
                      decoration: boxBaseDecoration(Colors.grey.shade200, 20),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tBodyBold(packageName.toString(), AppColors.appTicketDarkBlue),
                              tBodyBold("AED ${packageRate.toString()}", AppColors.appReaderBgRed,),
                            ],
                          ),
                          gapHC(5),
                          Row(
                            children: [
                              Icon(Icons.circle_outlined,
                                  color: Colors.grey.withOpacity(0.9), size: 15),
                              gapWC(6),
                              tBodyBold(itemName1.toString(), Colors.black.withOpacity(0.69),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.circle_outlined,
                                  color: Colors.grey.withOpacity(0.9), size: 15),
                              gapWC(6),
                              tBodyBold(itemName2.toString(), Colors.black.withOpacity(0.69),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.circle_outlined,
                                  color: Colors.grey.withOpacity(0.9), size: 15),
                              gapWC(6),
                              tBodyBold(itemName3.toString(), Colors.black.withOpacity(0.69)),
                            ],
                          ),
                        ],
                      )),
                );
              }),
        ),
      ],
    );
  }

  wLastTransaction() {
    return Column(
      children: [
        gapHC(15),
        Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),

                padding: EdgeInsets.zero,
                itemCount: ticketRechargeController.lstrLastTransaction.length,
                itemBuilder: (context, index) {
                  var title = ticketRechargeController
                      .lstrLastTransaction.value[index]["title"];
                  var transactionDate = ticketRechargeController
                      .lstrLastTransaction.value[index]["transactionDate"];
                  var trAmount = ticketRechargeController
                      .lstrLastTransaction.value[index]["trAmount"];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Container(
                      decoration: boxBaseDecoration(Colors.grey.shade200, 15),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn(title, Colors.black, 14,TextAlign.center),
                              gapHC(2),
                              tcnH(
                                  transactionDate.toString().toUpperCase(),
                                  Colors.grey.withOpacity(0.9),
                                  12,
                                  TextAlign.center,
                                  0.99),
                            ],
                          ),
                          tc(trAmount.toString(), Colors.red, 12)
                        ],
                      ),
                    ),
                  );
                })),
      ],
    );
  }

  changePage(int pageNum) {
    ticketRechargeController.selectedPage.value = pageNum;

    ticketRechargeController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      ticketRechargeController.lstrSelectedPage.value = "AP";
    }

    if (pageNum == 1) {
      ticketRechargeController.lstrSelectedPage.value = "LT";
    }
  }
  Widget fixedAmountBox(context,value){
    Size size = MediaQuery.of(context).size;
    return Bounce(
      duration: const Duration(milliseconds: 110),
      onPressed: (){
        ticketRechargeController.txtAmount.text=value;

      },
      child: Container(
        decoration: boxBaseDecoration(Colors.grey.shade200, 20),
        height: size.height*0.07,width: size.height*0.3,
        child: Center(
          child: tc(value, Colors.black, 16),
        ),
      ),
    );

  }

}

// Row(
//
// children: [
// tcn("Active Package", Colors.black, 16, TextAlign.center),
// ],
// ),
// gapHC(5),
// Container(
//
// decoration: boxBaseDecoration(
// Colors.grey.shade200, 20),
// padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// tc("GOLDEN PACKAGE", AppColors.appTicketDarkBlue, 13),
// tc("AED 999.00", AppColors.appReaderBgRed, 13),
// ],
// ),
// gapHC(10),
// Row(
// children: [
// Icon(Icons.circle_outlined,color: Colors.grey.withOpacity(0.9),size: 15),
// gapWC(6),
// tc("Kids Train 2/5", Colors.black.withOpacity(0.69), 13),
// ],
// ),
// Row(
// children: [
// Icon(Icons.circle_outlined,color: Colors.grey.withOpacity(0.9),size: 15),
// gapWC(6),
// tc("Jump 3/5", Colors.black.withOpacity(0.69), 13),
// ],
// ),
// Row(
// children: [
// Icon(Icons.circle_outlined,color: Colors.grey.withOpacity(0.9),size: 15),
// gapWC(6),
// tc("Arts 1/5", Colors.black.withOpacity(0.69), 13),
// ],
// ),
//
// ],
// ),
// ),
// gapHC(10),
// tcn("Last Transaction", Colors.black, 16, TextAlign.start),
// gapHC(5),
// Expanded(
// child: ListView.builder(
// padding: EdgeInsets.zero,
// itemCount:2,
// itemBuilder: (context,index){
// var title = ticketRechargeController.lstrLastTransaction.value[index]["title"];
// var transactionDate = ticketRechargeController.lstrLastTransaction.value[index]["transactionDate"];
// var trAmount = ticketRechargeController.lstrLastTransaction.value[index]["trAmount"];
// return Padding(
// padding: const EdgeInsets.only(bottom: 3),
// child: Container(
// decoration: boxBaseDecoration(Colors.grey.shade200, 15),
// padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// tc(title, Colors.black, 15),
// gapHC(2),
// tcnH(transactionDate.toString().toUpperCase(), Colors.grey.withOpacity(0.9), 10,TextAlign.center,0.99),
// ],
// ),
// tc(trAmount.toString(), Colors.red,12)
// ],
// ),
//
// ),
// );
// }),
// ),
//
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// tcn("View More", Colors.blue, 12, TextAlign.center),
// ],
// )
class Numbers extends StatelessWidget {
  final String value;
  Numbers({Key? key,required this.value,}) : super(key: key);

  final TicketRechargeController ticketRechargeController =
  Get.put(TicketRechargeController());



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: (){
          dprint("VaAALUEEE  :  ${value}");

          if(value == "B"){
            ticketRechargeController.fnBackspace();
          }else if(value == "C"){
            ticketRechargeController.fnClearAll();
          }else{



            ticketRechargeController.fnNumberPress(value);
          }

        },
        child: Container(
            height: size.height*0.07,width: size.height*0.3,
            // height: 50,
            decoration: boxBaseDecoration(Colors.grey.shade200, 20),
            child: Center(child:value =="B"?
            Icon(Icons.backspace,color: Colors.black,size: 25,):
            value == "C"?   Icon(Icons.close,color: Colors.black,size:24 ,): tcnw(value,Colors.black,25, TextAlign.center, FontWeight.w500)))
    );
  }
}

