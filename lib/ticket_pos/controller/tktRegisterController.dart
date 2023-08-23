import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/common_functn.dart';

class TicketRegisterController extends GetxController{

  final TextEditingController f_name_controller = TextEditingController();
  final TextEditingController mail_controller = TextEditingController();
  final TextEditingController phone_controller = TextEditingController();
  final TextEditingController address_controller = TextEditingController();
  final TextEditingController city_controller = TextEditingController();
  List gender = ["Male", "Female", "Other"];
  RxString gender_select = ''.obs;
  RxBool isAvailbleSlcode = false.obs;
  RxBool isRechargeCompleted = false.obs;
  RxString slcode ="".obs;

  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //final registerFormKey = GlobalKey<FormState>();
  final regformKey = GlobalKey<FormState>();
  // Barcode? result;
  // QRViewController? qrController;
  Rx<DateTime> dob = DateTime.now().obs;

  fnRegisteration(String ? genderval,DateTime dob) async {
    // if (regformKey.currentState!.validate()) {
    //   var gend, dateofbirth;
    //   try {
    //     dateofbirth = DateFormat('yyyy-MM-dd').format(dob);
    //     dprint("DOOOBB ${dateofbirth}");
    //     if (genderval == "Male") {
    //       gend = "M";
    //     } else if (genderval == "Female") {
    //       gend = "F";
    //     } else if (genderval == "Other") {
    //       gend = "O";
    //     }
    //     final responseJson = await apiRepository.apiRegistration(
    //         slcode.value,
    //         f_name_controller.text,
    //         mail_controller.text,
    //         phone_controller.text,
    //         dateofbirth,
    //         gend,
    //         address_controller.text,
    //         city_controller.text,
    //         commonController.selectcountry.value);
    //     dprint("regisretionnn ${responseJson[0]}");
    //     CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
    //     if (commonModel.sTATUS == "1") {
    //       CustomToast.showToast(
    //           isAvailbleSlcode.value ?  "Successfully Updated":"Successfully registered", ToastType.success,
    //           ToastPositionType.end);
    //       isAvailbleSlcode.value ?null: Get.to(() => CardIssueScreen(cardIssueFrom:CardIssueFrom.register,slCode: commonModel.cODE.toString()));
    //       fnClearRegData();
    //     } else {
    //       CustomToast.showToast(commonModel.mSG.toString(), ToastType.error, ToastPositionType.end);
    //     }
    //   } catch (e) {
    //     dprint("!!!!!!!!!!!!!  >>  " + e.toString());
    //     CustomToast.showToast(e.toString(), ToastType.error, ToastPositionType.end);
    //   }
    // }
    // else{
    //   dprint("Not vlidateee");
    // }
  }

  fnClearRegData(){

    isAvailbleSlcode.value=false;
    f_name_controller.text="";
    mail_controller.text="";
    address_controller.text="";
    phone_controller.text="";
    city_controller.text="";
  //  commonController.selectcountry.value="+971";

    gender_select.value="";
  }
}