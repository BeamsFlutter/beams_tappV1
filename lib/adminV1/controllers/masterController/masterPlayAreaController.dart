import 'dart:io';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../adminHomeController.dart';

class MasterPlayAreaController extends GetxController{

  final AdminV1HomeController adminV1HomeController = Get.put(AdminV1HomeController());
  Rx<TextEditingController> txtCounterName =TextEditingController().obs;
  Rx<TextEditingController> txtCounterPrice =TextEditingController().obs;
  Rx<TextEditingController> txtCountercode =TextEditingController().obs;
  Rx<TextEditingController> txtduration =TextEditingController().obs;
  Rx<TextEditingController> txtMaxGuest =TextEditingController().obs;
  var lstrCounterName=''.obs;
  var lstrCounterPrice=''.obs;
  var wstrPageMode='VIEW'.obs;
   var phoneMode =false.obs;
  var selectedMenu='Master'.obs;
  var selectTheme = "a".obs;

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
       this.image = imageTemp;
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }






}