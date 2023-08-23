import 'package:beams_tapp/adminV1/pages/deviceScreen/deviceScreen.dart';
import 'package:beams_tapp/adminV1/pages/homeScreen/homeScreen.dart';
import 'package:beams_tapp/adminV1/pages/masterScreen/mstrCardScreen.dart';
import 'package:beams_tapp/adminV1/pages/packageScreen/packageScreen.dart';
import 'package:beams_tapp/adminV1/pages/reportScreen/reportScreen.dart';
import 'package:beams_tapp/adminV1/pages/siteScreen/siteScreen.dart';
import 'package:beams_tapp/adminV1/pages/usersScreen/usersScreen.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../../view/counter/views/counter_screen.dart';
import '../controllers/adminHomeController.dart';
import 'counterScreen/adminV1counterScreen.dart';
import 'masterScreen/masterScreen.dart';

class AdminV1HomeScreen extends StatefulWidget {
  const AdminV1HomeScreen({super.key});

  @override
  State<AdminV1HomeScreen> createState() => _AdminV1HomeScreenState();
}

class _AdminV1HomeScreenState extends State<AdminV1HomeScreen> {
  final AdminV1HomeController adminV1HomeController = Get.put(AdminV1HomeController());

  @override
  Widget build(BuildContext context) {

    return  Scaffold(resizeToAvoidBottomInset: false,
      body: Container(
        padding: MediaQuery.of(context).padding,
        decoration:  boxBaseDecoration(AppColors.appAdminBgLightBlue, 0.0),
        child: Column(
          children: [
            Container(decoration: boxDecoration(Colors.white, 0.0),

              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      tHead1("Beams", AppColors.appTicketDarkBlue),
                      tcS("   Fungate ", AppColors.appTicketDarkBlue, 30),

                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Row(
                          children: [
                             Icon(Icons.wifi, color: AppColors.appTicketDarkBlue, size: 20),
                            gapWC(5),
                            tcn("192.168.0.100", AppColors.appTicketDarkBlue, 12, TextAlign.center)
                          ],
                        ),
                        gapWC(20),
                        Row(
                          children: [
                             Icon(Icons.phone_android_outlined,
                                color: AppColors.appTicketDarkBlue, size: 20),
                            gapWC(5),
                            tcn("9787826367", AppColors.appTicketDarkBlue, 12, TextAlign.center)
                          ],
                        ),
                        gapWC(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Icon(Icons.account_balance,
                                color: AppColors.appTicketDarkBlue, size: 20),
                            gapWC(5),
                            tcn("SPLASH AND PARTY LLC.", AppColors.appTicketDarkBlue, 12,
                                TextAlign.start)
                          ],
                        ),
                        gapWC(20),
                        Bounce(child: Icon(Icons.logout,color: AppColors.appTicketDarkBlue,size: 20),
                            duration: Duration(milliseconds: 110),
                            onPressed: (){})
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child:

             Row(
              children: [
              Obx(() =>   Container(
                width: adminV1HomeController.menuExpandMode.value? 200:80,


                decoration: boxGradientTCBC(AppColors.appAdminColor1, AppColors.appAdminColor2, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only( right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapHC(10),
                              Obx(() =>    Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                    onTap: (){
                                      dprint("menutapped");


                                      adminV1HomeController.menuExpandMode.value =! adminV1HomeController.menuExpandMode.value;
                                      dprint(adminV1HomeController.menuExpandMode.value);

                                    },

                                    child: Icon(adminV1HomeController.menuExpandMode.value?Icons.menu:Icons.arrow_forward_outlined,color: Colors.white,size: 30,)),
                              ),),
                              gapHC(40),
                              Column(
                                children: wRowMenuWidget(),
                              )


                            ],
                          ),
                        )
                    ),
                    Container(
                      width: adminV1HomeController.menuExpandMode.value? 200:80,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: AppColors.appTicketDarkBlue.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Column(
                          children: [
                            customButton("Settings", Icons.settings_outlined),
                            gapHC(10),
                            customButton("Logout", Icons.logout),
                          ],
                        ),
                      ),


                    )

                  ],
                ),
              ),),
                Expanded(

                    child:
                    Obx(() =>   Column(

                      children: [


                        Expanded(child:   adminV1HomeController.selectedMenu.value=="Master" ?MasterScreen():
                        (adminV1HomeController.selectedMenu.value=="Site")?SiteScreen():
                        (adminV1HomeController.selectedMenu.value=="Devices")?AdminV1DeviceScreen():      (adminV1HomeController.selectedMenu.value=="Packages")?PackageScreen():
                          (adminV1HomeController.selectedMenu.value=="Reports")?Adminv1ReportScreen():
                            (adminV1HomeController.selectedMenu.value=="Home")?HomeScreenAdminV1():
                            (adminV1HomeController.selectedMenu.value=="Users")?UsersScreen()
        :gapHC(0)



                        )

                        // Expanded(
                        //   child: Row(
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 10),
                        //         child: Container(
                        //           width: 310,
                        //           padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                        //           decoration: boxBaseDecoration(Colors.white, 6),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               tBody("Search", AppColors.appAdminColor1, TextAlign.start),
                        //               gapHC(2),
                        //               TextField(
                        //                 cursorColor:Colors.black,
                        //                 decoration: InputDecoration(
                        //                   suffixIcon: Icon(Icons.search,color: Colors.black,size: 20),
                        //
                        //                   filled: true,
                        //                   enabledBorder:OutlineInputBorder(
                        //                     borderSide:  BorderSide(color:  AppColors.appAdminBgLightBlue),
                        //                     borderRadius: BorderRadius.circular(30.0),
                        //                   ),
                        //                   fillColor: AppColors.appAdminBgLightBlue,
                        //
                        //                   focusedBorder:OutlineInputBorder(
                        //                     borderSide:  BorderSide(color:  AppColors.appAdminBgLightBlue),
                        //                     borderRadius: BorderRadius.circular(30.0),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(child: Padding(
                        //         padding: const EdgeInsets.only(left: 0,right: 10),
                        //         child: Container(
                        //           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        //           decoration: boxBaseDecoration(Colors.white, 6),
                        //           child: Column(
                        //             children: [
                        //               Container(
                        //                 height: 35,
                        //                 decoration: boxBaseDecoration(AppColors.appAdminBgLightBlue, 6),
                        //                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ))
                        //     ],
                        //   ),
                        // )
                      ],
                    ))

                )
              ],
            )

            )








          ],
        ),
      ),
    );
  }



  List<Widget>wRowMenuWidget(){
    List<Widget> rtnList = [];
    for(var e in adminV1HomeController.menuList.value){
      var menuTitle = e["desc"];
      var menuCode = e["code"];
      var subMenu = e["subMenu"];
      var icon = e["icon"];
      rtnList.add(
          wRowMenu(menuTitle: menuTitle,menuCode: menuCode,subMenu: subMenu,icon: icon),
          //menuRowButton(menuTitle, Icons.home),
      );

    }
    return rtnList;

  }

  Widget home(){
    return Center(
      child: Text("Home"),
    ) ;
  }
  Widget user(){
    return Center(
      child: Text("User"),
    ) ;
  }
  Widget counter(){
    return Center(
      child: Text("Counter"),
    ) ;
  }

  Widget customButton(title,icon){
    return Obx(() => Bounce(
      onPressed: (){

      },
      duration: Duration(milliseconds: 110),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: boxBaseDecoration(AppColors.appAdminColor1.withOpacity(0.2), 50),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: Colors.white,size: 20),
            adminV1HomeController.menuExpandMode.value?  gapWC(10):gapWC(0),
            adminV1HomeController.menuExpandMode.value? tcn(title, AppColors.white, 12, TextAlign.start):gapHC(0)
          ],
        ),
      ),
    ));
  }


}





