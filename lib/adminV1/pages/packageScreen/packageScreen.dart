import 'package:beams_tapp/adminV1/controllers/counterController/counterController.dart';
import 'package:beams_tapp/adminV1/controllers/deviceController/deviceController.dart';
import 'package:beams_tapp/adminV1/controllers/packageController/packageController.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/masterMenus.dart';
import '../../../common_widgets/tabButton.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<PackageScreen> {
  final PackageController packageController = Get.put(PackageController());

  @override
  void initState() {
    packageController.pageController = PageController();
    packageController.selectedPage.value = 0;
    packageController.lstrSelectedPage.value = "D";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Container(
          decoration: boxBaseDecoration(Colors.white, 6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            children: [
              tSubHead(
                  "Packages", AppColors.appTicketDarkBlue, TextAlign.start),
            ],
          ),
        ),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  decoration: boxBaseDecoration(Colors.white, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tBody(
                          "Search", AppColors.appAdminColor2, TextAlign.start),
                      gapHC(2),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search,
                                color: Colors.black, size: 20),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.appAdminBgLightBlue),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: AppColors.appAdminBgLightBlue,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.appAdminBgLightBlue),
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
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Obx(() => Column(
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
                                    packageController.wstrPageMode.value =
                                        "VIEW";
                                  }, packageController.wstrPageMode.value),
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
                                            packageController.txtCode.value,
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
                                            packageController.txtName.value,
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
                                        selectedPage: packageController
                                            .selectedPage.value,
                                        onPressed: () {
                                          packageController
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
                                        selectedPage: packageController
                                            .selectedPage.value,
                                        onPressed: () {
                                          packageController
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
                                        text: "Play Area",
                                        tabColor: AppColors.appAdminColor1,
                                        pageNumber: 2,
                                        selectedPage: packageController
                                            .selectedPage.value,
                                        onPressed: () {
                                          packageController
                                              .lstrSelectedPage.value = "P";
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
                                  packageController.selectedPage.value = page;
                                },
                                controller: packageController.pageController,
                                children: [
                                  wDetail(),
                                  wSite(),
                                  wPlayArea(),
                                ],
                              ),
                            ),
                          ))
                        ],
                      )),
                ))
          ],
        ),
      ))
    ]);
  }

  changePage(int pageNum) {
    packageController.selectedPage.value = pageNum;

    packageController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      packageController.lstrSelectedPage.value = "D";
    }

    if (pageNum == 1) {
      packageController.lstrSelectedPage.value = "S";
    }
    if (pageNum == 2) {
      packageController.lstrSelectedPage.value = "P";
    }
  }

  wPlayArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: boxBaseDecoration(Colors.white, 6),
      child: Column(
        children: [
          Container(
            decoration: boxBaseDecoration(AppColors.appAdminBgLightBlue, 20),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Flexible(
                    flex: 3,
                    child: tBody('Play Area', AppColors.appAdminColor2,
                        TextAlign.center)),
                Flexible(
                    flex: 2,
                    child: tBody(
                        'Price', AppColors.appAdminColor2, TextAlign.center)),
                Flexible(
                    flex: 2,
                    child: tBody('Duration', AppColors.appAdminColor2,
                        TextAlign.center)),
                Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        tBody('Max.Guest', AppColors.appAdminColor2,
                            TextAlign.center),
                      ],
                    )),
                Bounce(
                  duration: Duration(milliseconds: 110),
                  onPressed: () {
                    packageController.txtADDPrice.value.text="";
                    packageController.txtADDDuration.value.text="";
                    packageController.txtADDMaxGuest.value.text="";
                    packageController.txtADDCode.value.text="";
                    packageController.txtADDName.value.text="";
                    packageController.wAddPlayAreaBottomSheet(context,"ADD");
                  },
                  child: Container(
                    decoration: boxBaseDecoration(AppColors.appAdminColor1, 20),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        tBody(
                          'ADD',
                          AppColors.white,
                          TextAlign.center,
                        ),
                        gapWC(3),
                        Icon(
                          Icons.add_circle_outline_outlined,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<PackageController>(builder: (controller){
            return   Expanded(
                child: ListView.builder(
                    itemCount: controller.lstrPlayAreaList.value.length,
                    itemBuilder: (context, index) {
                      // "name":"playAre",
                      // "price":"34",
                      // "duration":"22:3",
                      // "Max.Guest":"33"
                      var datas = controller.lstrPlayAreaList[index];
                      var name = datas["name"];
                      var price = datas["price"];
                      var duration = datas["duration"];
                      var guest = datas["Max.Guest"];
                      var code = datas["code"];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(flex: 3,
                                child: tBody(name, AppColors.appAdminColor2,
                                    TextAlign.center)),
                            Flexible(
                                child: tBody(price, AppColors.appAdminColor2,
                                    TextAlign.center)),
                            Flexible(
                                child: tBody(duration, AppColors.appAdminColor2,
                                    TextAlign.center)),
                            Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    tBody(guest, AppColors.appAdminColor2,
                                        TextAlign.center),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Bounce(
                                    duration: Duration(milliseconds: 110),
                                    onPressed: () {
                                      dprint("edittttttttttttt");
                                      controller.fnEditPlayAreas(code,context);
                                    },
                                    child: Icon(Icons.edit,
                                        color: AppColors.appAdminColor2,
                                        size: 25)),
                                gapWC(10),
                                Bounce(
                                    duration: Duration(milliseconds: 110),
                                    onPressed: () {
                                      dprint("delete..........");
                                      controller.fnDeletePlayArea(code);
                                    },
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: AppColors.appAdminColor2,
                                      size: 25,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
          })

        ],
      ),
    );
  }

  wSite() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: boxBaseDecoration(Colors.white, 6),
      child:  Column(
        children: [
          Container(
              decoration: boxBaseDecoration(AppColors.appAdminBgLightBlue, 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          tBody('Code', AppColors.appAdminColor2,
                              TextAlign.center),
                        ],
                      )),
                  Flexible(
                      flex: 3,
                      child: tBody('Description', AppColors.appAdminColor2,
                          TextAlign.center)),
                  Flexible(
                      flex: 3,
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search,
                                color: Colors.black, size: 20),
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                bottom: 5, right: 5, left: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.appAdminBgLightBlue),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: Colors.grey.shade200,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.appAdminBgLightBlue),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 3,
                      child: Transform.scale(
                        scale: 1,
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.appAdminColor2,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(3))),
                          value: packageController.selectAll.value,
                          onChanged: (bool? value) {
                            dprint("valVVVVVVVVVVVVV  ${value}");
                            packageController.selectAll.value = value!;
                            for (var element in packageController.lstrSiteDetailList) {
                              element["check"] = value;

                              // if (element["check"] == false) {
                              //   element["check"] = true;
                              //
                              // } else {
                              //   element["check"] = true;
                              //
                              // }
                            }




                          },
                        ),
                      )),
                ],
              )),
          GetBuilder<PackageController>(builder: (controller){
            return Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.lstrSiteDetailList.length,
                  itemBuilder: (context, index) {
                    // "code":"SD2323",
                    // "desc":"Sdhsdf sdfqwqwe cvddddddddffd",
                    // "check":false,
                    var datas = controller.lstrSiteDetailList[index];

                    var code = (datas["code"] ?? "").toString();
                    var desc = (datas["desc"] ?? "").toString();
                    bool check = datas["check"] == true ? true : false;




                    return Container(
                      decoration: boxBaseDecoration(AppColors.white, 20),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  tBody(code, AppColors.appAdminColor2,
                                      TextAlign.center),
                                ],
                              )),
                          Flexible(
                              flex: 6,
                              child: Row(
                                children: [
                                  tBody(desc, AppColors.appAdminColor2,
                                      TextAlign.center),
                                ],
                              )),
                          Flexible(
                              flex: 3,
                              child: Transform.scale(
                                scale: 1,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: AppColors.appAdminColor2,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                                  value: check,
                                  onChanged: (bool? value) {

                                    // datas["check"] = (datas["check"]) == true ? false : true;
                                    //    datas["check"] == true ? true : false;
                                    packageController.fnChangeCheckBox(code,"S");
                                  },
                                ),
                              )

                          ),
                        ],
                      ),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }

  wDetail() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: boxBaseDecoration(Colors.white, 6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Price", AppColors.appAdminColor2, TextAlign.start),
                wCommonTextFieldAdminV1(packageController.txtPrice.value, 200.0)
              ],
            ),
            gapHC(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Detail Description", AppColors.appAdminColor2,
                    TextAlign.start),
                wCommonTextFieldAdminV1(
                    packageController.txtDescription.value, size.width / 3, 3)
              ],
            ),
            gapHC(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Terms1", AppColors.appAdminColor2, TextAlign.start),
                wCommonTextFieldAdminV1(
                    packageController.txtTerms1.value, size.width / 3, 3)
              ],
            ),
            gapHC(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Terms2", AppColors.appAdminColor2, TextAlign.start),
                wCommonTextFieldAdminV1(
                    packageController.txtTerms2.value, size.width / 3, 3)
              ],
            ),
            gapHC(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Terms3", AppColors.appAdminColor2, TextAlign.start),
                wCommonTextFieldAdminV1(
                    packageController.txtTerms3.value, size.width / 3, 3)
              ],
            ),
          ],
        ),
      ),
    );
  }


}
