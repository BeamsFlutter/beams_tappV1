import 'package:awesome_card/awesome_card.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../constants/color_code.dart';
import '../../constants/string_constant.dart';
import '../../constants/styles.dart';
import '../controller/tktHistoryController.dart';
import '../controller/tktRegisterController.dart';

class TicketHistoryDetailScreen extends StatefulWidget {
  const TicketHistoryDetailScreen({super.key});

  @override
  State<TicketHistoryDetailScreen> createState() => _TicketHistoryDetailScreenState();
}

class _TicketHistoryDetailScreenState extends State<TicketHistoryDetailScreen> {
  final TicketHistoryController ticketHistoryController = Get.put(TicketHistoryController());
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
                      child: Obx(() => Container(
                        decoration: boxBaseDecoration(Colors.white, 30),
                        padding: const EdgeInsets.only(
                            left: 20,right: 20,top: 10,bottom: 2
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      tHead2("History", AppColors.appTicketDarkBlue,
                                          ),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        decoration: boxBaseDecoration(
                                            Colors.grey.shade200, 30),
                                      )
                                    ],
                                  ),
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
                                  Bounce(
                                    duration: const Duration(milliseconds: 110),
                                    onPressed: () {
                                      ticketHistoryController.wSelectFromDate(context);

                                    },
                                    child: Container(
                                      decoration: boxDecoration(Colors.white,12),
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.calendar_month,color: Colors.black,),
                                          tSubHead(setDate(17, ticketHistoryController.fromDate.value).toString(), AppColors.appTicketDarkBlue,  TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapHC(10),
                                  Bounce(
                                    duration: const Duration(milliseconds: 110),
                                    onPressed: () {
                                      ticketHistoryController.wSelectToDate(context);

                                    },
                                    child: Container(
                                      decoration: boxDecoration(Colors.white,12),
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.calendar_month,color: Colors.black,),
                                          tSubHead(setDate(17, ticketHistoryController.toDate.value).toString(), AppColors.appTicketDarkBlue,  TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapHC(10),
                                  Container(
                                    width: double.maxFinite,
                                    decoration: boxDecoration(Colors.white,12),
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                    child: DropdownButton(
                                      iconEnabledColor: AppColors.appTicketDarkBlue,
                                      iconDisabledColor: AppColors.appTicketDarkBlue,

                                      iconSize: 32.2,
                                      isDense: true,
                                      isExpanded: true,
                                      alignment: Alignment.centerRight,

                                      underline: SizedBox(),
                                      value: ticketHistoryController.dropdownvalue.value,
                                      onChanged: (newValue) {
                                        ticketHistoryController.dropdownvalue.value = newValue!;
                                      },
                                      items: ticketHistoryController.dropdownMenus.map((e) {
                                        return DropdownMenuItem(
                                          child:   tSubHead(e.toString(), AppColors.appTicketDarkBlue,  TextAlign.center) ,
                                          value: e,
                                        );
                                      }).toList(),
                                    ),












                                  ),



                                ],
                              ),
                            ),
                          TcketCommonButton(
                            buttoncolor: AppColors.appTicketColor1,
                            buttonText: "Apply",
                            icon_need: false,
                            border: Border.all(color:AppColors.appTicketColor1),
                            radius: 40,buttonTextSize: 18,
                            buttonTextColor: Colors.white,
                            onpressed: (){

                            },


                          ),
                            gapHC(20)
                          ],
                        ),
                      )),
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
                        child: Column(
                          children: [

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount:ticketHistoryController.historyList.length ,

                                    itemBuilder: (context,index){

                                      // "counterName":"Kids Train",
                                      // "date":"22 JULY 2023 03:44",
                                      // "price":"-45"

                                      var historyData= ticketHistoryController.historyList[index];
                                      var counter =(historyData["counterName"]??"").toString();
                                      var date =(historyData["date"]??"").toString();
                                      var price =(historyData["price"]??"").toString();
                                  return  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      decoration: boxBaseDecoration(Colors.grey.shade100, 15),
                                      padding: EdgeInsets.only(bottom: 10,left: 10,top: 10,right: 50),
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              tHead2(counter.toString(), Colors.black, ),
                                              gapHC(4),
                                              tBody(date.toString(), Colors.grey, TextAlign.start,height1: 0.89)
                                            ],

                                          ),
                                          tHead2(price.toString(), Colors.red,),

                                        ],
                                      ),
                                    ),
                                  );
                                }),
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
      )
    );
  }


  // wDateField(dateMode){
  //   return Material(
  //     elevation: 30,
  //     borderRadius: BorderRadius.circular(30.0),
  //     shadowColor: AppColors.lightfontcolor.withOpacity(0.3),
  //     child: Padding(
  //         padding: const EdgeInsets.only(right: 10,left: 10),
  //         child: Obx(() => Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             dateMode=="from"?tc(DateFormat('dd-MM-yyyy').format(ticketHistoryController.fromDate.value), Colors.black, 11):
  //             tc(DateFormat('dd-MM-yyyy').format(ticketHistoryController.toDate.value), Colors.black, 11),
  //             IconButton(onPressed: (){
  //               dateMode=="from"?  ticketHistoryController.wSelectFromDate(context):ticketHistoryController.wSelectToDate(context);
  //             },
  //                 icon: const Icon(Icons.calendar_month_rounded))
  //           ],
  //         ),)
  //     ),
  //   );
  // }







}
