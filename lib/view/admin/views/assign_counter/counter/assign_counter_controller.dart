import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
  
     
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignCounterController extends GetxController{

  ApiRepository apiRepository = ApiRepository();
  RxBool getusername = false.obs;
  final GlobalKey<AnimatedListState>listkey = GlobalKey();

  //======================================Controller
  final TextEditingController txtUsercode = TextEditingController();
  final TextEditingController txtUsername = TextEditingController();
  var counterList = [
    "Counter 1",
    "Counter 2",
    "Counter 3",
    "Counter 4",
    "Counter 5",
    "Counter 6",
    "Counter 7",
    "Counter 8",
    "Counter 9",
    "Counter 10",
  ];





  //======================================Lookup
  fnUserLookup(){
      Get.to(() => LookupSearch(
        callbackfn: (data) {
          dprint(data);
          if(data!=null){
            getusername.value=true;
            // txtCounterDesc.text = data["DESCP"].toString();
            // txtCounterCode.text = data["CODE"].toString();
            Get.back();
          }
        },
        table_name: "COUNTER_MAST",
        column_names: const [
          {"COLUMN": "CODE", 'DISPLAY': "Code: "},
          {"COLUMN": "DESCP", 'DISPLAY': "Name: "},

        ],
        filter: [],
      )
      );

  }
  fnAddCounterLookup(){
    Get.to(() => LookupSearch(
      callbackfn: (data) {
        dprint(data);
        if(data!=null){
          // txtCounterDesc.text = data["DESCP"].toString();
          // txtCounterCode.text = data["CODE"].toString();
          Get.back();
        }

      },
      table_name: "COUNTER_MAST",
      column_names: const [
        {"COLUMN": "CODE", 'DISPLAY': "Code: "},
        {"COLUMN": "DESCP", 'DISPLAY': "Name: "},

      ],
      filter: [],
    )
    );

  }

}