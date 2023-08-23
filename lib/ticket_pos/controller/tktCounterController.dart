import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TicketCounterController extends GetxController{

  var lstr_counterList=[
    {
      "counterName": "KIDS TRAIN",
      "activeGuestCount": 34,
      "price": 23.4,
      "bgColor": Colors.yellow,
      "siteName": "DEIRA CITY CENTER",
      "counterCode": "D001",
      "imageUrl": "https://clipart-library.com/images/8ixK8bzBT.png",
      "sitecode": "DDA12",
      "status":"O"
    },
    {
      "counterName": "JUMPNFUN",
      "activeGuestCount": 23,
      "price": 65.4,
      "bgColor": Colors.yellow,
      "siteName": "JUMAIRA",
      "counterCode": "D001",
      "imageUrl": "https://www.tripsavvy.com/thmb/NnFJMbhxPWcmHBngbbOPCdyyWgA=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/SeaWorldSanDiego_OceanExplorer-58ecf7445f9b58f11917f063.jpg",
      "sitecode": "DDA12",
      "status":"A"
    },
    {
      "counterName": "WATER PLAY",
      "activeGuestCount": 55,
      "price": 54.5,
      "bgColor": Colors.amber,
      "siteName": "JUMAIRA",
      "counterCode": "D006",
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMRDxYrHVPtdiZBG9HgEnlkDGi4sEENGyDFtn-cRoFsT4a8iEN&s",
      "sitecode": "DDA18",
      "status":"O"
    },
    {
      "counterName": "KIDS TRAIN",
      "activeGuestCount": 5,
      "price": 32.4,
      "bgColor": Colors.blue,
      "siteName": "DEIRA CITY CENTER",
      "counterCode": "D004",
      "imageUrl": "https://freesvg.org/img/ferris-color.png",
      "sitecode": "DDA10",
      "status":"A"
    },
    {
      "counterName": "ZIPLINE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.greenAccent,
      "siteName": "AJMAN",
      "counterCode": "D002",
      "imageUrl": "https://freesvg.org/img/theme%20park.png",
      "sitecode": "DDA11",
      "status":"O"
    },
    {
      "counterName": "ZIPLINE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.brown,
      "siteName": "AJMAN",
      "counterCode": "D002",
      "imageUrl": "https://clipart-library.com/images/8ixK8bzBT.png",
      "sitecode": "DDA11",
      "status":"A"
    },
    {
      "counterName": "ZIPLINE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.indigo,
      "siteName": "AJMAN",
      "counterCode": "D002",
      "imageUrl": "https://clipart-library.com/images/8ixK8bzBT.png",
      "sitecode": "DDA11",
      "status":"A"
    },
    {
      "counterName": "WATER PLAY",
      "activeGuestCount": 55,
      "price": 54.5,
      "bgColor": Colors.amber,
      "siteName": "JUMAIRA",
      "counterCode": "D006",
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMRDxYrHVPtdiZBG9HgEnlkDGi4sEENGyDFtn-cRoFsT4a8iEN&s",
      "sitecode": "DDA18",
      "status":"O"
    },
    {
      "counterName": "SLIDE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.orangeAccent,
      "siteName": "JUMAIRA",
      "counterCode": "D002",
      "imageUrl": "https://freesvg.org/img/AlanSpeak-Slide.png",
      "sitecode": "DDA11",
      "status":"A"
    },    {
      "counterName": "ZIPLINE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.green,
      "siteName": "AJMAN",
      "counterCode": "D002",
      "imageUrl": "https://clipart-library.com/images/8ixK8bzBT.png",
      "sitecode": "DDA11",
      "status":"O"
    },
    {
      "counterName": "ZIPLINE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.red,
      "siteName": "AJMAN",
      "counterCode": "D002",
      "imageUrl": "https://freesvg.org/img/playground-3044380.png",
      "sitecode": "DDA11",
      "status":"O"
    },
    {
      "counterName": "ZIPLINE",
      "activeGuestCount": 12,
      "price": 56.4,
      "bgColor": Colors.red,
      "siteName": "AJMAN",
      "counterCode": "D002",
      "imageUrl": "https://freesvg.org/img/playground-3044380.png",
      "sitecode": "DDA11",
      "status":"O"
    },

    {
      "counterName": "WATER PLAY",
      "activeGuestCount": 55,
      "price": 54.5,
      "bgColor": Colors.amber,
      "siteName": "JUMAIRA",
      "counterCode": "D006",
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMRDxYrHVPtdiZBG9HgEnlkDGi4sEENGyDFtn-cRoFsT4a8iEN&s",
      "sitecode": "DDA18",
      "status":"A"
    },
  ].obs;
  var lstr_logDetails=[
    {
      "name":"RAJ",
      "id":"ed:tr:dfg:rr:ee",
      "date":"12 JULY 2023 12:44",
      "price":"-25.00"
    },
    {
      "name":"DFFS",
      "id":"er:tr:er:rr:er",
      "date":"12 JULY 2023 12:44",
      "price":"-23.00"
    },
    {
      "name":"LLAJ",
      "id":"fgh:fd:er:rr:df",
      "date":"12 JULY 2023 12:44",
      "price":"-34.00"
    },
    {
      "name":"JAJ",
      "id":"ezxcd:zx:dgxz:rr:zx",
      "date":"12 JULY 2023 12:44",
      "price":"-14.00"
    },
    {
      "name":"TAJ",
      "id":"vbn:hy:nb:rr:nvb",
      "date":"12 JULY 2023 12:44",
      "price":"-44.00"
    },
  ].obs;

}