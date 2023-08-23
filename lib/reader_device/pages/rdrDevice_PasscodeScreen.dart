import 'package:beams_tapp/reader_device/controller/rdrPasscode_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/styles.dart';

class ReadrPasscodeScreen extends StatefulWidget {
  const ReadrPasscodeScreen({super.key});

  @override
  State<ReadrPasscodeScreen> createState() => _ReadrPasscodeScreenState();
}

class _ReadrPasscodeScreenState extends State<ReadrPasscodeScreen> {
  final ReaderPasscodeController passcodeController = Get.put(ReaderPasscodeController());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    passcodeController.fnCheckSessionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(),
      body: Container(
        padding: MediaQuery.of(context).padding,
        height: size.height,
        width: size.width,
        decoration:  boxGradientTCBC(AppColors.appReaderBgRed,
            AppColors.appReaderBgBlue,0.0),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Builder(builder: (context){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              tc("Beams", AppColors.white, 20),
                              tcS("Fungate", AppColors.white, 15),

                            ],
                          ),
                        Obx(() =>   Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          decoration: boxBaseDecoration(AppColors.appReaderDarkRED, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home,color: AppColors.white,size: 20,),
                              gapWC(3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tc((passcodeController.sitecode??"").toString(), AppColors.white, 8),
                                  tcn("DEIRA CITY CENTER", AppColors.white, 8,TextAlign.center),
                                ],
                              )
                            ],
                          ),

                        ),),
                          Bounce(
                              onPressed: (){
                                dprint("opendrawerrrr");
                                _scaffoldKey.currentState!.openEndDrawer();
                                //  Scaffold.of(context).openEndDrawer();
                              },
                              duration: const Duration(milliseconds: 110),
                              child: const Icon(Icons.menu,color: AppColors.white,size: 35,))
                        ],
                      );

                    }),

                    Column(
                      children: [
                        tcn("Login", AppColors.white, 35,TextAlign.center),
                        gapHC(20),
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            wCodeInput(passcodeController.p1.toString(),1),
                            wCodeInput(passcodeController.p2.toString(),2),
                            wCodeInput(passcodeController.p3.toString(),3),
                            wCodeInput(passcodeController.p4.toString(),4),

                          ],
                        )),
                        gapHC(20),
                        Obx(() =>    passcodeController.isLogin.value ? tcn("Login Failed, Please try again...", Colors.white70, 13,TextAlign.center):gapHC(0),),

                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:   [
                            Numbers(value: "1"),
                            Numbers(value: '2'),
                            Numbers(value: '3'),
                          ],
                        ),
                        gapHC(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            Numbers(value: '4'),
                            Numbers(value: '5'),
                            Numbers(value: '6'),
                          ],
                        ),
                        gapHC(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            Numbers(value: '7'),
                            Numbers(value: '8'),
                            Numbers(value: '9'),
                          ],
                        ),
                        gapHC(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            Numbers(value: 'C'),
                            Numbers(value: '0'),
                            Numbers(value: 'B'),
                          ],
                        ),
                      ],
                    ),
                    gapHC(30),





                  ],
                ),
              ),

              tcn("BEAMS", AppColors.white, 12, TextAlign.center),
              tcn("VERSION V1.0", AppColors.white, 12, TextAlign.center),
              gapHC(10)
            ],
          ),
        ),
      ),


    );
  }

  //====================================
  Widget wCodeInput(String inputValue,valNum){
    var currNum = 0;
    if(passcodeController.p4.isNotEmpty){
      currNum = 4;
    }else if(passcodeController.p3.isNotEmpty){
      currNum = 3;
    }else if(passcodeController.p2.isNotEmpty){
      currNum = 2;
    }else if(passcodeController.p1.isNotEmpty){
      currNum = 1;
    }


    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color:inputValue==""?Colors.white.withOpacity(0.4):AppColors.white,
      child:  SizedBox(
        height:valNum ==  currNum? 35.0:30.0,
        width: valNum ==  currNum? 35.0:30.0,
      ),
    );
  }

}

class Numbers extends StatelessWidget {
  final String value;
  Numbers({Key? key,required this.value,}) : super(key: key);

  final ReaderPasscodeController passcodeController = Get.put(ReaderPasscodeController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: (){
          // dprint("VaAALUEEE  :  ${value}");

          if(value == "B"){
            passcodeController.fnBackspace();
          }else if(value == "C"){
            passcodeController.fnClearAll();
          }else{
            passcodeController.fnNumberPress(value);
          }


        },
        child: Container(

            height: size.height*0.1,width: size.height*0.1,
            decoration: boxBaseDecoration(            Colors.transparent, 50),
            child: Center(child:value =="B"?
             Icon(Icons.backspace,color: Colors.white,size: size.height*0.04,):
            value == "C"?   Icon(Icons.close,color: Colors.white,size: size.height*0.05,): tcnw(value,AppColors.white,size.height*0.05, TextAlign.center, FontWeight.w500)))
    );
  }
}