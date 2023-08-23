import 'package:beams_tapp/ticket_pos/pages/ticket%20HistoryDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/styles.dart';
import '../controller/tktHistoryController.dart';

class TicketHisctoryScanScreen extends StatefulWidget {
  const TicketHisctoryScanScreen({super.key});

  @override
  State<TicketHisctoryScanScreen> createState() => _TicketHisctoryScanScreenState();
}

class _TicketHisctoryScanScreenState extends State<TicketHisctoryScanScreen> {
  final TicketHistoryController ticketHistoryController = Get.put(TicketHistoryController());
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: MediaQuery.of(context).padding,
        decoration:  boxGradientCLBR(AppColors.appReaderBgRed,
            AppColors.appReaderBgBlue,0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: (){
                      // Get.to(TicketRechargeScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tHead("Beams", AppColors.white, ),
                            tcnH("VERSION V1.0",  AppColors.appBgGreyshde.withOpacity(0.5), 10, TextAlign.center,0.11),

                          ],
                        ),
                        tcS("   Fungate ", AppColors.white, 30),
                      ],
                    ),
                  ),
                  Container(



                    decoration: boxBaseDecoration(AppColors.appReaderDarkBlck.withOpacity(0.36), 23),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(Icons.home,color:Colors.white,size: 20,),
                        gapWC(6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc("D0001", AppColors.white, 10),
                            tcnH("DEIRA CITY CENTER", AppColors.white, 10,TextAlign.start,0.95),
                          ],
                        )
                      ],
                    ),

                  ),
                  Row(
                    children: [
                      Icon(Icons.wifi,color: Colors.white,size:20 ),
                      gapWC(5),
                      tcn("192.168.0.100", Colors.white, 12, TextAlign.center)

                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone_android_outlined,color: Colors.white,size:20 ),
                      gapWC(5),
                      tcn("9787826367", Colors.white, 12, TextAlign.center)

                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.account_balance,color: Colors.white,size:20 ),
                      gapWC(5),
                      tcn("SPLASH AND PARTY LLC.", Colors.white, 12, TextAlign.start)

                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical:10),
                child:Row(
                  children: [
                    Flexible(
                        flex: 4,
                        child:Container(
                          decoration: boxBaseDecoration(Colors.white, 30),
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tSubHead("Search Customer", Colors.grey, TextAlign.center),
                              gapHC(5),
                              SizedBox(
                                height: 55,
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
                              )

                            ],
                          ),

                        )),
                    gapWC(20),
                    Flexible(
                        flex: 6,
                        child:Container(
                          width: double.infinity,
                          decoration: boxBaseDecoration(Colors.white, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(),

                              Column(
                                children: [
                                  tHead1("Tap your card", AppColors.appTicketDarkBlue,),
                                  gapHC(10),
                                  tBody("Please tap your card on the NFC reader to continue\n the recharge process.", Colors.grey,  TextAlign.center)
                                ],
                              ),


                              GestureDetector(
                                  onTap: (){
                                    ticketHistoryController.tapCard.value=true;
                                    Get.to(()=>TicketHistoryDetailScreen());

                                  },
                                  child: Image.asset("assets/gifs/removeBg/tapCard1.gif",width: 250,height: 250,fit: BoxFit.contain,)),
                              Row(),
                              gapHC(4),

                            ],
                          ),

                        )),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButtons("Home", "assets/images/ticketPos/home.png", () {
                  dprint("Tap Home");
                }),
                gapWC(20),
                IconButtons("Close", "assets/images/ticketPos/arrow.png", () {
                  dprint("Tap Close");
                  Get.back();

                })
              ],
            ),
            gapHC(20)







          ],
        ),
      ),
    );
  }

  Widget IconButtons(title,image, VoidCallback ontap){
    return Bounce(duration: const Duration(milliseconds: 110),
        onPressed: ontap, child:
        Container(

          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          decoration: boxBaseDecoration(AppColors.appTicketDarkBlue.withOpacity(0.454), 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(radius: 13,backgroundColor: Colors.white.withOpacity(0.4), child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(image),
              )),
              gapWC(12),
              tcn(title,Colors.white, 15,TextAlign.center)
            ],
          ),

        ));
  }

}
