import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketStaffController extends GetxController{

  var lstr_staffList=[
    {
      "dev_name":"DEVICE 1",
      "staff_id":"C004",
      "staff_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
    },

    {
      "dev_name":"DEVICE 19",
      "staff_id":"COO41",
      "staff_name":"SALMAN",
      "date":"19 JANUARY 03:44 AM",
      "counter":"COUNTER 9",
      "status":"B",
    },

    {
      "dev_name":"DEVICE 5",
      "staff_id":"COOO31",
      "staff_name":"RSLAM",
      "date":"19 JULY 12:44 AM",
      "counter":"COUNTER 8",
      "status":"A",
    },
    {
      "dev_name":"DEVICE 8",
      "staff_id":"COO31",
      "staff_name":"SALMAN",
      "date":"30 JULY 12:44 AM",
      "counter":"COUNTER 3",
      "status":"A",
    },

    {
      "dev_name":"DEVICE 002",
      "staff_id":"COOO6",
      "staff_name":"ASLAM",
      "date":"12 OCTOBER 12:44 AM",
      "counter":"COUNTER 5",
      "status":"B",
    },
    {
      "dev_name":"DEVICE 001",
      "staff_id":"COOO3",
      "staff_name":"RASHID",
      "date":"16 JULY 12:44 AM",
      "counter":"COUNTER 3",
      "status":"A",
    },

    {
      "dev_name":"DEVICE 1",
      "staff_id":"COOO1",
      "staff_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"COUNTER 1",
      "status":"B",
    },



  ].obs;
  late PageController pageController;

  var selectedPage = 0.obs;
  var lstrSelectedPage = "UD".obs;
  var pageIndex = 0.obs;
  RxBool checkboxval = false.obs;
  RxBool checkboxOther = false.obs;


}