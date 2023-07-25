import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/numbers.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/controller/home_controller.dart';
import 'package:beams_tapp/view/login/controller/login_controller.dart';
import 'package:beams_tapp/view/recharge/controller/recharge_controller.dart';
import 'package:beams_tapp/view/recharge/views/customerHistory.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class PaymentReturn extends StatefulWidget {
  final String cardserailnumb;
  PaymentReturn({Key? key, required this.cardserailnumb,}) : super(key: key);

  @override
  @override
  State<PaymentReturn> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<PaymentReturn> {

  final RechargeController rechargeController = Get.put(RechargeController());



  @override
  void initState() {
    // TODO: implement initState
    dprint("CardSerialNumber.... ${widget.cardserailnumb}");
   // rechargeController.cardnumber.value =widget.cardserailnumb;
    if(widget.cardserailnumb.isNotEmpty){
      rechargeController.gotDtas.value=true;
      Future.delayed(const Duration(seconds: 1), () {
        rechargeController.fnCardDetails(widget.cardserailnumb,"N");
        dprint("call detail apiiiiiiii with card number");
        // rechargeController.fnCustomerData(widget.cardserialnumber);
      });

      //Call detailApi with cardnumber
    }else{
      rechargeController.gotDtas.value=false;
    }

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw("Refund",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() =>     rechargeController.gotDtas.value? IconButton(
            icon: const Icon(Icons.refresh_outlined, color: Colors.white,size: 25),
            onPressed: () {
              rechargeController.fnResetDatas();
              dprint("reset  ${rechargeController.gotDtas.value}");
            },
          ):SizedBox(),),

          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,size: 25,),
            onPressed: () {
              dprint("search");
              Get.to(() => LookupSearch(
                callbackfn: (data) {
                  if(data!=null){
                    rechargeController.isTaped.value =true;
                    dprint("CARDNUMBER:>>>  ${data["CARDNO"]}");
                    rechargeController.fnCardDetails(data["CARDNO"],"N");
                    Get.back();
                  }

                },
                table_name: "(SELECT A.SLCODE,B.SLDESCP,B.MOBILE,B.EMAIL,A.CARDNO FROM CUSTOMER_CARDS A LEFT JOIN SLMAST B ON (A.SLCODE =  B.SLCODE)) AS TABLE1",
                column_names: const [

                  {"COLUMN": "SLDESCP", 'DISPLAY': "Name: "},
                  {"COLUMN": "MOBILE", 'DISPLAY':"Mobile No:"},
                  {"COLUMN": "SLCODE", 'DISPLAY': "Code#: "},
                  {"COLUMN": "CARDNO", 'DISPLAY': "Card No: "},

                ],
                filter: [],
              )
              );

            },
          ),


        ],
      ),
      body: Obx(() => rechargeController.gotDtas.value ==true? wCardwithDatas(size,rechargeController.cardnumber.value,rechargeController.customer_name.value): Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(
          child: Container(
              height: size.height,
              width: size.width,
              decoration:  commonBoxDecoration(AppColors.white),

              child: Stack(
                children: [
                  wSplashCard(size,rechargeController.cardnumber.value,rechargeController.customer_name.value),
                  Center(
                    child: Obx(() => GestureDetector(
                        onTap: (){
                          rechargeController.isTaped.value ? rechargeController.fnTaped(context,"N"): (rechargeController.isAvailable.value ?  null :  rechargeController.fnTaped(context,"N"));
                        },
                        child: rechargeController.isTaped.value ? wTaphere() : (rechargeController.isAvailable.value ? wHoldcard(): wNotAvilble()

                        )
                    ),),)

                ],)
          ),
        ),
      ),)
    );
  }

  Widget wTaphere(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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
  Widget wCardwithDatas(size,cardnumber,name){
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Stack(
        // fit: StackFit.expand,
        children: [
          Container(
            height: size.height,
            decoration:  commonBoxDecoration(AppColors.white),

            child: Column(
              children: [
                Expanded(

                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 30,right: 30,bottom: 26,top: size.height*0.166),
                      child: Form(
                          key:rechargeController.topupFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: th(name.toString().toUpperCase(), AppColors.fontcolor, 15)),
                                th(rechargeController.cardnumber.value.toString().toUpperCase(), AppColors.fontcolor, 13),
                              ],
                            ),
                            gapHC(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ts("Email: ", AppColors.fontcolor, 12),
                                Expanded(child: ts(rechargeController.customer_email.value, AppColors.fontcolor, 13)),
                              ],
                            ),
                            gapHC(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ts("Mobile: ", AppColors.fontcolor, 12),
                                ts(rechargeController.customer_mobile.value, AppColors.fontcolor, 13),
                              ],
                            ),
                            gapHC(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tcnw("Remaining Bal:", AppColors.fontcolor, 18,TextAlign.center,FontWeight.w600),
                                th(rechargeController.customer_remaingBalnce.value.toString(), AppColors.fontcolor, 18),
                              ],
                            ),
                            gapHC(8),
                            const Divider(thickness: 2), gapHC(8),
                            rechargeController.historyList.length!=0?Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tsw("History",AppColors.fontcolor,15,FontWeight.w700),
                                gapHC(8),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightfontcolor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ts(rechargeController.historyList[0].tITLE.toString(), AppColors.fontcolor, 12),
                                          gapHC(2),
                                          ts(mfnDate(rechargeController.historyList[0].dOCDATE.toString(),2), AppColors.fontcolor, 12),
                                          gapHC(2),
                                          ts(rechargeController.historyList[0].dOCNO.toString(), AppColors.fontcolor, 12),
                                        ],
                                      ),
                                      th(rechargeController.historyList[0].aMT.toString(), AppColors.fontcolor, 18),

                                    ],
                                  ),
                                ),
                                gapHC(5),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> CustomerHistory(cardserailnumb:rechargeController.cardnumber.value));
                                  },
                                  child: Container(alignment: Alignment.bottomRight,
                                      child: tsw("ViewAll",AppColors.primarycolor,10,FontWeight.w700)),
                                ),
                                gapHC(8),
                              ],
                            ):SizedBox(),



                            tsw("Refund Amount",AppColors.fontcolor,15,FontWeight.w700),
                            gapHC(18),
                            // Material(
                            //   elevation: 30.0,
                            //   shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
                            //   child: TextFormField(
                            //     keyboardType: TextInputType.number,
                            //     autofocus: false,
                            //     controller: loginController.amountController,
                            //     decoration: InputDecoration(
                            //         hintText: 'Enter the amount you want to pay',
                            //         fillColor: Colors.white,
                            //         hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                            //         filled: true,
                            //         border: InputBorder.none,
                            //         contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            //         enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0),
                            //             borderSide: const BorderSide(color: Colors.white, width: 3.0))
                            //     ),
                            //   ),
                            // ),
                            CommonTextfield(controller: rechargeController.txtAmount,textFormFieldType: TextFormFieldType.amount,shadow: 30.0,opacityamount: 0.4,hintText: 'Enter the amount you want to return',paymentEnable: true),
                            gapHC(38),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                wCardAmount("50") ,
                                wCardAmount("100"),
                                wCardAmount("300"),
                                wCardAmount("500"),
                              ],
                            ),
                            gapHC(28),
                            Row(
                              children: [
                                ts(
                                    "Payment Method",
                                    AppColors.fontcolor,
                                    12),
                                gapWC(10),
                                Container(
                                  height: 23,
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(6),
                                      border: Border.all(
                                        color: AppColors.primarycolor,
                                      )),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(10)),
                                    // Initial Value
                                    value: rechargeController
                                        .initial_payment_mode.value
                                        .toString(),
                                    // Down Arrow Icon
                                    // icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),
                                    // Array list of items
                                    items: rechargeController
                                        .paymnet_mode
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: tcnw(
                                            items,
                                            AppColors.fontcolor,
                                            12,
                                            TextAlign.center,
                                            FontWeight.w300),
                                      );
                                    }).toList(),
                                    onChanged: (dynamic value) {
                                      rechargeController
                                          .fnOnChangePayment(value);
                                    },
                                    // onChanged: (String? newValue) {
                                    //   // setState(() {
                                    //   //   dropdownvalue = newValue!;
                                    //   // });
                                    // },
                                  ),
                                ),
                              ],
                            ),




                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Pay", onpressed: (){
                    rechargeController.cardnumber.value.isNotEmpty && (mfnDbl(rechargeController.txtAmount.text) <= mfnDbl(rechargeController.customer_remaingBalnce.value))?     rechargeController.fnPay(context,mfnDbl(rechargeController.txtAmount.text) , rechargeController.cardnumber.value, rechargeController.initial_payment_mode.value,"Y",rechargeController.customer_name.value) :
                    Get.showSnackbar(
                      const GetSnackBar(
                        message: 'Please Check Entered Amount',
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }, ),
                ),
                gapHC(10)
              ],
            ),
          ),
          wSplashCard(size,cardnumber,name)


        ],
      ),
    );
  }
  Widget wSplashCard(size,String cardnumber,name){
    return   Align(
      heightFactor: 0.22,
      child: Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: () {  },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                    AppAssets.splashCard),
                fit: BoxFit.cover,
              ),

              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.only(top: 8,bottom: 8,left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Flexible(child: tc(name??"", AppColors.fontcolor, 11))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tc(cardnumber.toUpperCase()??"", AppColors.fontcolor, 11),
                    const SizedBox(),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  wCardAmount(value){
   return Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: (){
          rechargeController.txtAmount.text = value;
        },
        child: Material(
          elevation: 30,
          shadowColor:  AppColors.lightfontcolor.withOpacity(0.4),
          child: Container(

              height: 45,width: 45,
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius:BorderRadius.circular(1)
              ),
              child: Center(child:  tcnw(value,AppColors.fontcolor,16, TextAlign.center, FontWeight.w500))),
        )
    );
  }

}
