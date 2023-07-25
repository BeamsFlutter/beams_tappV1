import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/admin/views/app_setting_screen.dart';
import 'package:beams_tapp/view/admin/views/assign_counter/views/assign_counter_screen.dart';
import 'package:beams_tapp/view/admin/views/counter_item/views/counter_item_screen.dart';
import 'package:beams_tapp/view/admin/views/counters/admin_counter_screen.dart';
import 'package:beams_tapp/view/admin/views/user_create/view/user_create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget { 
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw("Admin",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithUnderLine(title: "Admin",),
                gapHC(20),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      servieceItemButton("Application Settings",Icons.app_settings_alt_outlined,(){
                        dprint("BlockTap");
                         Get.to(()=>const AppsettingScreen());
                      }),
                      gapHC(24),
                      servieceItemButton("Counters",Icons.add_home_work_outlined,(){
                        dprint("AdminCounters");
                        Get.to(()=>const AdminCounters());
                      }),
                      gapHC(24),
                      servieceItemButton("Counter Item",Icons.account_balance_wallet_outlined,(){
                        dprint("Item");
                        Get.to(()=>const CounterItemScreen());
                      }),
                      gapHC(24),
                      servieceItemButton("Assign Counter",Icons.assistant_photo_outlined,(){
                        dprint("Assign");
                       Get.to(()=>const AssignCounterScreen());
                      }),
                      gapHC(24),
                      servieceItemButton("User Create",Icons.supervised_user_circle_outlined,(){
                       Get.to(()=> const UserCreateScreen());
                      }),


                    ],
                  ),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget servieceItemButton(String servicename,IconData serviceIcon,Function onPress){
    return   Bounce(
      duration: const Duration(milliseconds: 110),
      onPressed: (){
        onPress();
      },
      child: Material(
        elevation: 9,
        shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
        borderRadius:BorderRadius.circular(5.0) ,

        // shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
        child: Container(

            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(serviceIcon,color: AppColors.fontcolor,size: 20,),
                    gapWC(5),
                    tcnw(servicename, AppColors.fontcolor, 17, TextAlign.center, FontWeight.w500),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded,color: AppColors.fontcolor,size: 15,)
              ],
            )
        ),
      ),
    );
  }


}
