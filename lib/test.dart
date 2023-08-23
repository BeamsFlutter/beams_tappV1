import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class Stt extends StatefulWidget {
  const Stt({super.key});

  @override
  State<Stt> createState() => _SttState();
}

class _SttState extends State<Stt> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 180,
              decoration: boxGradientCLCR(Colors.greenAccent, Colors.green, 25),
              child: Stack(

                children: [
                  Positioned(
                      top: 1,
                      right: 1,
                      child: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius:45 ,)),
                  Positioned(
                      top: 13,
                      right: 90,
                      child: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius:20 ,)),
                  Positioned(
                      top: 28,
                      right: 68,
                      child: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius:30 ,)),

                     Positioned(
                         right: 10,
                         bottom: 10,
                         child: tc("XXX XXX XXXXX", Colors.white,16)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tc("SPLASH", Colors.white,26),
                           Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(16),
                                 bottomLeft: Radius.circular(16),
                                 
                               )
                             ),
                               padding: EdgeInsets.only(left: 8,top: 10,bottom: 10,right: 5),
                               
                               child: Icon(Icons.delete_forever,color: AppColors.appAdminColor2,))
                        ],
                      ),
                    ),
                  ),

                ],
              ),


            ),
            gapHC(40),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),

              child: ClipRRect(

                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: 350,
                  height: 180,




                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
