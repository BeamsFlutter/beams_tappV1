

  
import 'dart:async';

import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/printerModel.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';


class SettingsController extends GetxController {

  TextEditingController txtPrinter =TextEditingController();
  TextEditingController txtSystemPrinter =TextEditingController();
  final CommonController commonController = Get.put(CommonController());
  ApiRepository apiRepository =ApiRepository();
  late Future <dynamic> futureform;
  RxList printerList =[].obs;




fnSavePrinterdatas(prntr_path,prntr_name,prntr_code)async{
  dprint("prntr_code....................  ${prntr_code}");
  dprint("prntr_name....................  ${prntr_name}");
  dprint("prntr_path....................  ${prntr_path}");
  commonController.wstrPrinterPath.value = prntr_path;
  commonController.wstrPrinterName.value = prntr_name;
  commonController.wstrPrinterCode.value = prntr_code;
  await Prefs.setString(AppStrings.printer_code, prntr_code);
  await Prefs.setString(AppStrings.printer_name, prntr_name);
  await Prefs.setString(AppStrings.printer_path, prntr_path);

}
  fngetpagedata(){
  txtPrinter.text = commonController.wstrPrinterName.value;
  txtSystemPrinter.text = commonController.wBluetoothPrinter.value.deviceName.toString();
  }

fnGetPrinters()async{
  try{
    var devid = await  Prefs.getString(AppStrings.deviceId);
    futureform =  apiRepository.apiGetPrinter(devid);
    futureform.then((value) => fnGetPrinterRes(value));

  }catch(e){
    dprint("SeTTING CONTROLLER......error${e.toString()}");
  }

}
  fnGetPrinterRes(val){
    dprint("printerrrrrrrrrrrrr");
    dprint(val);
    //PrinterModel printerModel = PrinterModel.fromJson(val[0]);
    printerList.value = val;



  }



}



