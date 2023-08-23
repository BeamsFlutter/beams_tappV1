import 'dart:async';

import 'package:beams_tapp/adminV1/pages/adminHomeScreen.dart';
import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../adminMode/views/login/controller/adminLogin_controller.dart';
import '../../constants/color_code.dart';
import '../../constants/dateformates.dart';
import '../../constants/styles.dart';
import '../controllers/adminLoginController.dart';

class AdminV1LoginScreeen extends StatefulWidget {
  const AdminV1LoginScreeen({super.key});

  @override
  State<AdminV1LoginScreeen> createState() => _AdminV1LoginScreeenState();
}

class _AdminV1LoginScreeenState extends State<AdminV1LoginScreeen> {
  final AdminV1LoginController adminV1LoginController = Get.put(AdminV1LoginController());
  var lstrCurrentdate=DateTime.now();
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    _timer = Timer.periodic(
      const Duration(seconds: 30),
          (Timer t) => setState(() {
        lstrCurrentdate = DateTime.now();
      }),
    );
    return Scaffold(
      body:Container(
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
                              tHead("Beams", AppColors.white,),
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
                              // Row(
                              //   children: [
                              //     Container(
                              //       decoration: boxBaseDecoration(AppColors.appReaderDarkRED, 23),
                              //       padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           const Icon(Icons.home,color: AppColors.white,size: 40,),
                              //           gapWC(5),
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               tc("D0001", AppColors.white, 15),
                              //               tcn("DEIRA CITY CENTER", AppColors.white, 16,TextAlign.start),
                              //             ],
                              //           )
                              //         ],
                              //       ),
                              //
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      gapHC(5),
                      const Row()

                    ],
                  ),
                ),


              ),
            ),
            gapWC(30),


            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 50),
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
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Container(
                              width: 400,
                              decoration: boxBaseDecoration(AppColors.white.withOpacity(0.1), 20),
                              padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                              margin: EdgeInsets.symmetric(horizontal: 50,),
                              child: Column(
                                children: [
                                  gapHC(30),
                                  tHead4("USER LOGIN", AppColors.white,),
                                  gapHC(20),
                                  Adminv1CommonTextfield(
                                      controller: adminV1LoginController.txtusername,
                                      textFormFieldType: TextFormFieldType.fullName,
                                      shadow: 0.2,
                                      textStyle: TextStyle(color: Colors.white),
                                      opacityamount:0.6,
                                      prefixIcon: Icon(Icons.person,color: Colors.white,size: 20),

                                      hintText: "username"

                                  ),
                                  gapHC(20),
                                 Obx(() =>  Adminv1CommonTextfield(
                                     textStyle: TextStyle(color: Colors.white),
                                     controller: adminV1LoginController.txtpassword,
                                     textFormFieldType: TextFormFieldType.fullName,
                                     shadow: 0.2,
                                     isObscure:  adminV1LoginController.isVisible.value,
                                     opacityamount:0.6,
                                     prefixIcon: Icon(Icons.lock,color: Colors.white,size: 20),
                                     suffixIcon: Padding(
                                       padding: const EdgeInsets.only(right: 20),
                                       child: Bounce(
                                           duration: const Duration(milliseconds: 110),
                                           onPressed: (){
                                             adminV1LoginController.isVisible.value = !adminV1LoginController.isVisible.value;
                                             dprint(adminV1LoginController.isVisible.value);
                                           },


                                           child: Icon(adminV1LoginController.isVisible.value? Icons.visibility:Icons.visibility_off,color: Colors.white.withOpacity(0.6),size: 20)),
                                     ),

                                     hintText: "password"

                                 ),),
                                  gapHC(20),
                                  TcketCommonButton(
                                    buttoncolor: Colors.white,
                                    buttonText: "Login",radius: 30,
                                    onpressed: (){
                                      Get.to(AdminV1HomeScreen());

                                    },
                                    icon_need: false,
                                    buttonTextColor: AppColors.appTicketDarkBlue,
                                    border: Border.all(color: Colors.white, ),

                                  ),
                                  gapHC(30),



                                ],
                              ),



                            )


                          ],
                        )
                    ),
                  ],
                ),
              ),)
          ],
        ),

      ),
    );
  }
}
