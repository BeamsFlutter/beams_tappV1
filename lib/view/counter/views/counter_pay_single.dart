import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/counterMode.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/counter/controller/counter_controller.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';



class CounterPaySingleScreen extends StatefulWidget {
  final List itemdatas;
  const CounterPaySingleScreen({Key? key,required this.itemdatas}) : super(key: key);

  @override
  State<CounterPaySingleScreen> createState() => _CounterPaySingleScreenState();
}

class _CounterPaySingleScreenState extends State<CounterPaySingleScreen> {
  final CommonController commonController = Get.put(CommonController());
  final CounterController counterController = Get.put(CounterController());
  @override
  void dispose() {
    // TODO: implement dispose
    counterController.fnClearDetails();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("build Runningsss ${widget.itemdatas[0]["COUNTER_DESCP"].toString()}");
    var item_datas = widget.itemdatas[0];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(
          elevation: 0,
          // title: tsw( AppStrings.counters,AppColors.white,20,FontWeight.w500),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actions: [
            Obx(() =>    counterController.resetShow.value ? TextButton(onPressed: (){
              counterController.fnClearDetails();
            },
                child: tc("reset", AppColors.white, 15)):SizedBox())
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: size.height,
              width: size.width,
              decoration:  commonBoxDecoration(AppColors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    TitleWithUnderLine(title:item_datas["COUNTER_DESCP"].toString()),

                    Expanded(
                      child: Center(
                        child: Obx(
                                () => GestureDetector(
                                onTap: () {

                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    tcnw(item_datas["ITEM_DESCP"].toString(), AppColors.fontcolor, 20,TextAlign.center,FontWeight.w400),
                                    tcnw(item_datas["PRICE"].toString(), AppColors.fontcolor, 30,TextAlign.center,FontWeight.w600),

                                   counterController.payBtnPress.value ? (counterController.isAvailable.value? wHoldcard():wNotAvilble()):SizedBox()
                                    // counterController.isTaped.value ?  (counterController.isAvailable.value ? wHoldcard() : wNotAvilble()):const SizedBox(),





                                  ],
                                ))

                        ),
                      ),
                    ),

                    Obx(() =>  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        tc("Number Of Tickets", AppColors.fontcolor, 13),
                        Row(
                          children: [
                            gapWC(10),
                            Bounce(
                              onPressed: (){
                                counterController.fndecrement();
                              },
                              duration: const Duration(milliseconds: 110),
                              child: Material(
                                elevation: 0,
                                shadowColor:  Colors.white,
                                child: Container(
                                    height: 35,width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightfontcolor.withOpacity(0.7),
                                        borderRadius:BorderRadius.circular(10)
                                    ),
                                    child: Center(child: tcnw("-",AppColors.white,23, TextAlign.center, FontWeight.w500))),
                              ),
                            ),
                            gapWC(10),
                            tcnw(counterController.singleitem_count.value.toString(), AppColors.fontcolor, 12,TextAlign.center,FontWeight.w400),
                            gapWC(10),
                            Bounce(
                              onPressed: (){
                                counterController.fnincrement();
                              },
                              duration: const Duration(milliseconds: 110),
                              child: Material(
                                elevation: 0,
                                shadowColor:  Colors.white,
                                child: Container(
                                    height: 35,width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightfontcolor.withOpacity(0.7),
                                        borderRadius:BorderRadius.circular(10)
                                    ),
                                    child: Center(child: tcnw("+",AppColors.white,23, TextAlign.center, FontWeight.w500))),
                              ),
                            ),
                          ],
                        )


                      ],
                    ),),


                    gapHC(15),

                    Obx(() =>  CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Pay AED ${counterController.fnTotalAmount(item_datas["PRICE"].toString())}", onpressed: (){

                      counterController.fnPayButton(context,CounterMode.single,widget.itemdatas);
                 //     Get.off(SuccessScreen(amount: item_datas["PRICE"].toString(),card_id: "cardid...",transaction_id: "tranid....",date:  setDate(16,DateTime.now()),));
                    }, ),),
                    gapHC(10),
                  ],
                ),
              ),
            )
        )
    );
  }



  Widget wTaphere(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.tap_here, 70.2),
        gapHC(1),
        tsw("Tap here..",AppColors.lightfontcolor, 15,FontWeight.w500)

      ],
    );
  }
  Widget wHoldcard(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.hold_card, 70.2),
        gapHC(1),
        tsw("Hold Near Reader",AppColors.lightfontcolor, 15,FontWeight.w500)

      ],
    );
  }
  Widget wNotAvilble(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        imageSet(AppAssets.not_availble, 50.2),
        gapHC(7),
        tsw("NFC may not be supported or \n may be temporarily turned off",AppColors.lightfontcolor, 15,FontWeight.w500),
        gapHC(7),
        tsw("Retry",AppColors.lightfontcolor, 15,FontWeight.w500)



      ],
    );
  }
}
