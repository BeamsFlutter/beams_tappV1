


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_code.dart';

class SiteController extends GetxController{
  Rx<TextEditingController> txtName =TextEditingController().obs;
  Rx<TextEditingController> txtCode =TextEditingController().obs;
  Rx<TextEditingController> txtAddress1 =TextEditingController().obs;
  Rx<TextEditingController> txtAddress2 =TextEditingController().obs;
  Rx<TextEditingController> txtPoBox =TextEditingController().obs;
  Rx<TextEditingController> txtEmail =TextEditingController().obs;
  Rx<TextEditingController> txtMobile =TextEditingController().obs;
  Rx<TextEditingController> txtTel =TextEditingController().obs;
  Rx<TextEditingController> txtTerm1 =TextEditingController().obs;
  Rx<TextEditingController> txtTerm2 =TextEditingController().obs;
  Rx<TextEditingController> txtTerm3 =TextEditingController().obs;
  Rx<TextEditingController> txtBranch =TextEditingController().obs;
  Rx<TextEditingController> txtDevision=TextEditingController().obs;
  Rx<TextEditingController> txtCenter=TextEditingController().obs;

  var wstrPageMode='VIEW'.obs;

  late PageController pageController;

  var selectedPage = 0.obs;
  var lstrSelectedPage = "D".obs;
  var pageIndex = 0.obs;

  var cardlIST=[
    {
       "name":"SPLASH",
       "color1":Colors.green.withOpacity(0.5),
       "color2":Colors.black,
    },{

      "name":"DXB",
      "color1": AppColors.appTicketDarkBlue,
      "color2":AppColors.appTicketColor1,
    },
    {
      "name":"EMAR",
      "color2":Colors.black.withOpacity(0.5),
      "color1":Colors.black,
    },
    {
      "name":"GOLD",
      "color1":Colors.orangeAccent,
      "color2":Colors.orange,
    },
    {
      "name":"SPLASH",
      "color1":Colors.blue.withOpacity(0.5),
      "color2":Colors.red,
    },


  ].obs;

}




