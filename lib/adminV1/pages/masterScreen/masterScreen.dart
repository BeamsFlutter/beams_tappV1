import 'package:beams_tapp/adminV1/pages/masterScreen/masterPaymntMode.dart';
import 'package:beams_tapp/adminV1/pages/masterScreen/masterPlayAreaScreen.dart';
import 'package:beams_tapp/adminV1/pages/masterScreen/masterRoleScreen.dart';
import 'package:beams_tapp/adminV1/pages/masterScreen/mstrCardScreen.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../common_widgets/masterMenus.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';
import '../../controllers/adminHomeController.dart';
import '../../controllers/masterController/masterPlayAreaController.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {

  final AdminV1HomeController adminV1HomeController = Get.put(AdminV1HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
          child: Container(

            decoration: boxBaseDecoration(Colors.white, 6),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            child: Row(
              children: [
                tSubHead("Master",AppColors.appTicketDarkBlue, TextAlign.start),
                gapWC(20),
              Row(
                 children: wRowMenuButton(),
              )


              ],
            ),

          ),
        ),

         Expanded(
          child: Row(
            children: [
              Flexible(
                  child: Obx(() => Column(
                    children: [

                      Expanded(
                        child:
                        (adminV1HomeController.selectedSubMenu.value=="p")? MasterPlayAreaScreen():
                        ( adminV1HomeController.selectedSubMenu.value=="pm")?MasterPaymentMode():
                        ( adminV1HomeController.selectedSubMenu.value=="c")?MasterCard():
                        ( adminV1HomeController.selectedSubMenu.value=="r")?MasterRoleScreen():

                        gapHC(0),
                      )
                    ],
                  ))
              )
            ],
          ),
        ),
      ],
    );



  }


  List<Widget> wRowMenuButton(){
    List<Widget> rtnList = [];
    var submenu =  adminV1HomeController.subMenuList;
    for(var e in submenu){
      var code = e["code"];

      rtnList.add(
        Obx(() => GestureDetector(
          onTap: (){
            dprint(e["code"]);
            adminV1HomeController.selectedSubMenu.value = code!;
          },
          child: Container(
              decoration: boxBaseDecoration(adminV1HomeController.selectedSubMenu.value==code?   AppColors.appAdminColor1:Colors.transparent, 30),
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: tcn(e["desc"], adminV1HomeController.selectedSubMenu.value==code? Colors.white: Colors.black, 12, TextAlign.start)),
        )),
        //menuRowButton(menuTitle, Icons.home),
      );

    }
    return rtnList;
  }



  user(){
    return Center(
      child: tc("USER", Colors.black, 12),
    );
  }

  role(){
    return Center(
      child: tc("role", Colors.black, 12),
    );
  }
  card(){
    return Center(
      child: tc("cards", Colors.black, 12),
    );
  }







}
