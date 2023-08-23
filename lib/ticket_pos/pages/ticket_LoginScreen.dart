import 'dart:async';

import 'package:beams_tapp/constants/dateformates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/styles.dart';
import '../controller/tktLoginController.dart';

class TicketLoginScreeen extends StatefulWidget {
  const TicketLoginScreeen({super.key});

  @override
  State<TicketLoginScreeen> createState() => _TicketLoginScreeenState();
}

class _TicketLoginScreeenState extends State<TicketLoginScreeen> {
  final TicketLoginController ticketLoginController = Get.put(TicketLoginController());
  var lstrCurrentdate=DateTime.now();
  late Timer _timer;
  @override
  void dispose() {

    ticketLoginController.p1.value='';
    ticketLoginController.p2.value='';
    ticketLoginController.p3.value='';
    ticketLoginController.p4.value='';
    _timer.cancel();
    // TODO: implement dispose
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
      //  padding: MediaQuery.of(context).padding,

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
                padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                decoration: BoxDecoration(
                  color: AppColors.appTicketLIGHTRED.withOpacity(0.3),
                  borderRadius:  BorderRadius.horizontal(right: Radius.elliptical(500,520)



                  ),
                ),
                child:    Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),

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
                                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.home,color: AppColors.white,size: 40,),
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
                      gapHC(5),
                      Row()

                    ],
                  ),
                ),


              ),
            ),


            Expanded(
              flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(Icons.wifi,color: Colors.white,size:20 ),
                                gapWC(5),
                                tcn("192.168.0.100", Colors.white, 12, TextAlign.center)

                              ],
                            ),
                          ),

                          Flexible(
                            child: Row(
                              children: [
                                const Icon(Icons.phone_android_outlined,color: Colors.white,size:20 ),
                                gapWC(5),
                                tcn("97897667", Colors.white, 12, TextAlign.center)

                              ],
                            ),
                          ),

                          Flexible(
                            child: Row(
                              children: [
                                const Icon(Icons.account_balance,color: Colors.white,size:20 ),
                                gapWC(5),
                                Flexible(child: tcn("SPLASH AND PARTY LLC.", Colors.white, 12, TextAlign.start))

                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,

                          children: [




                            Center(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      tHead4("Login", AppColors.white,),
                                      gapHC(20),
                                      Obx(() => Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          wCodeInput(ticketLoginController.p1.toString(),1),
                                          wCodeInput(ticketLoginController.p2.toString(),2),
                                          wCodeInput(ticketLoginController.p3.toString(),3),
                                          wCodeInput(ticketLoginController.p4.toString(),4),

                                        ],
                                      )),
                                      gapHC(10),
                                      Obx(() =>    ticketLoginController.isLogin.value ? tcn("Login Failed, Please try again...", Colors.white70, 13,TextAlign.center):gapHC(0),),

                                    ],
                                  ),
                                  gapHC(15),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:   [
                                          Numbers(value: "1"),
                                          gapWC(50),
                                          Numbers(value: '2'),
                                          gapWC(50),
                                          Numbers(value: '3'),
                                        ],
                                      ),
                                      gapHC(20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Numbers(value: '4'),
                                          gapWC(50),
                                          Numbers(value: '5'),
                                          gapWC(50),
                                          Numbers(value: '6'),
                                        ],
                                      ),
                                      gapHC(20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Numbers(value: '7'),
                                          gapWC(50),
                                          Numbers(value: '8'),
                                          gapWC(50),
                                          Numbers(value: '9'),
                                        ],
                                      ),
                                      gapHC(20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Numbers(value: 'C'),
                                          gapWC(50),
                                          Numbers(value: '0'),
                                          gapWC(50),
                                          Numbers(value: 'B'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
  Widget wCodeInput(String inputValue,valNum){
    var currNum = 0;
    if(ticketLoginController.p4.isNotEmpty){
      currNum = 4;
    }else if(ticketLoginController.p3.isNotEmpty){
      currNum = 3;
    }else if(ticketLoginController.p2.isNotEmpty){
      currNum = 2;
    }else if(ticketLoginController.p1.isNotEmpty){
      currNum = 1;
    }


    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color:inputValue==""?Colors.white.withOpacity(0.6):AppColors.white,
      child:  SizedBox(
        height:valNum ==  currNum? 40.0:35.0,
        width: valNum ==  currNum? 40.0:35.0,
      ),
    );
  }
}
class Numbers extends StatelessWidget {
  final String value;
  Numbers({Key? key,required this.value,}) : super(key: key);

  final TicketLoginController ticketLoginController = Get.put(TicketLoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: (){
          // dprint("VaAALUEEE  :  ${value}");

          if(value == "B"){
            ticketLoginController.fnBackspace();
          }else if(value == "C"){
            ticketLoginController.fnClearAll();
          }else{
            ticketLoginController.fnNumberPress(value);
          }

        },
        child: Container(
            height: size.height*0.1,width: size.height*0.1,
            decoration: boxBaseDecoration(Colors.transparent, 50),
            child: Center(child:value =="B"?
             Icon(Icons.backspace,color: Colors.white,size: size.height*0.05,):
            value == "C"?   Icon(Icons.close,color: Colors.white,size:size.height*0.05 ,): tcnw(value,AppColors.white,size.height*0.07, TextAlign.center, FontWeight.w500)))
    );
  }
}