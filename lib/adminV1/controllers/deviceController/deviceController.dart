import 'package:flutter/material.dart';
import 'package:get/get.dart';

  class DeviceController extends GetxController {

  var wstrPageMode = 'VIEW'.obs;
  late PageController pageController;
  var selectedPage = 0.obs;
  var lstrSelectedPage = "R".obs;
  var pageIndex = 0.obs;
  Rx<TextEditingController> txtDevicename =TextEditingController().obs;
  Rx<TextEditingController> txtSite =TextEditingController().obs;
  var lstr_deviceList=[
    {
      "dev_name":"DEVICE 1",
      "id":"ASPOIGG POJKFFJF",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },


    {
      "dev_name":"DEVICE 5",
      "id":"JKHJKHJ SFDSF",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"O",
      "imageUrl":"https://microless.com/cdn/products/44ed9032a7405b0253001e4633b35663-hi.jpg"
    },    {
      "dev_name":"DEVICE 6",
      "id":"CXZVC VNVBVN",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
      "imageUrl": "https://images.shopkees.com/uploads/cdn/images/1000/8444070525_1645005145.jpg"
    },    {
      "dev_name":"DEVICE 7",
      "id":"ERTERER LKLLLL",
      "user_name":"RAFEEQ",
      "date":"11 DECEMBER 34:44 PM",
      "counter":"ZIPLINE",
      "status":"O",
      "imageUrl":"https://microless.com/cdn/products/44ed9032a7405b0253001e4633b35663-hi.jpg"
    },    {
      "dev_name":"DEVICE 8",
      "id":"FDDFDG WERWRWE",
      "user_name":"RALHID",
      "date":"19 OCTOBER 12:44 AM",
      "counter":"JUMPNFUN",
      "status":"O",
      "imageUrl": "https://images.shopkees.com/uploads/cdn/images/1000/8444070525_1645005145.jpg"
    },

    {
      "dev_name":"DEVICE 9",
      "id":"JDGDFF YUYJRETE",
      "user_name":"RASHID",
      "date":"18 JULY 12:44 AM",
      "counter":"WATER PLAY",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },



  ].obs;
  var lstr_ticketCounterDeviceList=[
    {
      "dev_name":"DEVICE 1",
      "id":"ASPOIGG POJKFFJF",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },


  {
      "dev_name":"DEVICE 8",
      "id":"FDDFDG WERWRWE",
      "user_name":"RALHID",
      "date":"19 OCTOBER 12:44 AM",
      "counter":"JUMPNFUN",
      "status":"O",
      "imageUrl": "https://images.shopkees.com/uploads/cdn/images/1000/8444070525_1645005145.jpg"
    },

    {
      "dev_name":"DEVICE 9",
      "id":"JDGDFF YUYJRETE",
      "user_name":"RASHID",
      "date":"18 JULY 12:44 AM",
      "counter":"WATER PLAY",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },



  ].obs;
  var lstr_adminDeviceList=[
    {
      "dev_name":"DEVICE 1",
      "id":"ASPOIGG POJKFFJF",
      "user_name":"AHMED",
      "date":"12 JULY 12:44 AM",
      "counter":"KIDS TRAIN",
      "status":"A",
      "imageUrl":"https://blog.sunmi.com/wp-content/uploads/2018/06/Sunmi-P1-9-768x497.png"
    },





  ].obs;
}