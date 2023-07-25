
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/commonbutton.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/string_constant.dart';
import '../../../../constants/styles.dart';
import '../../../../view/login/views/login_screen.dart';
import '../../device/view/adminDevice_screen.dart';
import '../../history/view/adminHistory_screen.dart';
import '../../login/view/adminlogin_screen.dart';
import '../../registartion/view/adminRegister_screen.dart';
import '../../report/view/adminReport_screen.dart';
import '../../settings/view/adminSetting_screen.dart';
import '../../users/view/adminUser_screen.dart';
import '../controller/admin_home_controller.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final AdminHomeController adminHomeController = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                decoration: boxDecoration(Colors.white, 0),
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 100, width: 100,
                              child: Image.asset(
                                AppAssets.tappLogo, fit: BoxFit.fill,)),
                          gapHC(10),
                          tc('BEAMS TAPP', Colors.black, 20),
                          tcn('MANAGEMENT APPLICATION', AppColors.lightfontcolor, 12,TextAlign.center),
                          gapHC(5),
                          const Divider(thickness: 1,),
                          gapHC(15),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Obx(() =>  Column(
                                children: [
                                  wListMenu("Users","user",Icons.account_circle_outlined),
                                  wListMenu("Registration","regstr",Icons.app_registration_outlined),
                                  wListMenu("Report","report",Icons.pie_chart),
                                  wListMenu("History","history",Icons.access_time_outlined),
                                  wListMenu("Settings","settings",Icons.settings),
                                  wListMenu("Devices","device",Icons.devices),


                                ],
                              ))
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: CommonButton(
                                buttoncolor: AppColors.primarycolor,
                                buttonTextSize: 12,
                                icon_need: true,
                                buttonText: "Sign out",
                                icon: Icons.power_settings_new,
                                onpressed: () {
                                  Get.offAll(() =>  AdminLoginScreen());


                                }),
                          ),


                        ],
                      ),
                    )

                ),
              ),
               gapWC(8),
              Expanded(child: Obx(() => wSelectedPage()))



            ],
          )
      ),
    );
  }

  ///////////////WIDGET............................

  Widget wListMenu(head,mode,icon){
    return ListTile(
      hoverColor: Colors.red,
      tileColor: adminHomeController.pageMode.value == mode ? AppColors.primarycolor:Colors.black ,
      // selectedTileColor:adminHomeController.pageMode.value == mode ? Colors.red:Colors.green ,
      leading:  Icon(
        icon,
        color:  adminHomeController.pageMode.value == mode ? AppColors.primarycolor:Colors.black ,
      ),
      title:  tc(head, adminHomeController.pageMode.value == mode ? AppColors.primarycolor:Colors.black, 12),
      onTap: () {
        adminHomeController.changePage(mode);
      },
    );
  }


  wSelectedPage() {
    dprint("ppaagee ${adminHomeController.pageMode.value}");
    switch (adminHomeController.pageMode.value) {
      case 'user':
        return  const AdminUserScreen();
      case 'regstr':
        return  const AdminRegisterScreen();
      case 'report':
        return const AdminReportScreen();
      case 'history':
        return const AdminHistoryScreen();
      case 'settings':
        return const AdminSettingScreen();
      case 'device':
        return const AdminDeviceScreen();
    }
  }
}