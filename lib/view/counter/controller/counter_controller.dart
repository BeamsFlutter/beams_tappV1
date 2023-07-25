

import 'dart:convert';
import 'dart:typed_data';

 
import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/counterMode.dart';

import 'package:beams_tapp/constants/styles.dart';
   
import 'package:beams_tapp/model/counterModel.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class CounterController extends GetxController{
  var singleitem_count = 1.obs;
  // RxInt tempindex =0.obs;
  var doctype ="CSAL";
  RxList lstrCounterList = [].obs;
  var lstrMultiItemList = [].obs;
  String printCode  ='SALE';
  RxString lstrCounterDescription="".obs;
  RxString lstrTotalAmount="".obs;
  RxDouble totalamaount=0.0.obs;
  ApiRepository apiRepository =ApiRepository();
  RxBool isTaped = true.obs;
  RxBool payBtnPress = false.obs;
  RxBool isAvailable = false.obs ;
  var count = 0.obs;
  var colors = [
    AppColors.subcolor,
    AppColors.primarycolor,
    AppColors.secondarycolor,
    Colors.indigo,
    Colors.yellow,
  ];
  final CommonController commonController = Get.put(CommonController());



  fnGetCounter()async{
        try{
          final responseJson = await apiRepository.apiGetCounters();
         // final jsonparser = jsonEncode(responseJson);
          final jsonParser = jsonEncode(responseJson);
          List<GetCounterModel>model = getCounterModelFromJson(jsonParser);

          lstrCounterList.value = responseJson;
          update();

         print('Listlengtthh>> ${lstrCounterList.value}');

        }catch(e){
          dprint("@error@  ${e.toString()}");
        }
      }

  fnTaped(context,mode,items)async{
    isTaped.value = false;
    fnCheckNFCAvailability(context,mode,items);

  }
  Future fnCheckNFCAvailability(context,mode,items) async {
    // Check availability
    isAvailable.value = await NfcManager.instance.isAvailable();
    dprint("AVAILABLE  ${isAvailable.value}");
    if(isAvailable.value){
      dprint("hold..............");
      fnTagRead(context,mode,items);
    }
  }
  ValueNotifier<dynamic> result = ValueNotifier(null);

  void fnTagRead(context,mode,items) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');

        dprint("identifierddff  ${serialnumb}");
        commonController.Cardserial_number.value = serialnumb!;
        if(commonController.Cardserial_number.value != null){

          fnSaveSale(context,commonController.Cardserial_number.value,mode,items);

          await NfcManager.instance.stopSession();

          update();
        }

        result.value = tag.data;
        if (result.value == null) return;
        await NfcManager.instance.stopSession();
      } catch (e) {
        await NfcManager.instance.stopSession();
      }
      NfcManager.instance.stopSession();
    });
  }


  fnCardSale(cardnumb)async{
     dprint("CardNumb ${cardnumb}");
     dprint("username ${commonController.wstrUserName.value}");
     var devid = await  Prefs.getString(AppStrings.deviceId);
     dprint("DEVICE IDDD ${devid}");
     dprint("create & doc date ${setDate(6, DateTime.now())}");
     dprint("Qty ${singleitem_count.value}");

  }


  // fnSaveDatas(){
  //   var sal_head = [];
  //   var sal_details = [];
  //
  // }

  var resetShow = false.obs;


  fnClearDetails(){
    dprint("Clear Car..d details ");
    isTaped.value =true;
    totalamaount.value=0.0;
    singleitem_count.value=1;
    payBtnPress.value = false;
    billItems.value=[];
    update();

  }
  fnTotalAmount(val){
    var itemamount = double.parse(val);
    totalamaount.value = singleitem_count.toDouble()*itemamount.toDouble();
    dprint("TotalAMount ${totalamaount}");
    return totalamaount;
  }


   fnincrement() {
     // tempindex.value = index;
     singleitem_count.value++;
    // update();
  }
   fndecrement() {
     // tempindex.value = index;
    if(singleitem_count.value!=1){
      singleitem_count.value--;
      // update();
    }
  }

