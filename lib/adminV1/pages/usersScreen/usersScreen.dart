import 'package:beams_tapp/adminV1/controllers/usersController/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/masterMenus.dart';
import '../../../common_widgets/tabButton.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserController userController = Get.put(UserController());
  @override
  void initState() {

    userController.pageController = PageController();
    userController.selectedPage.value = 0;
    userController.lstrSelectedPage.value = "D";
    // TODO: implement initState
    super.initState();
  }
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
                tSubHead("Users",AppColors.appTicketDarkBlue, TextAlign.start),



              ],
            ),

          ),
        ),

        Expanded(
          child: Row(
            children: [
              Flexible(
                  child: Column(
                    children: [

                      Expanded(
                          child:Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                    decoration: boxBaseDecoration(Colors.white, 6),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        tBody("Search", AppColors.appAdminColor2, TextAlign.start),
                                        gapHC(2),
                                        SizedBox(
                                          height: 40,
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              suffixIcon:
                                              Icon(Icons.search, color: Colors.black, size: 20),
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: AppColors.appAdminBgLightBlue),
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              fillColor: AppColors.appAdminBgLightBlue,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: AppColors.appAdminBgLightBlue),
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 7,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 6, right: 10, top: 6),
                                    child:   Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 8),
                                          decoration: boxBaseDecoration(Colors.white, 6),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: boxBaseDecoration(
                                                    AppColors.appAdminBgLightBlue, 6),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4, vertical: 6),
                                                child: masterMenu(() {
                                                  userController.wstrPageMode.value =
                                                  "VIEW";
                                                }, userController.wstrPageMode.value),
                                              ),
                                              gapHC(10),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        tBody(
                                                            "Code",
                                                            AppColors.appAdminColor2,
                                                            TextAlign.start),
                                                        wCommonTextFieldAdminV1(
                                                          userController.txtUserCode.value,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  gapWC(10),
                                                  Flexible(
                                                    flex: 7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        tBody(
                                                            "Name",
                                                            AppColors.appAdminColor2,
                                                            TextAlign.start),
                                                        wCommonTextFieldAdminV1(
                                                          userController.txtUserName.value,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  gapWC(10),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        gapHC(10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 2),
                                          decoration: boxDecoration(Colors.white, 30),
                                          child: Obx(() => Row(
                                            children: [
                                              Flexible(
                                                child: TabButton(
                                                  radius: 30.0,
                                                  tabColor: AppColors.appAdminColor1,
                                                  width: 0.3,
                                                  text: "Details",
                                                  pageNumber: 0,
                                                  selectedPage: userController
                                                      .selectedPage.value,
                                                  onPressed: () {
                                                    userController
                                                        .lstrSelectedPage.value = "D";
                                                    changePage(0);
                                                  },
                                                ),
                                              ),
                                              gapWC(3),
                                              Flexible(
                                                child: TabButton(
                                                  radius: 30.0,
                                                  width: 0.3,
                                                  text: "Site",
                                                  tabColor: AppColors.appAdminColor1,
                                                  pageNumber: 1,
                                                  selectedPage: userController
                                                      .selectedPage.value,
                                                  onPressed: () {
                                                    userController
                                                        .lstrSelectedPage.value = "S";
                                                    changePage(1);
                                                  },
                                                ),
                                              ),
                                              gapWC(3),
                                              Flexible(
                                                child: TabButton(
                                                  radius: 30.0,
                                                  width: 0.3,
                                                  text: "Other Permission",
                                                  tabColor: AppColors.appAdminColor1,
                                                  pageNumber: 2,
                                                  selectedPage: userController
                                                      .selectedPage.value,
                                                  onPressed: () {
                                                    userController
                                                        .lstrSelectedPage.value = "O";
                                                    changePage(2);
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                        Expanded(
                                            child: Obx(
                                                  () => Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: PageView(
                                                  onPageChanged: (int page) {
                                                    userController.selectedPage.value = page;
                                                  },
                                                  controller: userController.pageController,
                                                  children: [
                                                    wDetail(),
                                                    wSite(),
                                                    wOtherPermission(),
                                                  ],
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ))
                            ],
                          )
                      )     ],
                  )
              )
            ],
          ),
        ),
      ],
    );



  }
  changePage(int pageNum) {
    userController.selectedPage.value = pageNum;

    userController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      userController.lstrSelectedPage.value = "D";
    }

    if (pageNum == 1) {
      userController.lstrSelectedPage.value = "S";
    }
    if (pageNum == 2) {
      userController.lstrSelectedPage.value = "O";
    }
  }
  wDetail() {
    Size size =MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 8),
      decoration: boxBaseDecoration(Colors.white, 6),


      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              tBody(
                  "Passcode",
                  AppColors.appAdminColor2,
                  TextAlign.start),
              wCommonTextFieldAdminV1(
                userController.txtDpassCode.value,size.width/6
              )
            ],
          ),
          gapHC(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tBody(
                  "Role",
                  AppColors.appAdminColor2,
                  TextAlign.start),
              SizedBox(
                height: 35,
                width: size.width/6,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    suffixIcon:
                    Icon(Icons.search, color: Colors.black, size: 20),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColors.appAdminBgLightBlue),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fillColor: AppColors.appAdminBgLightBlue,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColors.appAdminBgLightBlue),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          gapHC(10),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              tBody(
                  "Mobile",
                  AppColors.appAdminColor2,
                  TextAlign.start),
              wCommonTextFieldAdminV1(
                userController.txtDMobile.value,size.width/3.6
              )
            ],
          ),      gapHC(10),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              tBody(
                  "Email",
                  AppColors.appAdminColor2,
                  TextAlign.start),
              wCommonTextFieldAdminV1(
                userController.txtDEmail.value,size.width/3.6
              )
            ],
          ),      gapHC(10),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              tBody(
                  "Address",
                  AppColors.appAdminColor2,
                  TextAlign.start),
              wCommonTextFieldAdminV1(
                userController.txtDAddress.value,size.width/3.6,5
              )
            ],
          ),      gapHC(10),

        ],
      ),
    );

  }

  wSite() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 8),
      decoration: boxBaseDecoration(Colors.white, 6),
      child: Center(
        child: tBody("Site", Colors.black, TextAlign.start),
      ),
    );
  }

  wOtherPermission() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 8),
      decoration: boxBaseDecoration(Colors.white, 6),
      child: Center(
        child: tBody("Other PERMISSION", Colors.black, TextAlign.start),
      ),
    );

  }
}
