
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterRoleController extends GetxController{

  var wstrPageMode='VIEW'.obs;
  Rx<TextEditingController> txtCode =TextEditingController().obs;
  Rx<TextEditingController> txtdiscrption =TextEditingController().obs;
}