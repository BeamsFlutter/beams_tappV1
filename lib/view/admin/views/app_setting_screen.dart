import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
  
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/admin/controller/appsetting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppsettingScreen extends StatefulWidget {
  const AppsettingScreen({Key? key}) : super(key: key);

  @override
  State<AppsettingScreen> createState() => _AppsettingScreenState();
}

class _AppsettingScreenState extends State<AppsettingScreen> {
  final AppSettingController appSettingController = Get.put(AppSettingController());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      appSettingController.fnInitialAppsettingData();
    });
    // TODO: implement initState
    super.initState();
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
        title: tsw("App Settings",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
              // registerController.fnBack(context);
            }
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          padding: const EdgeInsets.only(top: 5),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
              child: Form(
                 key:appSettingController.settingformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWithUnderLine(title: "App Settings",),
                    gapHC(20),
                    tsw("Card Expire Days ",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller: appSettingController.cardExpDays_controller,textFormFieldType: TextFormFieldType.card_exp_days, opacityamount: 0.17,shadow: 30.0, hintText: 'Card Exp Days',),
                    gapHC(20),
                    tsw("Register Amount",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller:  appSettingController.regAmount_controller,textFormFieldType: TextFormFieldType.register_amount, opacityamount: 0.17,shadow: 30.0, hintText: 'Reg Amount',),
                    gapHC(20),
                    tsw("Renew Charge",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller:  appSettingController.renewCharge_controller,textFormFieldType: TextFormFieldType.renew_charge, opacityamount: 0.17,shadow: 30.0, hintText: 'Renew Charge',),
                    gapHC(20),
                    tsw("Duplicate Charge",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller:  appSettingController.duplicateCharge_controller,textFormFieldType: TextFormFieldType.duplicate_charge, opacityamount: 0.17,shadow: 30.0, hintText: 'Duplicate Charge',),
                    gapHC(20),

                    CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Update", onpressed: (){
                      dprint("clooooseeeee");
                      appSettingController.fnUpdateAppSettings();

                      //   registerController.fnRegisteration(registerController.gender_select.value,dob.value);
                      //   Get.to( CardIssueScreen(cardIssueFrom: CardIssueFro m.register));
                    }, ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
