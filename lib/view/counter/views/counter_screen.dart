import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/counter/controller/counter_controller.dart';
import 'package:beams_tapp/view/counter/views/counter_pay_multi.dart';
import 'package:beams_tapp/view/counter/views/counter_pay_single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  final CounterController counterController = Get.put(CounterController());

@override
  void initState() {
    // TODO: implement initState
  Future.delayed(const Duration(seconds: 2), () {
    counterController.fnGetCounter();
  });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(
        elevation: 0,
        title: tsw( AppStrings.counters,AppColors.white,20,FontWeight.w500),
         leading: IconButton(
               icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
          ),
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

            const TitleWithUnderLine(title: AppStrings.counters),
            gapHC(20),
         tsw("Please choose the counters from below.", AppColors.lightfontcolor, 12,FontWeight.w500),
            gapHC(25),
            Expanded(

              child: Obx(() => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  // itemCount:  2,
                  itemCount:  counterController.lstrCounterList.length,
                  itemBuilder: (context,index){
                    var datalist = counterController.lstrCounterList[index];
                    dprint("@@--------------------------------------------->>>>>");
                    dprint(datalist);
                    return counterController.lstrCounterList.isNotEmpty? Padding(
                      padding:  EdgeInsets.only(top: index==0?0:10),
                      child: Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: (){
                          dprint(datalist["ITEMS"]);
                          if(datalist["ITEMS"].length==1){
                            dprint("move to single page with ${datalist["DESCP"].toString()}");
                            Get.to(CounterPaySingleScreen(itemdatas:datalist["ITEMS"]));
                          }else if(datalist["ITEMS"].length>1){
                            dprint("move to Multi page with ${datalist["DESCP"].toString()}");
                            Get.to(CounterPayMulti(itemdatas:datalist["ITEMS"]));
                          }

                          // Get.to(CounterPaySingleScreen(countername: counterController.counter[index]));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: index<2? counterController.colors[index]:Colors.black,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: tc(datalist["DESCP"].toString(),AppColors.white, 16),
                          ),
                        ),
                      ),
                    ):Center(
                      child: tc("No Counters Found", AppColors.fontcolor, 12),
                    );
                  }),)
            ),
            gapHC(10),
            // Expanded(
            //   child: GridView.builder(
            //       physics: BouncingScrollPhysics(),
            //     shrinkWrap: true,
            //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //           maxCrossAxisExtent: 100,
            //           mainAxisExtent: 90.2,
            //           childAspectRatio: 2 / 2,
            //           crossAxisSpacing: 10,
            //           mainAxisSpacing: 10),
            //       itemCount: counterController.indexval,
            //       itemBuilder: (BuildContext ctx, index) {
            //         return Padding(
            //           padding: const EdgeInsets.only(top: 2),
            //           child: Bounce(
            //             duration: Duration(milliseconds: 110),
            //             onPressed: (){
            //               Get.to(CounterPayMulti(countername: counterController.counter[index]));
            //             },
            //             child: Container(
            //               alignment: Alignment.center,
            //
            //               // width: 120,
            //               decoration: BoxDecoration(
            //                   color: index<counterController.indexval? counterController.colors[index]:Colors.black,
            //                   borderRadius: BorderRadius.circular(10)
            //               ),
            //               child: Center(
            //                 child: tc(index<3?counterController.counter[index]:"Zipline",AppColors.white, 16),
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // ),





          ],
        ),
      ),
    )
    )
    );
  }
}
