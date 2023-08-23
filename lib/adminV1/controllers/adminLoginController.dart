import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminV1LoginController extends GetxController{

  TextEditingController txtusername = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  RxBool isVisible = false.obs;
}