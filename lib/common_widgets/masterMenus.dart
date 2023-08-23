//===========================================================MASTER MENU
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../constants/color_code.dart';
import '../constants/styles.dart';
import '../main.dart';

Widget masterMenu(fnCallBack,mode){
  return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            gapWC(10),
            menuCard(Icons.add,fnCallBack,"ADD",mode == "VIEW"?true:false),
            gapWC(10),
            menuCard(Icons.save,fnCallBack,"SAVE",mode != "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.edit,fnCallBack,"EDIT",mode == "VIEW"?true:false ),         gapWC(10),
            menuCard(Icons.first_page,fnCallBack,"FIRST",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.navigate_before_sharp,fnCallBack,"BACK",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.navigate_next_sharp,fnCallBack,"NEXT",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.last_page_outlined,fnCallBack,"LAST",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.attach_file,fnCallBack,"ATTACH",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.delete_sweep_outlined,fnCallBack,"DELETE",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.access_time_sharp,fnCallBack,"LOG",mode == "VIEW"?true:false),         gapWC(10),
            menuCard(Icons.help,fnCallBack,"HELP",true),         gapWC(10),
            menuCard(Icons.cancel,fnCallBack,"CLOSE",mode != "VIEW"?true:false),         gapWC(10),


          ],
        ),
      ));
}
Widget menuCard(icon,fnCallBack,mode,pagemode){
  return Bounce(
    duration: Duration(milliseconds: 110),
    onPressed: (){
      if(pagemode){
        fnCallBack(mode);
      }

    },
    child:  Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),

      decoration: boxBaseDecoration(pagemode? AppColors.appTicketLIGHTRED.withOpacity(0.6):AppColors.appTicketLIGHTRED.withOpacity(0.9), 5),
      child: Center(
        child: Icon(icon,size: 15,color:   Colors.white,),
      ),
    ),);
}


