
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/common_textfield.dart';
import '../../../../common_widgets/commonbutton.dart';
import '../../../../common_widgets/title_withUnderline.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/txt_field_type.dart';
import '../../../../constants/styles.dart';
import '../controller/adminSettings_controller.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {

  final AdminSettingsController adminSettingsController = Get.put(AdminSettingsController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      adminSettingsController.fnInitialAppsettingData();
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

      // appBar: AppBar(
      //   elevation: 0,
      //   title: tsw("App Settings",AppColors.white,20,FontWeight.w500),
      //   leading: IconButton(
      //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      //       onPressed: () {
      //         Get.back();
      //         // registerController.fnBack(context);
      //       }
      //   ),
      //
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,

          decoration: boxDecoration(Colors.white, 10),
          margin: const EdgeInsets.all(10),
          padding:const  EdgeInsets.all(10),

          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
              child: Form(
                key:adminSettingsController.settingformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWithUnderLine(title: "App Settings",),
                    gapHC(20),
                    tsw("Card Expire Days ",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller: adminSettingsController.cardExpDays_controller,textFormFieldType: TextFormFieldType.card_exp_days, opacityamount: 0.17,shadow: 30.0, hintText: 'Card Exp Days',),
                    gapHC(20),
                    tsw("Register Amount",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller:  adminSettingsController.regAmount_controller,textFormFieldType: TextFormFieldType.register_amount, opacityamount: 0.17,shadow: 30.0, hintText: 'Reg Amount',),
                    gapHC(20),
                    tsw("Renew Charge",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller:  adminSettingsController.renewCharge_controller,textFormFieldType: TextFormFieldType.renew_charge, opacityamount: 0.17,shadow: 30.0, hintText: 'Renew Charge',),
                    gapHC(20),
                    tsw("Duplicate Charge",AppColors.fontcolor,14,FontWeight.w500),
                    gapHC(4),
                    CommonTextfield(controller:  adminSettingsController.duplicateCharge_controller,textFormFieldType: TextFormFieldType.duplicate_charge, opacityamount: 0.17,shadow: 30.0, hintText: 'Duplicate Charge',),
                    gapHC(20),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 100,
                        child: CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Update", onpressed: (){

                          adminSettingsController.fnUpdateAppSettings();

                          //   registerController.fnRegisteration(registerController.gender_select.value,dob.value);
                          //   Get.to( CardIssueScreen(cardIssueFrom: CardIssueFro m.register));
                        }, ),
                      ),
                    ),
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
