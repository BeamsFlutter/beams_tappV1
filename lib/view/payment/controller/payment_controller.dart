 
import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
   
import 'package:beams_tapp/model/notification_DataModel.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';


class PaymentController extends GetxController{


  RxBool isTaped = true.obs;
  RxBool isAvailable = false.obs ;
  RxString cardnumb=''.obs;
  String printCode  ='SALE';
  var doctype ="CSAL";
  // RxBool payBtnPress = false.obs;
  CommonController commonController =Get.put(CommonController());
  ApiRepository apiRepository =ApiRepository();

  fnTaped(cudate,context,amount,docnumb,expdate,doctype)async{
    fnCheckNFCAvailability(cudate,context,amount,docnumb,expdate,doctype);
    // isTaped.value = false;

  }
  Future fnCheckNFCAvailability(cudate,context,amount,docnumb,expdate,doctype) async {
    // Check availability
    isAvailable.value = await NfcManager.instance.isAvailable();
    dprint("AVAILABLE  ${isAvailable.value}");
    if(isAvailable.value){
      dprint("hold..............");

      fnTagRead(cudate,context,amount,docnumb,expdate,doctype);
    }
  }
  ValueNotifier<dynamic> result = ValueNotifier(null);

  void fnTagRead(cudate,context,amount,docnumb,expdate,doctype) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');

        dprint("identifierddff  ${serialnumb}");
        // commonController.Cardserial_number.value = serialnumb!;
        cardnumb.value = serialnumb!;
        if(serialnumb != null){
          ///Payment Enabled

          // Get.off(SuccessScreen(amount:"500",card_id: cardnumb.value,transaction_id: "tranid....",date:  setDate(16,DateTime.now()),));
          // fnCardDetails(serialnumb,"N");
          dprint("AMTTTTT>>> ${amount.toString()}");
          fnAmounttoPay(cudate,context,amount,docnumb,expdate,doctype);
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




  fnAmounttoPay(cudate,context,amount,docnumb,expdate,doctype)async{
    var devid = await  Prefs.getString(AppStrings.deviceId);
    dprint("exp....dateeeeeeeeee.........  ${expdate}");
    dprint("cuu....dateeeeeeeeee.........  ${cudate}");
    try{
      var COUNTER_SALHEAD =[];
      var COUNTER_SALDET =[];
      COUNTER_SALDET.add(
        {
          "DOCTYPE" : doctype,
          "SRNO" : 1,
          "DOCDATE" : setDate(2, DateTime.now()),
          "ITEM_CODE" : "GEN",
          "ITEM_DESCP" : "GEN",
          "QTY" : 1,
          "PRICE" : amount,
          "AMT" : amount,
        },

      );

      COUNTER_SALHEAD.add({
        "DOCNO" : "",
        "DOCTYPE" : doctype,
        "BRNCODE" : "",
        "DOCDATE" : setDate(2, DateTime.now()),
        "CARDNO" : cardnumb.value,
        "NETAMT" :amount,
        "CREATE_USER" : commonController.wstrUserCode.value.toString(),
        "CREATE_DATE" : setDate(2, DateTime.now()),
        "CREATE_DEVICE" :devid
      }
      );




      if(cudate.isBefore(expdate)){
        print("Both DateTime are at same moment.");
        dprint(doctype);
        dprint(docnumb);

        final responseJson = await apiRepository.apiTapToPay(devid,COUNTER_SALHEAD,COUNTER_SALDET,doctype,docnumb);
        CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
        dprint("RESPONSE>>>>F>> ${responseJson[0]}");
        if (commonModel.sTATUS == "1") {


          CustomToast.showToast(
              commonModel.mSG.toString(), ToastType.success,
              ToastPositionType.end);
            fnNotifiactionTopay(amount,commonController.wstrCompanyCode.value, docnumb, commonModel.cODE.toString(), commonController.wstrUserCode.value, setDate(1, DateTime.now()), "Successful",cardnumb.value);
            Get.off(SuccessScreen(slcode: "",sldesc: commonModel.sLDESCP,amount: amount, transaction_id: commonModel.cODE.toString(), card_id: cardnumb.value,printCode: printCode,balance: commonModel.bALANCE.toString(), date: setDate(6, DateTime.now())));
            fnTaped(cudate,context,amount,docnumb,expdate,doctype);


        }
        else {
          // showDialog(
          //     context: context,
          //     builder: (context) =>  AlertDialog(
          //       title: tcnw("Alert!", AppColors.fontcolor, 18,TextAlign.start,FontWeight.w500),
          //       content: tcnw( commonModel.mSG.toString(),AppColors.fontcolor,12,TextAlign.start,FontWeight.w500),
          //       actions: [
          //         TextButton(
          //           onPressed: () {
          //             fnTagRead(context);
          //             // fnPayButton(context,totalamount.value);
          //             Get.back();
          //
          //           },
          //           child: tc("Retry",AppColors.primarycolor,13),
          //         ),
          //
          //       ],
          //     ));
          CustomToast.showToast(
              commonModel.mSG.toString(), ToastType.success,
              ToastPositionType.end);
          fnTaped(cudate,context,amount,docnumb,expdate,doctype);


        }

      }else{

        Get.showSnackbar(
          const GetSnackBar(
            message: 'Payment Expired...',
            duration: Duration(seconds: 2),
          ),
        );

        fnTaped(cudate,context,amount,docnumb,expdate,doctype);

      }


      ///////



    } catch (e) {
      dprint("!!!!!!!!!!!!!  >>  " + e.toString());

    }

  }

  void fnNotifiactionTopay(paidAmount, company, docno, trdocno, trnusr, trndate, response,cardnumb)async {
    dprint(paidAmount);
    dprint(company);
    dprint(docno);
    dprint(trdocno);
    dprint(trnusr);
    dprint(trndate);
    dprint(response);
    dprint(cardnumb);
   try{
     var devid = await  Prefs.getString(AppStrings.deviceId);
     final responseJson = await apiRepository.apiUpadtenotification(paidAmount, company, docno, trdocno, trnusr, trndate, response,cardnumb);
     dprint(",,,,,,,,,,,,,,,,,,,,,, responseee..........");
     dprint(responseJson);

     CommonModel commonModel =CommonModel.fromJson(responseJson[0]);
     if(commonModel.sTATUS=="1"){
       dprint("succcesss.....responseee.");
       CustomToast.showToast(
           "Successfully Paid..", ToastType.success,
           ToastPositionType.end);
       Get.offAll(()=>HomeScreen(notificationDataModel: NotificationDataModel(DateTime.now(), 0.0, "", "", DateTime.now())));
     }else {
       CustomToast.showToast(
           commonModel.mSG.toString(), ToastType.success,
           ToastPositionType.end);
       Get.offAll(()=>HomeScreen(notificationDataModel: NotificationDataModel(DateTime.now(), 0.0, "", "", DateTime.now())));
     }
   }catch(e){
     dprint(e.toString());
   }
  }




}