class wRowMenu extends StatefulWidget {
  final dynamic  menuTitle;
  final dynamic  menuCode;
  final dynamic  icon;
  final dynamic  subMenu;
   wRowMenu({Key? key, required this.menuTitle, this.menuCode, this.subMenu, this.icon}) : super(key: key);

  @override
  State<wRowMenu> createState() => _wRowMenuState();
}

class _wRowMenuState extends State<wRowMenu> {
  final AdminV1HomeController adminV1HomeController = Get.put(AdminV1HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: (){
        dprint(widget.menuTitle);
        adminV1HomeController.selectedMenu.value=widget.menuTitle;


      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              color: adminV1HomeController.selectedMenu.value==widget.menuTitle?AppColors.appAdminBgLightBlue:Colors.transparent,
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(30)
              )
          ),
          padding: EdgeInsets.symmetric( horizontal: 20,vertical: 10),
          child: Row(

            children: [
              Icon(widget.icon,size: 20,color:adminV1HomeController.selectedMenu.value==widget.menuTitle? AppColors.appAdminColor1:Colors.white),
              gapWC(5),
            adminV1HomeController.menuExpandMode.value?  tcn(widget.menuTitle,adminV1HomeController.selectedMenu.value==widget.menuTitle? AppColors.appAdminColor1:Colors.white,12,TextAlign.start):gapHC(0)
            ],
          ),
        ),
      ),
    ));
  }
}



