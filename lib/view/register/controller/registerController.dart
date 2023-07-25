import 'dart:convert';

import 'package:beams_tapp/common_widgets/CommonAlertDialog.dart';
 
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/enums/intialmode.dart';
  
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/styles.dart';
   
import 'package:beams_tapp/model/notification_DataModel.dart';
     
import 'package:beams_tapp/view/card_issue/controller/cardissue_controller.dart';
import 'package:beams_tapp/view/card_issue/views/cardissue_screen.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:beams_tapp/view/register/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';

class RegisterController extends GetxController {
  ApiRepository apiRepository = ApiRepository();
  final CommonController commonController = Get.put(CommonController());


  final TextEditingController f_name_controller = TextEditingController();
  final TextEditingController mail_controller = TextEditingController();
  final TextEditingController phone_controller = TextEditingController();
  final TextEditingController address_controller = TextEditingController();
  final TextEditingController city_controller = TextEditingController();
  List gender = ["Male", "Female", "Other"];
  RxString gender_select = ''.obs;
  RxBool isAvailbleSlcode = false.obs;
  RxString slcode ="".obs;

  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //final registerFormKey = GlobalKey<FormState>();
  final regformKey = GlobalKey<FormState>();
  // Barcode? result;
  // QRViewController? qrController;
  Rx<DateTime> dob = DateTime
      .now()
      .obs;



  fnRegisteration(String ? genderval,DateTime dob) async {
    if (regformKey.currentState!.validate()) {
      var gend, dateofbirth;
      try {
        dateofbirth = DateFormat('yyyy-MM-dd').format(dob);
        dprint("DOOOBB ${dateofbirth}");
        if (genderval == "Male") {
          gend = "M";
        } else if (genderval == "Female") {
          gend = "F";
        } else if (genderval == "Other") {
          gend = "O";
        }
        final responseJson = await apiRepository.apiRegistration(
            slcode.value,
            f_name_controller.text,
            mail_controller.text,
            phone_controller.text,
            dateofbirth,
            gend,
            address_controller.text,
            city_controller.text,
            commonController.selectcountry.value);
        dprint("regisretionnn ${responseJson[0]}");
        CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
        if (commonModel.sTATUS == "1") {
          CustomToast.showToast(
              isAvailbleSlcode.value ?  "Successfully Updated":"Successfully registered", ToastType.success,
              ToastPositionType.end);
          isAvailbleSlcode.value ?null: Get.to(() => CardIssueScreen(cardIssueFrom:CardIssueFrom.register,slCode: commonModel.cODE.toString()));
          fnClearRegData();
        } else {
          CustomToast.showToast(commonModel.mSG.toString(), ToastType.error, ToastPositionType.end);
        }
      } catch (e) {
        dprint("!!!!!!!!!!!!!  >>  " + e.toString());
        CustomToast.showToast(e.toString(), ToastType.error, ToastPositionType.end);
      }
    }
else{
  dprint("Not vlidateee");
    }
  }
  fnUpdation(){

  }

  fnClearRegData(){

    isAvailbleSlcode.value=false;
    f_name_controller.text="";
    mail_controller.text="";
    address_controller.text="";
    phone_controller.text="";
    city_controller.text="";
    commonController.selectcountry.value="+971";

    // f_name_controller.clear();
    // mail_controller.clear();
    // address_controller.clear();
    // phone_controller.clear();
    // city_controller.clear();
    // dob_controller.clear();
    gender_select.value="";
  }


 // fnChangeOnpopval(){
 //   canPop.value = true;
 //   update();
 // }

 fnBack(context){
   return showDialog(
     context: context,
     builder: (context) => CommonAlertDialog(onpressed: (){
        fnClearRegData();
        Get.offAll( HomeScreen(notificationDataModel: NotificationDataModel(DateTime.now(), 0.0, "","",DateTime.now())));
       // Get.back();
       // Get.back();

     },alertmode: Alertmode.exit,
     )
   );
 }

    // }


    // void _checkIfValidQR(Barcode scanData) async {
    //   try {
    //     final Map<String, dynamic> _customerJson = json.decode(scanData.code!);
    //
    //     f_name_controller.text = _customerJson['fname'];
    //     mail_controller.text = _customerJson['mail'];
    //     phone_controller.text = _customerJson['phone'];
    //     age_controller.text = _customerJson['age'];
    //     address_controller.text = _customerJson['address'];
    //     city_controller.text = _customerJson['city'];
    //
    //     if (  f_name_controller.text != null && mail_controller.text  != null) {
    //       navigateBackIfScannedAndValidated();
    //
    //
    //     }
    //   } on FormatException catch (e) {
    //     dprint("EXCEPTION   :::>>>>>>>>>>>>  "+e.message);
    //   }
    // }
    // void navigateBackIfScannedAndValidated() {
    //   final Map<String, String> _finalTokenDetails = {
    //     "nftAddress": f_name_controller.text,
    //     "tokenId":  mail_controller.text,
    //     "name":  phone_controller.text,
    //     "imageUrl":  age_controller.text ,
    //     "holderAddress": address_controller.text,
    //     "tokenName":city_controller.text ,
    //
    //   };
    //   qrController?.stopCamera();
    //   qrController?.dispose();
    //   Future.delayed(
    //       Duration.zero,
    //           () => Get.to(RegisterScreen())
    //   );
    // }


}