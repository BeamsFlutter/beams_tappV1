import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_code.dart';
import '../../constants/styles.dart';

class TicketRequestScreen extends StatefulWidget {
  const TicketRequestScreen({super.key});

  @override
  State<TicketRequestScreen> createState() => _TicketRequestScreenState();
}

class _TicketRequestScreenState extends State<TicketRequestScreen> {
  @override
  Widget build(BuildContext context) {
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
                            tc("Beams", AppColors.white, 45),
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
                        child:  Container(
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
                                        tc("Request", AppColors.appTicketDarkBlue,
                                            17),
                                        Container(
                                          height: 30,
                                          width: 100,
                                          decoration: boxBaseDecoration(
                                              Colors.grey.shade200, 30),
                                        )
                                      ],
                                    ),




                                  ],
                                ),
                              ),

                              gapHC(20)
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
                          child: Column(
                            children: [


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
}
