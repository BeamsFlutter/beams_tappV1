
import 'dart:developer';

import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/taphere_button.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/updationScreen.dart';
import 'package:beams_tapp/view/admin/views/admin_screen.dart';
import 'package:beams_tapp/view/card_issue/views/cardissue_screen.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/counter/views/counter_screen.dart';
import 'package:beams_tapp/view/history/views/history_screen.dart';
import 'package:beams_tapp/view/home/controller/home_controller.dart';

import 'package:beams_tapp/view/login/views/login_screen.dart';
import 'package:beams_tapp/view/recharge/views/recharge_screen.dart';
import 'package:beams_tapp/view/register/views/register_screen.dart';
import 'package:beams_tapp/view/reports/view/report_screen.dart';
import 'package:beams_tapp/view/services/views/amount_screen.dart';
import 'package:beams_tapp/view/services/views/service_screen.dart';
import 'package:beams_tapp/view/settings/view/setting_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../constants/styles.dart';
import '../../nfcExample/nfcSample.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class HomeScreen extends StatefulWidget {
  final NotificationDataModel notificationDataModel;
  const HomeScreen({Key? key, required this.notificationDataModel}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeController homeController = Get.put(HomeController());
  final CommonController commonController = Get.put(CommonController());



  @override
  void initState() {
    // homeController.fnGetPhoneDetails();
    homeController.fnNotificationPopup(widget.notificationDataModel);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
   // NfcManager.instance.stopSession().catchError((_) { /* no op */ });
    homeController.isTaped.value =true;
    dprint("HomeDispOSE ${homeController.isTaped.value}");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: homeController.scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize:  const Size.fromHeight(155),
        child: AppBar(
          leadingWidth: 22,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
          title:  th(AppStrings.appName,AppColors.white,20),
          actions: [
            IconButton(onPressed: (){
              dprint("logout");
              Get.offAll(() =>  LoginScreen());
            }, icon: const Icon(Icons.power_settings_new,color: AppColors.white,size: 25,))
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gapHC(55),
                th("Welcome,",AppColors.white,22),
                Row(
                  children: [
                    const Icon(Icons.account_circle_outlined,size: 15,color: AppColors.white),
                    gapWC(3),
                    th(commonController.wstrUserName.value,AppColors.white,13),
                  ],
                ),
                gapHC(2),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded,size: 15,color: AppColors.white),
                    gapWC(3),
                    tcnw(setDate(6, DateTime.now()),AppColors.white,10,TextAlign.center,FontWeight.w400),
                  ],
                ),
                gapHC(3),
                Row(
                  children: [
                    const Icon(Icons.account_balance_outlined,size: 15,color: AppColors.white),
                    gapWC(3),
                    tcnw(commonController.wstrUserCode.value,AppColors.white,10,TextAlign.center,FontWeight.w500),
                  ],
                ),
              ],
            ),
          ) ,
        ),
      ),

      drawer: SizedBox(
       width: MediaQuery.of(context).size.width * 0.65,
        child: wDrawer(),
      ) ,

      body: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.only(bottom: 24),
          //   decoration: const BoxDecoration(
          //       color: AppColors.primarycolor,
          //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30) )
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Row(
          //
          //             children: [
          //               IconButton(onPressed: (){},
          //                   icon: const Icon(Icons.menu,color: AppColors.white,size: 30)) ,
          //               th(AppStrings.appName,AppColors.white,20)
          //             ],
          //           ),
          //           const Spacer(),
          //           IconButton(onPressed: (){}, icon: const Icon(Icons.help,color: AppColors.white,size: 30,))
          //         ],
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 12),
          //         child: th("Welcome,",AppColors.white,35),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 12,bottom: 5),
          //         child: th("Pharal Willioms",AppColors.white,13),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 12),
          //         child: Row(
          //           children: [
          //             const Icon(Icons.access_time_filled,size: 12,color: AppColors.white),
          //             gapWC(4),
          //             tcnw("11:00 AM - 5:00 AM",AppColors.white,10,TextAlign.center,FontWeight.w400),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 12),
          //         child: tcnw("Beams",AppColors.white,10,TextAlign.center,FontWeight.w500),
          //       ),
          //
          //     ],
          //   ),
          // ),

          Expanded(child: Center(
            child: Obx(() => GestureDetector(
                onTap: (){
                  homeController.isTaped.value ? homeController.fnTaped(context): (homeController.isAvailable.value ?  null :  homeController.fnTaped(context));
                },
                child: homeController.isTaped.value ? wTaphere() : (homeController.isAvailable.value ? wHoldcard(): wNotAvilble()

                )
            ),),)
          ),


          // TapHereButton(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: CommonButton(buttoncolor: AppColors.primarycolor, buttonText: "Recharge",buttonTextSize: 12,icon_need:true,icon: Icons.receipt_long_sharp,onpressed: (){
                  Get.to( RechargeScreen(cardserailnumb: "",));
                  print("recharge");
                })),
                gapWC(8),

                Flexible(child: CommonButton(buttoncolor: AppColors.primarycolor, buttonText: "Register",buttonTextSize: 12,icon_need:true,icon: Icons.app_registration,onpressed: (){
                  print("Register");
                  Get.to(() => const RegisterScreen());

                })),
                gapWC(8),
                Flexible(child: CommonButton(buttoncolor: AppColors.primarycolor, buttonText: "Card issue",buttonTextSize: 12,icon_need:true,icon: Icons.credit_card_rounded,onpressed: (){
                  print("Card issue");
                   Get.to(const CardIssueScreen(cardIssueFrom: CardIssueFrom.home,slCode: "",));
                })),

              ],
            ),
          ),
          gapHC(8),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Flexible(child: CommonButton(buttoncolor: AppColors.primarycolor,buttonTextSize: 12,icon_need:true, buttonText: "Counter",icon: Icons.countertops_outlined,onpressed: (){
                  print("Counter");
                  Get.to(()=>const CounterScreen());
                })
                ),
                gapWC(8),

                Flexible(child: CommonButton(buttoncolor: AppColors.primarycolor,buttonTextSize: 12,icon_need:true, buttonText: "Pay",icon: Icons.attach_money_outlined,onpressed: (){
                  print("PAY");
                  Get.to(()=>const AmountScreen());
                })

                ),

                gapWC(8),
                commonController.wstrRoleCode.value =="ADMIN"?
                  Flexible(child: CommonButton(buttoncolor: AppColors.primarycolor, buttonText: "Services",buttonTextSize: 12,icon_need:true,icon: Icons.electrical_services_sharp,onpressed: (){
                  print("Services");
                  Get.to(const ServieceScreen());
                })):gapHC(0),

              ],
            ),
          ),
          gapHC(20),
          RichText(
            overflow: TextOverflow.ellipsis,
            text:   TextSpan(
                text: "Beams",
                style: const TextStyle(color: AppColors.lightfontcolor,fontSize: 13 ,fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  // TextSpan(
                  //     text: "Enter Manually",
                  //     style:  const TextStyle(color: AppColors.primarycolor,fontSize: 13,fontWeight: FontWeight.w600 ),
                  //     recognizer: TapGestureRecognizer()..onTap = () {
                  //       print('Tap Here on Enter Manually');
                  //       Get.to(()=> LookupSearch(
                  //         callbackfn: (data) {
                  //           // if(data!=null){
                  //           //   dprint("name:>>>  ${data["SLDESCP"]}");
                  //           //   dprint("email:>>>  ${data["EMAIL"]}");
                  //           //   dprint("dob:>>>  ${data["DOB"]}");
                  //           //   dprint("MOBILE:>>>  ${data["MOBILE"]}");
                  //           //   DateTime dob = DateTime.parse(data["DOB"].toString());
                  //           //
                  //           //   Get.back();
                  //           // }
                  //
                  //
                  //         },
                  //         table_name: "SLMAST",
                  //         column_names: const [
                  //           // {"COLUMN": "SLCODE", 'DISPLAY': "CODE: "},
                  //           // {"COLUMN": "SLDESCP", 'DISPLAY': "NAME: "},
                  //           // {"COLUMN": "MOBILE", 'DISPLAY': "MOBILE_NUMBER: "},
                  //           // {"COLUMN": "DOB", 'DISPLAY': "DOB: "},
                  //           // {"COLUMN": "EMAIL", 'DISPLAY': "EMAIL: "},
                  //           // {"COLUMN": "CITY", 'DISPLAY': "CITY: "},
                  //         ],
                  //         filter: [],
                  //       ));
                  //
                  //     }
                  // )
                ]),
          ),
          gapHC(20),



        ],
      ),

    );
  }

  Widget wTaphere(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.tap_here, 70.2),
        gapHC(1),
        tsw("Tap here..",AppColors.lightfontcolor, 15,FontWeight.w500)

      ],
    );
  }
  Widget wHoldcard(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // homeController.isAvailable ? Text("avaail"):Text("fff"),
        imageSet(AppAssets.hold_card, 70.2),
        gapHC(1),
        tsw("Hold Near Reader",AppColors.lightfontcolor, 15,FontWeight.w500)

      ],
    );
  }
  Widget wNotAvilble(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        imageSet(AppAssets.not_availble, 50.2),
        gapHC(7),
        tsw("NFC may not be supported or \n may be temporarily turned off",AppColors.lightfontcolor, 15,FontWeight.w500),
        gapHC(7),
        tsw("Retry",AppColors.lightfontcolor, 15,FontWeight.w500)

      ],
    );
  }


  wDrawer(){
    var firstStringofusername = commonController.wstrUserName.value.toString();
    dprint( "ROLLCODEEEEEEEEEEEEEE  ${commonController.wstrRoleCode.value}");

    return   Drawer(
      child: Column(
        // Important: Remove any padding from the ListView.
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: tc(commonController.wstrUserName.value.toString(),AppColors.white,12),
            accountEmail: tc(commonController.wstrUserCode.value.toString(),AppColors.white,12),
            currentAccountPicture:  CircleAvatar(
              backgroundColor: Colors.white,
              child: tc(firstStringofusername[0].toUpperCase(),AppColors.primarycolor,40
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  commonController.wstrRoleCode.value =="ADMIN"? ListTile(
                    leading: const Icon(Icons.admin_panel_settings_outlined), title: const Text("Admin"),
                    onTap: () {
                      Get.to(const AdminScreen());
                      homeController.fnCloseDrawer();

                    },
                  ):const SizedBox(),
                  ListTile(
                    leading: const Icon(Icons.receipt_long_sharp), title: const Text("Recharge"),
                    onTap: () {
                      Get.to( RechargeScreen(cardserailnumb: ""));
                      homeController.fnCloseDrawer();

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history), title: const Text("History"),
                    onTap: () {
                      Get.to(const HistoryScreen());
                      homeController.fnCloseDrawer();

                    },
                  ),
                  commonController.wstrRoleCode.value =="ADMIN"? ListTile(
                    leading: const Icon(Icons.electrical_services_sharp), title: const Text("Service"),
                    onTap: () {
                      Get.to(const ServieceScreen());
                      homeController.fnCloseDrawer();

                    },
                  ):const SizedBox(),
               ListTile(
                    leading: const Icon(Icons.report_gmailerrorred_rounded), title: const Text("Report"),
                    onTap: () {
                      Get.to(const ReportScreen());
                      homeController.fnCloseDrawer();

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings), title: const Text("Settings"),
                    onTap: () {
                      Get.to(const SettingScreen());
                      homeController.fnCloseDrawer();

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded), title: const Text("AppInfo"),
                    onTap: () {
                      Get.to(const UpdationScreen());
                      homeController.fnCloseDrawer();

                    },
                  ),

                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 6),
            child: CommonButton(buttoncolor: AppColors.primarycolor,buttonTextSize: 12,icon_need:true, buttonText: "SignOut",icon: Icons.power_settings_new,onpressed: (){

              Get.offAll(() =>  LoginScreen());
              homeController.fnCloseDrawer();
            }),
          )

        ],
      ),
    );
  }
}








