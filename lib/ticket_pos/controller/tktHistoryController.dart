import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/common_functn.dart';

class TicketHistoryController extends GetxController{
  RxBool tapCard =false.obs;

  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;
  RxString dropdownvalue = 'All'.obs;

  var dropdownMenus = [
    'All',
    'Sale',

  ];

  var historyList = [
    {
      "counterName":"Jumping Corner",
      "date":"12 JULY 2023 13:44",
      "price":"-33"
    },
    {
      "counterName":"Kids Train",
      "date":"22 JULY 2023 03:44",
      "price":"-45"
    },
    {
      "counterName":"Jumping Corner",
      "date":"12 JULY 2023 13:44",
      "price":"-33"
    },{
      "counterName":"Zip Line",
      "date":"23 JULY 2023 12:44",
      "price":"-55"
    },{
      "counterName":"Water Play",
      "date":"12 August 2023 13:44",
      "price":"-55"
    },
    {
      "counterName":"Kids Train",
      "date":"22 JULY 2023 03:44",
      "price":"-45"
    },
    {
      "counterName":"Jump n Fun",
      "date":"12 JULY 2023 13:44",
      "price":"-23"
    },




  ].obs;


  Future<void> wSelectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1800, 8),
        lastDate:DateTime.now(),
        initialDate:fromDate.value);
    if (pickedDate != null && pickedDate != fromDate){
      fromDate.value = pickedDate ;
      dprint(fromDate.value);
      dprint("from DATE:  ${DateFormat('dd-MM-yyyy').format(fromDate.value)}");
    }

  }
  Future<void> wSelectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2500, 8),
        initialDate:   toDate.value);
    if (pickedDate != null && pickedDate != toDate){
      toDate.value = pickedDate ;
      dprint(toDate.value);
      dprint("to DATE:  ${DateFormat('dd-MM-yyyy').format(toDate.value)}");
    }

  }
}