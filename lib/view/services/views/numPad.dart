import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/material.dart';
var dotarray=[];
class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;


  const NumPad({
    Key? key,
    this.buttonSize = 50,
    this.buttonColor = AppColors.primarycolor,
    this.iconColor = Colors.white,
    required this.delete,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
           gapHC( 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: 1,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 2,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 3,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          gapHC( 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 4,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 5,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 6,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          gapHC( 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 7,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 8,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 9,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          gapHC( 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this button is used to delete the last number
              NumberButton(
                number: ".",
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),

              NumberButton(
                number: 0,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // this button is used to submit the entered value
              // IconButton(
              //   onPressed: () => onSubmit(),
              //   icon: Icon(
              //     Icons.done_rounded,
              //     color: iconColor,
              //   ),
              //   iconSize: buttonSize,
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50 / 2),
                  color: AppColors.primarycolor

                ),
                child: IconButton(
                  onPressed: () => delete(),
                  icon: const Icon(
                    Icons.backspace_outlined,
                    color: Colors.white,

                  ),
                  iconSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class NumberButton extends StatelessWidget {
  final dynamic number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {

          if(number.toString()=="." && dotarray.isEmpty){
            dotarray.add(number.toString());
            controller.text += number.toString();

          }else if(number.toString()!="."){
            controller.text += number.toString();
          }
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}