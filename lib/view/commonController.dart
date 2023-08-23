import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/model/userloginModel.dart';
import 'package:beams_tapp/view/settings/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';

class CommonController extends GetxController{
  RxString Cardserial_number =''.obs;
  RxString wstrAcessToken =''.obs;
  RxString wstrCompanyName=''.obs;
  RxString wstrCompanyCode =''.obs;
  RxString wstrUserName =''.obs;
  RxString wstrUserCode =''.obs;
  RxString wstrRoleCode =''.obs;
  RxString wstrCode=''.obs;
  RxString selectcountry="+971".obs ;
  RxString printYn='Y'.obs;
  RxString wstrSunmiDevice='N'.obs;
  RxList wstrPendingList = [].obs;

  RxString wstrPrinterName =''.obs;
  RxString wstrPrinterPath =''.obs;
  RxString wstrPrinterCode=''.obs;

  Rx<NotificationDataModel> wNotificationDataModel = NotificationDataModel(DateTime.now(), 0.0, "","",DateTime.now()).obs;
  Rx<BluetoothPrinter> wBluetoothPrinter = BluetoothPrinter(address: "",deviceName: "",isBle: false,typePrinter: PrinterType.bluetooth).obs;



  //=============================================================READER DEVICE
  RxString wstrSiteCode=''.obs;
  // RxList<COUNTER> wstrCounterList = <COUNTER>[].obs;

  // RxString wstrUserMob =''.obs;
  //
  // final amountField = TextEditingController(text:"1");



mfnNullable(val,rtn){
  try{
    var rn = val??rtn;
    return rn;
  }catch(e){
    return rtn;
  }
}





}