import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class CommonButton extends StatelessWidget {

  final Color buttoncolor;
  final String buttonText;
  final bool icon_need;
  final double buttonTextSize;
  final VoidCallback onpressed;
  final IconData? icon;
  const CommonButton({Key? key,required this.buttoncolor,required this.buttonText,this.buttonTextSize=15 ,this.icon,required this.onpressed,required this.icon_need}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
        duration: Duration(milliseconds: 110),
        onPressed: onpressed,
        child: Container(
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(6),

    ),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: icon_need==true?Icon(icon,color: AppColors.white,size: 17):SizedBox(),
                ),
                buttonText =="Pay" && icon_need==true ?SizedBox():gapWC(5),
                tcs(buttonText, buttoncolor, buttonTextSize)
              ],
            ),
          ),
    )
    );
  }
}
