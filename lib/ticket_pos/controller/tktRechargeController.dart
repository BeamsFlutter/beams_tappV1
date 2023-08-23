import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/commonbutton.dart';
import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/styles.dart';

class TicketRechargeController extends GetxController{


late PageController pageController;

TextEditingController txtCustomer = TextEditingController();
TextEditingController txtAmount = TextEditingController();
TextEditingController txtPackageAmount = TextEditingController(text: "999");
TextEditingController txtTotalAmount = TextEditingController();
var selectedPage = 0.obs;
var lstrSelectedPage = "AP".obs;
var pageIndex = 0.obs;
var lstrLastTransaction=[
  {
    "title":"Jumping Corner",
    "transactionDate":"12JULY2023 12:33",
    "trAmount":"-200.00"
  },
  {
    "title":"Recharge",
    "transactionDate":"11JULY2023 04:33",
    "trAmount":"+400.00"
  },
  {
    "title":"Jumping Corner",
    "transactionDate":"12JULY2023 12:33",
    "trAmount":"-200.00"
  },
  {
    "title":"Recharge",
    "transactionDate":"11JULY2023 04:33",
    "trAmount":"+400.00"
  },
  {
    "title":"Jumping Corner",
    "transactionDate":"12JULY2023 12:33",
    "trAmount":"-200.00"
  },

].obs;
var lstrPackages=[
  {
    "title":"GOLDEN PACKAGE",
    "itemName1":"Kids Train 2/5",
    "itemName2":"Jump 4/5",
    "itemName3":"Arts 3/5",
    "packageRate":"999.00",
    "count":4,
    "code":"D1"
  },
  {
    "title":"KIDS PACKAGE",
    "itemName1":"Kids Train 2/5",
    "itemName2":"Jump 4/5",
    "itemName3":"Arts 3/5",
    "packageRate":"999.00",
    "count":5,
    "code":"D2",
  },
  {
    "title":"UNLIMITED PACKAGE",
    "itemName1":"Kids Train 2/5",
    "itemName2":"Jump 4/5",
    "itemName3":"Arts 3/5",
     "count":2,
    "code":"D3",
    "packageRate":"999.00"
  },
  {
    "title":"KIDS PACKAGE",
    "itemName1":"Kids Train 2/5",
    "itemName2":"Jump 4/5",
    "itemName3":"Arts 3/5",
    "packageRate":"999.00",
    "code":"D4",
    "count":8
  },
  {
    "title":"GOLDEN PACKAGE",
    "itemName1":"Kids Train 2/5",
    "itemName2":"Jump 4/5",
    "itemName3":"Arts 3/5",
    "code":"D5",
    "packageRate":"999.00",
    "count":1
  },

].obs;
var lstrPaymentModeList=[
  {
    "mode":"Card",
    "code":"Cd",
  },
  {
    "mode":"Cash",
    "code":"Cs",
  },
  {
    "mode":"NBD CARD",
    "code":"Nbd",
  },
  {
    "mode":"Master CARD",
    "code":"mstr",
  },


].obs;
RxString paymentMode="".obs;
RxBool oldbalance = false.obs;
RxBool foc = false.obs;
RxBool isRechargeCompleted = false.obs;


RxString p1=''.obs;
RxString p2=''.obs;
RxString p3=''.obs;
RxString p4=''.obs;
RxString sitecode=''.obs;
Rx<PaymentMode> mode = PaymentMode.Card.obs;
RxBool isLogin = false.obs;
fnBackspace(){
if(txtAmount.text.length!=0){
  dprint( txtAmount.text.length );
  txtAmount.text= txtAmount.text.substring(0,txtAmount.text.length - 1);
  dprint(txtAmount.text);
  update();
  moveTextCursorPosition();
}

  // moveTextCursorPosition();
}
fnClearAll(){
  // isLogin.value=false;
   txtAmount.text="";
}
fnNumberPress(String val)async{
  dprint(val);
  txtAmount.text = txtAmount.text + val;
  moveTextCursorPosition();
}



fnChangePackageCount(mode,itemCode){
  var itemMenu = lstrPackages.value.where((element) => element["code"] == itemCode).toList();

  dprint("Item>>>>>> ${itemMenu}");
  dprint("itemCode  ${itemCode}");

  var i = 0;
  var exist = 0;

  for (var item in lstrPackages.value) {
    if (item["code"] == itemCode)  {
      exist = 1;
      if (mode == "A") {
        lstrPackages[i]["count"] = (mfnInt(item["count"]) + 1).toString();
        dprint(lstrPackages[i]["count"]);

      }
      if (mode == "D" && item["count"] != 0) {
        lstrPackages[i]["count"] = (mfnInt(item["count"]) - 1).toString();
        dprint(lstrPackages[i]["count"]);

      }
    }
    i++;
  }
  update();
}


wSelectPaymentModeBottomsheet(context){
  Size size = MediaQuery.of(context).size;
  return Get.bottomSheet(

    StatefulBuilder(builder: (BuildContext context,StateSetter setState){
      return   Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: boxBaseDecoration(Colors.white, 30),
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(25),
                width:size.width*0.6,
                child:isRechargeCompleted.value?

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          tc("Recharge Successful !!!",AppColors.appTicketDarkBlue, 25),
                          gapHC(6),
                          tc("#12234234",Colors.black, 23),
                          gapHC(6),
                          tc("12 JULY 2023 12:23 PM",Colors.grey, 12),
                        ],
                      ),
                    ),
                    gapHC(10),
                    Row(
                      children: [
                        TcketCommonButton(
                          buttoncolor: Colors.white,
                          buttonText: "Close",
                          border: Border.all(color: Colors.black,),
                          icon_need: false,
                          radius: 40,buttonTextSize: 15,


                          onpressed: (){
                            dprint("close");
                            Get.back();
                            setState(() {
                              isRechargeCompleted.value=false;
                            });

                          },         buttonTextColor: Colors.black.withOpacity(0.5),


                        ),



                        gapWC(20),
                        Expanded(
                          child: TcketCommonButton(
                            buttoncolor: AppColors.appTicketColor1,
                            buttonText: "Print",
                            icon_need: false,
                            border: Border.all(color:AppColors.appTicketColor1),
                            radius: 40,buttonTextSize: 18,
                            buttonTextColor: Colors.white,
                            onpressed: (){
                            dprint("Tapped On print");
                              Get.back();

                            setState(() {
                              isRechargeCompleted.value=false;
                            });


                              //
                              // ticketRechargeController.wSelectPaymentModeBottomsheet();
                            },


                          ),
                        ),
                      ],
                    )
                  ],
                )


                    :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    tHead2("Complete Payment", AppColors.appTicketDarkBlue),
                    gapHC(20),
                    Expanded(
                      child: SingleChildScrollView(
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: lstrPaymentModeList.asMap().entries.map((e) =>
                                RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: tSubHead(e.value["mode"].toString(), Colors.black,TextAlign.left),
                                    value: e.value["mode"],
                                    activeColor: AppColors.appTicketColor1,
                                    groupValue: paymentMode.value,
                                    onChanged: (value){
                                      setState(() {
                                        paymentMode.value=value!;
                                      });


                                    }
                                )).toList(),
                          )
                      ),
                    ),
                    gapHC(10),
                    Row(
                      children: [
                        TcketCommonButton(
                          buttoncolor: Colors.white,
                          buttonText: "Cancel",
                          border: Border.all(color: Colors.black,),
                          icon_need: false,
                          radius: 40,buttonTextSize: 15,


                          onpressed: (){
                            dprint("close");
                            Get.back();

                          },         buttonTextColor: Colors.black.withOpacity(0.5),


                        ),
                        gapWC(20),
                        Expanded(
                          child: TcketCommonButton(
                            buttoncolor: AppColors.appTicketColor1,
                            buttonText: "Completed",
                            icon_need: false,
                            border: Border.all(color:AppColors.appTicketColor1,),
                            radius: 40,buttonTextSize: 18,
                            buttonTextColor: Colors.white,
                            onpressed: (){
                              setState(() {
                                isRechargeCompleted.value=true;
                              });

                              //
                              // ticketRechargeController.wSelectPaymentModeBottomsheet();
                            },


                          ),
                        ),
                      ],
                    )


                  ],
                ),
              ),
            ],
          ),
          isRechargeCompleted.value? Positioned(
            top: 1,
            right: 1,
            left: 1,
            // child: Icon(Icons.check_circle,size: 65,color: Colors.greenAccent,)
            // child: CircleAvatar(
            //   radius: 35,
            //   backgroundColor: Colors.white,
            //   child: Icon(Icons.check,size: 44,color: Colors.green),
            // )
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,height: 100,
                  decoration: boxImageDecoration("assets/gifs/done.gif", 100),
                ),
              ],
            ),



          ):gapHC(0) ,

        ],
      );
    }),
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),

  );

}


void onClickRadioButton(value) {
  dprint(value);
  paymentMode.value = value;
  update();



}

void moveTextCursorPosition() {
  txtAmount.selection = TextSelection(
      baseOffset: txtAmount.text.length,
      extentOffset: txtAmount.text.length);
}

}
enum PaymentMode { Card, Cash, NBDCard,MasterCard }