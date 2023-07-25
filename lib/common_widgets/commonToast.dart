

import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast{


  static showToast(String message,ToastType type,ToastPositionType toastPostion){

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastPostion == ToastPositionType.center ?ToastGravity.CENTER :ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: type == ToastType.error ? AppColors.subcolor : AppColors.primarycolor,
        textColor: AppColors.white,
        fontSize: 16.0,
    );
  }
}