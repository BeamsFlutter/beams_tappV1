  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/pendingPayModel.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';

class PendingController extends GetxController{



  ApiRepository apiRepository = ApiRepository();
  late Future<dynamic>futureform;
  RxList pendingList = [].obs;


/////FUNCTION................................................
  fnPendingPayment()async{
    try{
      var devid = await  Prefs.getString(AppStrings.deviceId);
      var response =  await apiRepository.apiPendingPayment(devid);
      dprint("ddddddddd   ${response.toString()}");
       fnGetPendingPayRes(response);
    }catch(e){
      dprint("cacheeee ${e.toString()}");
    }

  }
  fnGetPendingPayRes(value) {
    dprint("Pendingasfdtttt.... ");
    dprint(value);
    PendingPaymentModel pendingPaymentModel = PendingPaymentModel.fromJson(value);
    pendingList.value = pendingPaymentModel.pENDING!;

    ////MODELING....

  }








}