//PayButton & PoceedButton..... In Single & multi
  fnPayButton(context,mode,items){
    resetShow.value = true;
    payBtnPress.value = true;
    fnTaped(context,mode,items);
  }

  fnSaveSale(BuildContext context,cardnumbr,mode,items)async{
    try{
    dprint(mode);
    dprint(items);
    var devid = await  Prefs.getString(AppStrings.deviceId);
    payBtnPress.value = true;
    var COUNTER_SALHEAD =[];
    var COUNTER_SALDET =[];
    var netamount = 0.0;
    if(mode==CounterMode.single){
      for (var e in items){
        COUNTER_SALDET.add(
          {
            "DOCTYPE" : doctype,
            "SRNO" : 1,
            "DOCDATE" : setDate(2, DateTime.now()),
            "ITEM_CODE" : e["ITEM_CODE"],
            "ITEM_DESCP" :  e["ITEM_DESCP"],
            "QTY" : singleitem_count.value,
            "PRICE" : e["PRICE"],
            "AMT" : mfnDbl(e["PRICE"])* singleitem_count.value
          },

        );
        netamount = mfnDbl(e["PRICE"])* singleitem_count.value;
      }
    }
    else{
      var qty = 0;
      var amount = 0.0;
      var srnumb = 1;
      for (var e in items){
        qty =fnGetQty(e["ITEM_CODE"]);
        if(qty>0) {
          amount = mfnDbl(e["PRICE"])* qty;
          COUNTER_SALDET.add(
            {
              "DOCTYPE": doctype,
              "SRNO": srnumb,
              "DOCDATE": setDate(2, DateTime.now()),
              "ITEM_CODE": e["ITEM_CODE"],
              "ITEM_DESCP": e["ITEM_DESCP"],
              "QTY": qty,
              "PRICE": e["PRICE"],
              "AMT": amount
            },

          );
          srnumb=srnumb+1;
          netamount +=amount;
        }

      }

    }

    COUNTER_SALHEAD.add({
        "DOCNO" : "",
        "DOCTYPE" : doctype,
        "BRNCODE" : "",
        "DOCDATE" : setDate(2, DateTime.now()),
        "CARDNO" : cardnumbr,
        "NETAMT" : netamount,
        "CREATE_USER" : commonController.wstrUserCode.value.toString(),
        "CREATE_DATE" : setDate(2, DateTime.now()),
        "CREATE_DEVICE" :devid
      }
    );


    final responseJson = await apiRepository.apiCardSale(devid,COUNTER_SALHEAD,COUNTER_SALDET);
    CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
    if (commonModel.sTATUS == "1") {
      CustomToast.showToast(
          commonModel.mSG.toString(), ToastType.success,
          ToastPositionType.end);
      fnClearDetails();
       Get.off(() => SuccessScreen(sldesc: "",slcode: "",amount: netamount.toString(), transaction_id:  commonModel.cODE.toString(), card_id: cardnumbr, date: setDate(16,DateTime.now()),printCode: printCode,));

    } else {
      showDialog(
          context: context,
          builder: (context) =>  AlertDialog(
             title: tcnw("Alert!", AppColors.fontcolor, 18,TextAlign.start,FontWeight.w500),
             content: tcnw( commonModel.mSG.toString(),AppColors.fontcolor,12,TextAlign.start,FontWeight.w500),
            actions: [
              TextButton(
               onPressed: () {

                 // fnPayButton(context,mode,items);
                 fnTagRead(context, mode, items);
                 Get.back();

              },
              child: tc("Retry",AppColors.primarycolor,13),
            ),

        ],
      ));


    }
  } catch (e) {
  dprint("!!!!!!!!!!!!!  >>  " + e.toString());
  // CustomToast.showToast(
  // e.toString(), ToastType.error, ToastPositionType.end);
  }

  //  Get.off(SuccessScreen(amount: amount,card_id: "cardid...",transaction_id: "tranid....",date:  setDate(16,DateTime.now()),));
  }

//////////////////////////////////////////////// Multiscreeen






  RxList billItems  = [].obs;
  // var rtnList  = [].obs;
  fnMinazQty(itemCode,price){
    //1.check item is there or not
    // qty +1
    if(billItems.where((element) => element["ITEM_CODE"] == itemCode).isEmpty){
      billItems.add({
        "ITEM_CODE":itemCode,
        "PRICE":price,
        "QTY":1,});
    }else{
      for(var e in billItems.value){
        if(e["ITEM_CODE"] == itemCode && e["QTY"]>0){
          e["QTY"] = e["QTY"]-1;
          print("MIN__QTYYY  ${  e["QTY"] }");
          //return;
        }
      }
    }
    //setState(() {});
    update();


    print("QTTMIN  ${billItems[0]["QTY"]}");
    //2.Add item to array with qty1

  }

  fnCalc(){
    print("Totalll ");
    var total  = 0.0;
    for (var e in billItems){
      var qty  = e["QTY"];
      var price  = e["PRICE"];
      var amt = qty * price;
      total += amt;

      print("Totalll ${total}");

    }
    return total;
  }

  fnGetQty(itemcode){
    var qty=0;
    var data = billItems.value.where((element) => element["ITEM_CODE"]==itemcode).toList();
    dprint("///// ${billItems.value}");
    if(data.isNotEmpty){
      // dprint(data);
      qty = data[0]["QTY"];

    }
    return qty;

  }



  fnAddQty(itemCode,price){
    //1.check item is there or not
    // qty +1
    if(billItems.where((element) => element["ITEM_CODE"] == itemCode).isEmpty){
      billItems.add({
        "ITEM_CODE":itemCode,
        "PRICE":price,
        "QTY":1,
      });
    }else{
      for(var e in billItems){

        if(e["ITEM_CODE"] == itemCode ){
          e["QTY"] = e["QTY"]+1;
          print("ADD_QTYYY  ${e["QTY"]}");

        }
      }
    }
    // setState(() {});

    update();
    print("QTTYSSS  ${billItems[0]["QTY"]}");

    //2.Add item to array with qty1

  }

  fnListItems(List itemlist){
    lstrMultiItemList.value = itemlist;

    dprint("#####");
    update();
  }





}