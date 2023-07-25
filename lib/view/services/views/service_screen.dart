import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/recharge/views/payment_return.dart';
import 'package:beams_tapp/view/services/views/amount_screen.dart';
import 'package:beams_tapp/view/services/views/block_screen.dart';
import 'package:beams_tapp/view/services/views/duplicate_screen.dart';
import 'package:beams_tapp/view/services/views/renewe_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class ServieceScreen extends StatefulWidget {
  const ServieceScreen({Key? key}) : super(key: key);

  @override
  State<ServieceScreen> createState() => _ServieceScreenState();
}

class _ServieceScreenState extends State<ServieceScreen> {
  final CommonController commonController = Get.put(CommonController());
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

  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw(AppStrings.services,AppColors.white,20,FontWeight.w500),
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

                const TitleWithUnderLine(title: AppStrings.services,),
                gapHC(20),

                servieceItemButton("Block",Icons.block,(){
                  dprint("BlockTap");
                  Get.to(()=>const BlockScreen());
                }),
                gapHC(24),
                servieceItemButton("Duplicate",Icons.control_point_duplicate,(){
                  dprint("duplicate");
                  Get.to(()=>const DuplicateScreen());
                }),
                gapHC(24),
                servieceItemButton("Renewal",Icons.autorenew_outlined,(){
                  dprint("Renewal");
                  Get.to(()=>const RenewScreen());
                }),
                gapHC(24),
                servieceItemButton("Pay",Icons.attach_money_outlined,(){
                  Get.to(()=> const AmountScreen());
                }),
                gapHC(24),
                commonController.wstrRoleCode.value =="ADMIN"?  servieceItemButton("Refund",Icons.monetization_on_outlined,(){
                  Get.to(()=>  PaymentReturn(cardserailnumb: '',));
                }):SizedBox(),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
