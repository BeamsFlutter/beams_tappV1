import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  var wstrPageMode='VIEW'.obs;
  Rx<TextEditingController> txtUserCode =TextEditingController().obs;
  Rx<TextEditingController> txtUserName =TextEditingController().obs;
  Rx<TextEditingController> txtDpassCode =TextEditingController().obs;
  Rx<TextEditingController> txtDMobile =TextEditingController().obs;
  Rx<TextEditingController> txtDEmail =TextEditingController().obs;
  Rx<TextEditingController> txtDAddress =TextEditingController().obs;
  var lstrSelectRole = "".obs;
  late PageController pageController;
  var selectedPage = 0.obs;
  var lstrSelectedPage = "D".obs;
  var pageIndex = 0.obs;
}