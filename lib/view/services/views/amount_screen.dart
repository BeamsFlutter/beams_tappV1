import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/inputFormattor.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/payment/controller/pending_controller.dart';
import 'package:beams_tapp/view/payment/views/pending_screen.dart';
import 'package:beams_tapp/view/services/controller/serviece_controller.dart';
import 'package:beams_tapp/view/services/views/numPad.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {

  final ServieceController servieceController = Get.put(ServieceController());
  final PendingController pendingController = Get.put(PendingController());
  final CommonController commonController = Get.put(CommonController());
  @override
  void dispose() {
    dotarray.clear();
    servieceController.payBtnPress.value = false;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 2),(){
    //   pendingController.fnPendingPayment();
    // });
    dprint(commonController.wstrPendingList.value);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

          actions: <Widget>[
            // Using Stack to show Notification Badge
            Obx(() => Stack(
              children: <Widget>[
                IconButton(icon: const Icon(Icons.pending_actions_outlined), onPressed: () {
                  dprint("Press to Pending............");
                  dprint( commonController.wstrPendingList.value.isNotEmpty);

                  Get.to(()=>const PendingPayScreen())  ;
                    //counter = 0;

                }),
                pendingController.pendingList.value.isNotEmpty?
                Positioned(
                  left: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '${pendingController.pendingList.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ):SizedBox()
              ],
            ),)
          ],

          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.pending_actions_outlined, color: Colors.white),
          //     onPressed: () => Get.to(()=>const PendingPayScreen()),
          //   ),
          // ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: size.height,
              width: size.width,
              decoration: commonBoxDecoration(AppColors.white),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child:Column(
                    children: [
                      Expanded(
                        child: ListView(
                         physics: const BouncingScrollPhysics(),
                          children: [
                            const TitleWithUnderLine(title: "Amount to Pay"),
                            gapHC(20),

                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                      child: TextField(
                                        controller: servieceController.txtAmount,
                                        textAlign: TextAlign.center,
                                        showCursor: false,
                                        style: const TextStyle(fontSize: 20),
                                        inputFormatters:InputFormattor.mfnInputDecFormatters(),
                                        keyboardType: TextInputType.none,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your Amount",
                                          hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                                        ),
                                      )),
                                ),

                                gapHC(20),
                                //textfield


                              ],
                            ),
                            Center(
                                child:Obx(() =>  GestureDetector(
                                    onTap: (){
                                      servieceController.isTaped.value? servieceController.fnTaped(context):(servieceController.isAvailable.value ?  null :  servieceController.fnTaped(context));
                                      dprint("tapped");
                                    },
                                    child: servieceController.payBtnPress.value? (servieceController.isAvailable.value? wHoldcard():wNotAvilble()):const SizedBox()
                                ),)
                            ),
                            // gapHC(20),
                            // implement the custom NumPad
                            Center(
                              child: NumPad(
                                buttonSize: 50,
                                buttonColor:AppColors.primarycolor,
                                iconColor: AppColors.subcolor,
                                controller: servieceController.txtAmount,
                                delete: () {
                                  var backText = servieceController.txtAmount.text
                                      .toString().split('');
                                  dprint(backText);
                                  dprint(servieceController.txtAmount.text.length);
                                  dprint(backText[servieceController.txtAmount.text.length-1].toString() );

                                  if (backText[servieceController.txtAmount.text.length-1].toString() == ".") {
                                    dotarray.clear();
                                  }
                                  servieceController.txtAmount.text =
                                      servieceController.txtAmount.text
                                          .substring(0,
                                          servieceController.txtAmount.text
                                              .length - 1);
                                },

                                // onSubmit: () {
                                //   debugPrint('Your code: ${amountController.txtAmount.text}');

                                // },
                              ),
                            ),
                            gapHC(30),





                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CommonButton(
                          buttoncolor: AppColors.primarycolor,
                          icon_need: false,
                          buttonText: "Pay",
                          onpressed: () {
                            if(  commonController.wstrRoleCode.value =="ADMIN"){
                              var amount =mfnDbl(servieceController.txtAmount.text);
                              if(amount<=0 ){
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    message: 'Please Enter Valid Amount',
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                              }else{
                                servieceController.fnPayButton(context,amount);
                              }
                            }
                            // Get.to(CounterPaySingleScreen(itemdatas: [],));
                          },
                        ),
                      ),
                      gapHC(10),
                    ],
                  ),),
              ),
            )
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
