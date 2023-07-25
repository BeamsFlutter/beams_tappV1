import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LookupController extends GetxController{
  final TextEditingController search_controller = TextEditingController();
  ApiRepository apiRepository = ApiRepository();
  var search_result=[].obs;




  fnLookupSearch(tableName,column,filter,String value)async {
    try{
      var lookup_column = "";
      var lookup_filter = [];

    for(var i in column){
      dprint("CONTENT>>>>>>>>>  ${value}");

      lookup_filter.add({ "Column": i["COLUMN"], "Operator": "LIKE", "Value":value.toString(), "JoinType": "OR" });
        lookup_column +=  i['COLUMN'] + "|";
      }

      dprint("Filtter >>>> ${filter}");
      final responseJson = await apiRepository.apiLookupSerach(tableName,lookup_column,lookup_filter);
      search_result.value=responseJson;
      update();
      dprint("search_result.value::>>>>>>>>  ${search_result.value}");
    }catch(e){
      dprint(e);
    }

  }




}