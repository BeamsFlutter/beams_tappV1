import 'dart:async';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_CardIssue.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_DeviceScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_HistoryScanScreen.dart';

import 'package:beams_tapp/ticket_pos/pages/ticket_RechargeTapScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_ReportScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_RequestScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_counterScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_registerScreen.dart';
import 'package:beams_tapp/ticket_pos/pages/ticket_staffScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';


import '../../constants/color_code.dart';
import '../../constants/dateformates.dart';
import '../../constants/styles.dart';
import '../controller/tktHomeController.dart';

class TicketHomeScreen extends StatefulWidget {
  const TicketHomeScreen({super.key});

  @override
  State<TicketHomeScreen> createState() => _TicketHomeScreenState();
}

class _TicketHomeScreenState extends State<TicketHomeScreen> {
  final TicketHomeController ticketHomeController = Get.put(TicketHomeController());
  var lstrCurrentdate=DateTime.now();
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    _timer = Timer.periodic(
      Duration(seconds: 30),
          (Timer t) => setState(() {
            lstrCurrentdate = DateTime.now();
      }),
    );

    return Scaffold(

      body: Container(
          // padding: MediaQuery.of(context).padding,

        height: size.height,
        width: size.width,
        decoration:  boxGradientCLBR(AppColors.appTicketLIGHTRED,
            AppColors.appTicketDarkBlue,0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                decoration: BoxDecoration(
                  color: AppColors.appTicketLIGHTRED.withOpacity(0.3),
                  borderRadius:  const BorderRadius.horizontal(right: Radius.elliptical(500,520)



                  ),
                ),
                child:    Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tc("Beams", AppColors.white, 45),
                              tcnH("VERSION V1.0",  AppColors.appBgGreyshde.withOpacity(0.5), 10, TextAlign.center,0.91),

                            ],
                          ),
                          tcS("   Fungate ", AppColors.white, 30),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  tcnH(" ${setDate(17, lstrCurrentdate).toString().toUpperCase()}",Colors.white.withOpacity(0.8), 32,TextAlign.center,0.7),
                                  gapHC(12),
                                  tcnH(setDate(18, lstrCurrentdate).toString(),Colors.white, 92,TextAlign.center,0.99),
                                ],
                              ),
                              gapHC(25),
                              Row(
                                children: [
                                  Container(
                                    decoration: boxBaseDecoration(AppColors.appReaderDarkRED, 23),
                                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.home,color: AppColors.white,size: 40,),
                                        gapWC(5),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            tc("D0001", AppColors.white, 15),
                                            tcn("DEIRA CITY CENTER", AppColors.white, 16,TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),



                    ],
                  ),
                ),


              ),
            ),


            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              const Icon(Icons.person,color: Colors.white,size:20 ),
                              gapWC(5),
                              tcn("ADMIN", Colors.white, 12, TextAlign.center)

                            ],
                          ),
                        ),
                        // Flexible(
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.wifi,color: Colors.white,size:20 ),
                        //       gapWC(5),
                        //       tcn("192.168.0.100", Colors.white, 12, TextAlign.center)
                        //
                        //     ],
                        //   ),
                        // ),
                        //
                        Flexible(
                          child: Row(
                            children: [
                              const Icon(Icons.phone_android_outlined,color: Colors.white,size:20 ),
                              gapWC(5),
                              tcn("97893127667", Colors.white, 12, TextAlign.center)

                            ],
                          ),
                        ),

                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.account_balance,color: Colors.white,size:20 ),
                              gapWC(5),
                              Flexible(child: tcn("SPLASH AND PARTY LLC.", Colors.white, 12, TextAlign.start))

                            ],
                          ),
                        ),
                        gapWC(5),
                        Bounce(
                          onPressed: (){
                            Get.back();
                          },
                            duration: const Duration(milliseconds: 110),
                            child: CircleAvatar(radius: 22,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: Icon(Icons.power_settings_new,color: Colors.white.withOpacity(0.9),size: 35,))),
                        gapWC(20)
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HomeButtons("RECHARGE","assets/images/ticketPos/top-up.png",
                                          () {
                                        Get.to(()=>const TicketRechargeTapScreen());
                                      }),
                                  gapWC(35),
                                  HomeButtons("CARD ISSUE","assets/images/ticketPos/atm-card.png",
                                          () {
                                        Get.to(()=>const TicketCardIssue());
                                      }),
                                  gapWC(35),
                                  HomeButtons("REGISTER","assets/images/ticketPos/new.png",
                                          () {
                                        Get.to(()=>const TicketRegisterScreen());
                                      }),

                                ],
                              ),
                              gapHC(35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      HomeButtons("COUNTER","assets/images/ticketPos/carousel.png",
                                              () {
                                            Get.to(()=>const TicketCounterScreen());
                                          }),
                                    ],
                                  ),
                                  gapWC(35),
                                  Row(
                                    children: [
                                      HomeButtons("STAFF","assets/images/ticketPos/receptionist.png",
                                              () {
                                            Get.to(()=>const TicketStaffScreen());
                                          }),
                                    ],
                                  ),
                                  gapWC(35),
                                  Row(
                                    children: [
                                      HomeButtons("DEVICES","assets/images/ticketPos/pos-terminal.png",
                                              () {
                                            Get.to(()=>const TicketDeviceScreen());
                                          }),
                                    ],
                                  ),

                                ],
                              ),
                              gapHC(35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      HomeButtons("REPORTS","assets/images/ticketPos/3d-report.png",
                                              () {
                                            Get.to(()=>const TicketReportScreen());
                                          }),
                                    ],
                                  ),
                                  gapWC(35),
                                  Row(
                                    children: [
                                      HomeButtons("REQUEST","assets/images/ticketPos/request.png",
                                              () {
                                            Get.to(()=>const TicketRequestScreen());
                                          }),
                                    ],
                                  ),
                                  gapWC(35),
                                  Row(
                                    children: [
                                      HomeButtons("HISTORY","assets/images/ticketPos/refresh.png",
                                              () {
                                            Get.to(()=>const TicketHisctoryScanScreen());
                                          }),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),)
          ],
        ),

      ),
    );
  }


  Widget HomeButtons(title,image, VoidCallback ontap){
    return Bounce(duration: const Duration(milliseconds: 110),
        onPressed: ontap, child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 120,width: 120,
          padding: const EdgeInsets.all(25),
          decoration: boxBaseDecoration(AppColors.appTicketDarkBlue.withOpacity(0.454), 25),
          child: Image.asset(image),

        ),
        gapHC(5),
        tc(title,Colors.white, 10)
      ],
    ));
  }
}
