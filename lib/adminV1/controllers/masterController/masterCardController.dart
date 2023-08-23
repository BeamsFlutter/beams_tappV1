
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../constants/common_functn.dart';

class MasterCardController extends GetxController{

  var wstrPageMode='VIEW'.obs;
  Rx<TextEditingController> txtCode =TextEditingController().obs;
  Rx<TextEditingController> txtCardName =TextEditingController().obs;
  Rx<TextEditingController> txtDetailDisc =TextEditingController().obs;
  RxBool showBack = false.obs;
  late FocusNode focusNode;
  Rx<Color> pickerColor = Color(0xffffffff).obs;
  Rx<Color> currentColor = Color(0xff443a49).obs;
  RxString lstrFontColor="FFFFFF".obs;

// ValueChanged<Color> callback
  void changeColor(Color color) {
     pickerColor.value = color;
  }
  wPickerDialog(){
    // create some values
    return Get.dialog(
      AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor.value,
            onColorChanged: changeColor,
          ),

        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
               currentColor.value = pickerColor.value ;
               String colorString;
               colorString = currentColor.value.toString();
               dprint("currentColor.... ${colorString}  type ${colorString.runtimeType}");
         //      dprint(colorString.lastChars(5));
         //       print(colorString.substring(colorString.length-7));
         //       List<String> c = colorString.split(")");
         //       dprint("ccc ${c}");      List<String> c = colorString.split(")");
         //       dprint("ccc ${c}");
               lstrFontColor.value = colorString.substring(colorString.length-7);
               dprint(lstrFontColor.value.toString().substring(0,lstrFontColor.value.length-1));
               dprint(lstrFontColor.value.toString().runtimeType);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}