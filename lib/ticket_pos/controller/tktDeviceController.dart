import 'package:beams_tapp/constants/color_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../constants/common_functn.dart';
import '../../constants/styles.dart';

class TicketDeviceController extends GetxController{

  var lstr_deviceList=[
    {
      "dev_name":"DEVICE 1",
      "id":"ASPOIGG POJKFFJF",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },


    {
      "dev_name":"DEVICE 5",
      "id":"JKHJKHJ SFDSF",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"O",
      "imageUrl":"https://microless.com/cdn/products/44ed9032a7405b0253001e4633b35663-hi.jpg"
    },    {
      "dev_name":"DEVICE 6",
      "id":"CXZVC VNVBVN",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
      "imageUrl": "https://images.shopkees.com/uploads/cdn/images/1000/8444070525_1645005145.jpg"
    },    {
      "dev_name":"DEVICE 7",
      "id":"ERTERER LKLLLL",
      "user_name":"RAFEEQ",
      "date":"11 DECEMBER 34:44 PM",
      "counter":"ZIPLINE",
      "status":"O",
      "imageUrl":"https://microless.com/cdn/products/44ed9032a7405b0253001e4633b35663-hi.jpg"
    },    {
      "dev_name":"DEVICE 8",
      "id":"FDDFDG WERWRWE",
      "user_name":"RALHID",
      "date":"19 OCTOBER 12:44 AM",
      "counter":"JUMPNFUN",
      "status":"O",
      "imageUrl": "https://images.shopkees.com/uploads/cdn/images/1000/8444070525_1645005145.jpg"
    },

    {
      "dev_name":"DEVICE 9",
      "id":"JDGDFF YUYJRETE",
      "user_name":"RASHID",
      "date":"18 JULY 12:44 AM",
      "counter":"WATER PLAY",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },



  ].obs;
  RxString p1=''.obs;
  RxString p2=''.obs;
  RxString p3=''.obs;
  RxString p4=''.obs;
  var isLogin =false.obs;


  wPasscodeBottomsheet(context){
    Size size = MediaQuery.of(context).size;
    return Get.bottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      StatefulBuilder(builder: (BuildContext context,StateSetter setState){
        return   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Obx(() =>     Container(
              decoration: boxGradientCLBR(AppColors.appTicketColor1,AppColors.appTicketDarkBlue, 30.0),
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              width:size.width*0.6,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: (){
                          Get.back();
                        },

                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color:Colors.white,width: 1 ),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Icon(Icons.close,color: Colors.white,size: 28),

                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tHead3("Enter Admin Passcode", Colors.white, ),
                          tBodyBold("Enter admin passcode for authorize the request", Colors.white, ),
                          gapHC(20),
                          Row(
                            children: [
                              wCodeInput(p1.toString(),1),
                              gapWC(20),
                              wCodeInput(p2.toString(),2),
                              gapWC(20),
                              wCodeInput(p3.toString(),3),
                              gapWC(20),
                              wCodeInput(p4.toString(),4),
                            ],
                          ),
                          gapHC(10),
                         isLogin.value ? tcn("Login Failed, Please try again...", Colors.white70, 13,TextAlign.center):gapHC(0),

                        ],
                      ),
                      gapWC(60),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                numPad("1",context),
                                gapHC(10),
                                numPad("4",context),
                                gapHC(10),
                                numPad("7",context),
                              ],

                            ),
                            gapWC(10),
                            Column(
                              children: [
                                numPad("2",context),
                                gapHC(10),
                                numPad("5",context),
                                gapHC(10),
                                numPad("8",context),
                                gapHC(10),
                                numPad("0",context),
                              ],

                            ),
                            gapWC(10),
                            Column(
                              children: [
                                numPad("3",context),
                                gapHC(10),
                                numPad("6",context),
                                gapHC(10),
                                numPad("9",context),
                              ],

                            ),
                          ],
                        ),
                      )

                    ],
                  )

                ],
              )

          ),)
          ],
        );
      }),


    );

  }



  Widget numPad(value,context){
    Size size = MediaQuery.of(context).size;
    return Bounce(
      onPressed: (){
        fnNumberPress(value);
      },
      duration: Duration(milliseconds: 110),
      child: Container(
        decoration: boxBaseDecoration(Colors.white, 20),
        height: size.height*0.1,width: size.height*0.1,
        child: Center(child: tc(value, Colors.black, size.height*0.03)),
      ),
    );

  }

  Widget wCodeInput(String inputValue,valNum){
    var currNum = 0;
    if(p4.isNotEmpty){
      currNum = 4;
    }else if(p3.isNotEmpty){
      currNum = 3;
    }else if(p2.isNotEmpty){
      currNum = 2;
    }else if(p1.isNotEmpty){
      currNum = 1;
    }


    return tc(
      "*",inputValue==""?Colors.white.withOpacity(0.3):AppColors.white,
      valNum ==  currNum? 45.0:42.0,
    );
  }

  fnNumberPress(String val)async{
    dprint(val);
    if(p4.isNotEmpty){
      // fnClearAll();
      return;
    }
    if(p1.isEmpty){
      p1.value = val;
    }else if(p2.isEmpty){
      p2.value = val;
    }else if(p3.isEmpty){
      p3.value = val;
    }else if(p4.isEmpty){
      p4.value= val;
      //login api call
      dprint("Call login Api");
      var code = p1.value+p2.value+p3.value+p4.value;
      dprint(code);
      dprint("token function");
      // Get.to(() =>TicketHomeScreen());
      // fnLogin(code,commonController.wNotificationDataModel.value);
      p1.value='';
      p2.value='';
      p3.value='';
      p4.value='';

      // var sessionSiteCode = await  Prefs.getString(AppStrings.rdr_siteCode);
      //
      // Get.to(() =>
      //     ReadrCounterScreen(pr_counterslIst:readerCounterController.lstr_counterList[0],)




    }
    update();
  }


}