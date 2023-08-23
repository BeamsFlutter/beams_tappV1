import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminV1HomeController extends GetxController{
  var selectedMenu='Master'.obs;
  var selectedSubMenu='c'.obs;
  var menuExpandMode=true.obs;
  var wstrPageMode='VIEW'.obs;
  var menuList =[
    {
      "code":"home",
      "desc":"Home",
      "icon":Icons.home
    },
    {
      "code":"master",
      "desc":"Master",
      "icon":Icons.add_business_rounded,
    },
    {
      "code":"site",
      "icon":Icons.plagiarism_outlined,
      "desc":"Site"
    },
    {
      "code":"packages",
      "desc":"Packages",
      "icon":Icons.receipt,
    },
    {
      "code":"devices",
      "desc":"Devices",
      "icon":Icons.phone_android,
    },
    {
      "code":"users",
      "desc":"Users",
      "icon":Icons.supervised_user_circle,
    },
    {
      "code":"reports",
      "desc":"Reports",
      "icon":Icons.report_outlined,
    },



  ].obs;
  var subMenuList=[
    {
      "code":"p",
      "desc":"Play Areas",
    },

    {
      "code":"c",
      "desc":"Cards",
    },
    {
      "code":"pm",
      "desc":"Payment Mode",
    },
    {
      "code":"r",
      "desc":"Role",
    },



  ].obs;






  }



