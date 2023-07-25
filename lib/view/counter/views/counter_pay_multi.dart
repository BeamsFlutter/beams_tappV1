import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/enums/counterMode.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/counter/controller/counter_controller.dart';
import 'package:beams_tapp/view/counter/views/counter_pay_single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class CounterPayMulti extends StatefulWidget {
  final dynamic itemdatas;
  const CounterPayMulti({Key? key, required this.itemdatas}) : super(key: key);

  @override
  State<CounterPayMulti> createState() => _CounterPayMultiState();
}

class _CounterPayMultiState extends State<CounterPayMulti> {
  final CounterController counterController = Get.put(CounterController());
 // final CounterController counterController1 = Get.find();




  @override
  void dispose() {
    counterController.fnClearDetails();

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    counterController.fnListItems(widget.itemdatas);
    dprint("ITEMLISTTT :  ${counterController.lstrMultiItemList}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actions: [
          Obx(() =>  counterController.resetShow.value ? TextButton(onPressed: (){
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
              decoration: commonBoxDecoration(AppColors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWithUnderLine(title: counterController.lstrMultiItemList[0]["COUNTER_DESCP"]),
                    gapHC(20),

                    Expanded(
                      child: GetBuilder<CounterController>(
                          builder: (controller){
                            dprint("@@@@  ${ controller.payBtnPress.value}");
                          return  Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.lstrMultiItemList.length,
                                  itemBuilder: (context,index){
                                    return  Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child:   Container(
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 20),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      tc(controller.lstrMultiItemList[index]["ITEM_DESCP"].toString(), AppColors.fontcolor, 12),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 20),
                                                        child: tc( controller.lstrMultiItemList[index]["PRICE"].toString(), AppColors.fontcolor, 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const VerticalDivider(
                                                    color: AppColors.lightfontcolor, //color of divider
                                                    width: 5, //width space of divider
                                                    thickness: 1.5, //thickness of divier line
                                                    indent: 10, //Spacing at the top of divider.
                                                    endIndent: 10, //Spacing at the bottom of divider.
                                                  ),
                                                  gapWC(15),
                                                  Bounce(
                                                    onPressed: () {
                                                      controller.fnMinazQty(counterController.lstrMultiItemList[index]["ITEM_CODE"],counterController.lstrMultiItemList[index]["PRICE"]);
                                                    },
                                                    duration: const Duration(milliseconds: 110),
                                                    child: Material(
                                                      elevation: 0,
                                                      shadowColor: Colors.white,
                                                      child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration: BoxDecoration(
                                                              color: AppColors.lightfontcolor.withOpacity(0.7),
                                                              borderRadius: BorderRadius.circular(10)),
                                                          child: Center(
                                                              child: tcnw("-", AppColors.white, 23,
                                                                  TextAlign.center, FontWeight.w500))),
                                                    ),
                                                  ),
                                                  gapWC(10),
                                                  tcnw(controller.fnGetQty(counterController.lstrMultiItemList[index]["ITEM_CODE"]).toString(), AppColors.fontcolor, 12,
                                                      TextAlign.center, FontWeight.w400),
                                                  gapWC(10),
                                                  Bounce(
                                                    onPressed: () {
                                                      controller.fnAddQty(counterController.lstrMultiItemList[index]["ITEM_CODE"],counterController.lstrMultiItemList[index]["PRICE"]);
                                                      // counterController.fnmulincrement(qty);
                                                    },
                                                    duration: const Duration(milliseconds: 110),
                                                    child: Material(
                                                      elevation: 0,
                                                      shadowColor: Colors.white,
                                                      child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration: BoxDecoration(
                                                              color: AppColors.lightfontcolor.withOpacity(0.7),
                                                              borderRadius: BorderRadius.circular(10)),
                                                          child: Center(
                                                              child: tcnw("+", AppColors.white, 23,
                                                                  TextAlign.center, FontWeight.w500))),
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                    );
                                  }),
                              ),

                              Obx(() =>       controller.payBtnPress.value? (controller.isAvailable.value? wHoldcard():wNotAvilble()):const SizedBox(),),
                              gapHC(30),
                              Center(child: tcnw("Total Amount = ${controller.fnCalc()}", AppColors.fontcolor, 15,TextAlign.start,FontWeight.w600)),

                              gapHC(15),
                              CommonButton(
                                buttoncolor: AppColors.primarycolor,
                                icon_need: false,
                                buttonText: "Pay AED ${controller.fnCalc()}",
                                onpressed: () {
                                  if(controller.fnCalc()==0.0){
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        message: 'Please Select One  Items',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }else{
                                    controller.fnPayButton(context,CounterMode.multiple,controller.lstrMultiItemList) ;
                                  }

                                  // Get.to(CounterPaySingleScreen(itemdatas: [],));
                                },
                              ),
                              gapHC(10),
                            ],
                          );
                      }),
                    ),


                  ],
                ),)
              ),
            )));
  }


  // List<Widget> wItemList(){
  //   List<Widget> rtnList  = [];
  //   for(var e in counterController.lstrMultiItemList){
  //     rtnList.add(
  //         Container(
  //           height: 50,
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(right: 20),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       tc(e["ITEM_DESCP"].toString(), AppColors.fontcolor, 12),
  //                       Padding(
  //                         padding: const EdgeInsets.only(right: 20),
  //                         child: tc( e["PRICE"].toString(), AppColors.fontcolor, 15),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const VerticalDivider(
  //                     color: AppColors.lightfontcolor, //color of divider
  //                     width: 5, //width space of divider
  //                     thickness: 1.5, //thickness of divier line
  //                     indent: 10, //Spacing at the top of divider.
  //                     endIndent: 10, //Spacing at the bottom of divider.
  //                   ),
  //                   gapWC(15),
  //                   Bounce(
  //                     onPressed: () {
  //                       counterController.fnMinazQty(e["ITEM_CODE"],e["PRICE"]);
  //                     },
  //                     duration: const Duration(milliseconds: 110),
  //                     child: Material(
  //                       elevation: 0,
  //                       shadowColor: Colors.white,
  //                       child: Container(
  //                           height: 35,
  //                           width: 35,
  //                           decoration: BoxDecoration(
  //                               color: AppColors.lightfontcolor.withOpacity(0.7),
  //                               borderRadius: BorderRadius.circular(10)),
  //                           child: Center(
  //                               child: tcnw("-", AppColors.white, 23,
  //                                   TextAlign.center, FontWeight.w500))),
  //                     ),
  //                   ),
  //
  //                   gapWC(10),
  //                   tcnw(counterController.fnGetQty(e["ITEM_CODE"]).toString(), AppColors.fontcolor, 12,
  //                       TextAlign.center, FontWeight.w400),
  //                   gapWC(10),
  //                   Bounce(
  //                     onPressed: () {
  //                       counterController.fnAddQty(e["ITEM_CODE"],e["PRICE"]);
  //                       // counterController.fnmulincrement(qty);
  //                     },
  //                     duration: const Duration(milliseconds: 110),
  //                     child: Material(
  //                       elevation: 0,
  //                       shadowColor: Colors.white,
  //                       child: Container(
  //                           height: 35,
  //                           width: 35,
  //                           decoration: BoxDecoration(
  //                               color: AppColors.lightfontcolor.withOpacity(0.7),
  //                               borderRadius: BorderRadius.circular(10)),
  //                           child: Center(
  //                               child: tcnw("+", AppColors.white, 23,
  //                                   TextAlign.center, FontWeight.w500))),
  //                     ),
  //                   ),
  //
  //                 ],
  //               )
  //             ],
  //           ),
  //         )
  //     );
  //   }
  //
  //   //   rtnList.add(tcnw("Qty = "+fnGetQty().toString(), AppColors.fontcolor, 15,TextAlign.start,FontWeight.w600));
  //   gapHC(30);
  //   rtnList.add(counterController.payBtnPress.value ? (counterController.isAvailable.value? wHoldcard():wNotAvilble()):const SizedBox());
  //
  //   return rtnList;
  // }
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




