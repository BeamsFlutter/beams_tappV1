  
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/card_issue/controller/cardissue_controller.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardIssuePendingController extends GetxController{

  late Future <dynamic> futureform;
  RxList cardissuependingList = [].obs;
  ApiRepository apiRepository =ApiRepository();
  final CommonController commonController = Get.put(CommonController());
  final CardIssueController cardIssueController = Get.put(CardIssueController());


  fnCardissuePending()async{
    dprint("token function");

    try{
      var usercode = commonController.wstrUserCode.value;
      var devid = await  Prefs.getString(AppStrings.deviceId);
     futureform =  apiRepository.apiCardissuePending(devid,usercode);
      futureform.then((value) => fnCardissuePendingRes(value));

    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }

  }
  fnCardissuePendingRes(val){

    cardissuependingList.value = val;
  }




}