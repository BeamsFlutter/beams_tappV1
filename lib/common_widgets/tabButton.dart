


import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/material.dart';

import '../constants/color_code.dart';
import '../constants/styles.dart';

class TabButton extends StatelessWidget {


  final String? text;
  final String? count;
  final int? selectedPage;
  final dynamic tabColor;
  final int? pageNumber;
  final Function  onPressed;
  final IconData  ? icon;
  final double width;
  final double ? radius;
  final bool ? isWhite;
  final double ? iconSize;
  TabButton({
    this.count,
    this.text,
    this.selectedPage,
    this.pageNumber,
    this.icon,
    required this.tabColor,
    this.radius,
    this.iconSize,
    required this.width,
    required this.onPressed, this.isWhite});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Color fBgColor = (isWhite??false) ?Colors.white:Colors.black;
    // Color fSBgColor = (isWhite??false) ?AppColors.appTicketDarkBlue:Colors.white;
    // Color fStxtColor = (isWhite??false) ?Colors.white:Colors.black;
    // Color fNtxtColor = (isWhite??false) ?Colors.red:Colors.white;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 2),

      child: GestureDetector(
        onTap: (){
          onPressed();
        },
        child: AnimatedContainer(
          decoration: boxBaseDecoration( selectedPage == pageNumber ? tabColor:Colors.white, 30),

          duration: const Duration(
              milliseconds: 1000
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          // decoration: BoxDecoration(
          //   color: selectedPage == pageNumber ? fSBgColor: fBgColor,
          //   borderRadius: BorderRadius.circular(radius??15.0),
          // ),
          // padding: EdgeInsets.symmetric(
          //   vertical: selectedPage == pageNumber ? 12.0 : 12.0,
          //   horizontal: selectedPage == pageNumber ? 20.0 : 0,
          // ),
          // margin: EdgeInsets.symmetric(
          //   vertical: selectedPage == pageNumber ? 0 : 0.0,
          //   horizontal: selectedPage == pageNumber ? 0 : 20.0,
          // ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Center(
              child: Text(
                text ?? "",
                style: TextStyle(
                    color: selectedPage == pageNumber ? Colors.white.withOpacity(0.7):AppColors.appTicketDarkBlue,
                    fontSize: 12,
                    fontWeight: selectedPage==pageNumber?FontWeight.bold:FontWeight.normal
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
      ),
    );
  }
}