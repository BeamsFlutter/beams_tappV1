
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/payment/controller/payment_controller.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:beams_tapp/constants/common_functn.dart';

class PaymentScreen extends StatefulWidget {
  final double ? amount;
  final String ? transactionId;
  final String ? transactiondoctype;
  final DateTime ? expDate;
  final DateTime ? cuDate;


  const PaymentScreen({Key? key, required this.amount, this.transactionId, this.expDate, this.cuDate, this.transactiondoctype}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  void initState() {
    dprint("dooooctypeee in paymentscreen  ${widget.transactiondoctype}");
    paymentController.fnTaped(widget.cuDate,context, widget.amount, widget.transactionId,widget.expDate,widget.transactiondoctype);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    paymentController.isTaped.value =true;

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("build Running..............////////////// ");
    dprint(widget.cuDate);
    dprint(widget.expDate);


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        // title: tsw(AppStrings.services,AppColors.white,20,FontWeight.w500),
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
          decoration: commonBoxDecoration(AppColors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
            child: Obx(() => Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          tcnw("${widget.amount.toString()} AED", AppColors.fontcolor, 20, TextAlign.center,
                              FontWeight.w700),
                          ts(widget.transactionId.toString(), AppColors.lightfontcolor, 12),
                          gapHC(10),
                          GestureDetector(
                              onTap: (){
                                paymentController.isTaped.value?  paymentController.fnTaped(widget.cuDate,context, widget.amount, widget.transactionId,widget.expDate,widget.transactiondoctype):(paymentController.isAvailable.value ?  null :  paymentController.fnTaped(widget.cuDate,context, widget.amount, widget.transactionId,widget.expDate,widget.transactiondoctype));
                                dprint("tapped");
                              },
                              child: paymentController.isAvailable.value? wHoldcard():wNotAvilble()
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding:   const EdgeInsets.symmetric(horizontal: 40),
                    //   child: CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Pay",
                    //     onpressed: (){
                    //       dprint("Pay");
                    //       var amount = mfnDbl(widget.amount);
                    //       // Get.off(SuccessScreen(amount:"500",card_id: paymentController.cardnumb.value,transaction_id: "tranid....",date:  setDate(16,DateTime.now()),));
                    //
                    //        paymentController.fnPayButton(context,amount);
                    //       //   Get.to( CardIssueScreen(cardIssueFrom: CardIssueFro m.register));
                    //     }, ),

                  ],
                )),
          ),
        ),
      ),
    );
  }

  ///////Widget.......................................
  Widget wTaphere() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.tap_here, 70.2),
        gapHC(1),
        tsw("Tap here..", AppColors.lightfontcolor, 15, FontWeight.w500)
      ],
    );
  }

  Widget wHoldcard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.hold_card, 70.2),
        gapHC(1),
        tsw("Hold Near Reader", AppColors.lightfontcolor, 15, FontWeight.w500)
      ],
    );
  }

  Widget wNotAvilble() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        imageSet(AppAssets.not_availble, 50.2),
        gapHC(7),
        tsw("NFC may not be supported or \n may be temporarily turned off",
            AppColors.lightfontcolor, 15, FontWeight.w500),
        gapHC(7),
        tsw("Retry", AppColors.lightfontcolor, 15, FontWeight.w500)
      ],
    );
  }
}
