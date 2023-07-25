
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/material.dart';

class TitleWithUnderLine extends StatelessWidget {
  final String title;
  const TitleWithUnderLine({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tcnw(title, AppColors.fontcolor, 18,TextAlign.center,FontWeight.w600),
        gapHC(4),
        underLine(),
      ],
    );
  }
  Widget underLine(){
    return Container(
      height: 4,
      width: 35,
      decoration: BoxDecoration(
        color: AppColors.primarycolor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
