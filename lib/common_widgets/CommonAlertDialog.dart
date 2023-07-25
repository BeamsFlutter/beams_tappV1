import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/enums/intialmode.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAlertDialog extends StatelessWidget {
  final Function onpressed;
  final Alertmode alertmode;
  const CommonAlertDialog({Key? key,required this.onpressed,required this.alertmode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: tcnw("Are you sure?", AppColors.fontcolor, 18,TextAlign.start,FontWeight.w500),
      content: tcnw((Alertmode.exit==alertmode)? "Do you want to exit?":(Alertmode.proceed==alertmode) ?"Do you want to proceed?":"Do you want to delete?",AppColors.fontcolor,12,TextAlign.start,FontWeight.w500),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: tc("No",AppColors.primarycolor,13),
        ),
        TextButton(
          onPressed: (){
            onpressed();
            Get.back();
    },
          child: tc("Yes",AppColors.primarycolor,13),
        ),
      ],
    );
  }
}








