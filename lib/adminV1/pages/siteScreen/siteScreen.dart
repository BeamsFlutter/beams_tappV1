import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:beams_tapp/adminV1/controllers/siteController/siteController.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/masterMenus.dart';
import '../../../common_widgets/tabButton.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';

class SiteScreen extends StatefulWidget {
  const SiteScreen({super.key});

  @override
  State<SiteScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  final SiteController siteController =
  Get.put(SiteController());
  bool showBack = false;
  late FocusNode _focusNode;
  @override
  void initState() {

    siteController.pageController = PageController();
    siteController.selectedPage.value = 0;
    siteController.lstrSelectedPage.value = "D";
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Container(

            decoration: boxBaseDecoration(Colors.white, 6),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            child: Row(
              children: [
                tSubHead("Site Creation",AppColors.appTicketDarkBlue, TextAlign.start),



              ],
            ),

          ),
        ),

        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
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
                    padding: const EdgeInsets.only(bottom: 6,right:10,top: 6),
                    child: Column(
                      children: [

                        Container(

                          decoration: boxBaseDecoration(
                              AppColors.white, 6),
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          child: Column(
                            children: [
                              Container(


                                  decoration: boxBaseDecoration(
                                      AppColors.appAdminBgLightBlue, 6),
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),

                                child: masterMenu((){
                                  siteController.wstrPageMode.value="VIEW";

                                }, siteController.wstrPageMode.value),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            tBody("Code", AppColors.appAdminColor2,
                                                TextAlign.start),

                                            wCommonTextFieldAdminV1(siteController
                                                .txtCode.value,
                                              200.0,)

                                          ],
                                        ),
                                        gapWC(20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            tBody("Name", AppColors.appAdminColor2,
                                                TextAlign.start),

                                            wCommonTextFieldAdminV1(siteController
                                                .txtName.value,
                                              MediaQuery.of(context).size.width/3,)

                                          ],
                                        ),
                                      ],
                                    ),
                                    gapHC(10),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              tBody("Branch", AppColors.appAdminColor2,
                                                  TextAlign.start),

                                              wCommonTextFieldAdminV1(siteController
                                                  .txtBranch.value,
                                              )

                                            ],
                                          ),
                                        ),
                                        gapWC(20),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              tBody("Division", AppColors.appAdminColor2,
                                                  TextAlign.start),

                                              wCommonTextFieldAdminV1(siteController
                                                  .txtDevision.value,
                                                )

                                            ],
                                          ),
                                        ),
                                        gapWC(20),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              tBody("Center", AppColors.appAdminColor2,
                                                  TextAlign.start),

                                              wCommonTextFieldAdminV1(siteController
                                                  .txtCenter.value,
                                              )

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                                  selectedPage: siteController
                                      .selectedPage.value,
                                  onPressed: () {
                                    siteController.lstrSelectedPage.value = "D";
                                    changePage(0);
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
                                  pageNumber: 1,
                                  selectedPage: siteController
                                      .selectedPage.value,
                                  onPressed: () {
                                    siteController
                                        .lstrSelectedPage.value = "PA";
                                    changePage(1);
                                  },
                                ),
                              ),
                              gapWC(3),
                              Flexible(
                                child: TabButton(
                                  radius: 30.0,
                                  width: 0.3,
                                  text: "Available Cards",
                                  tabColor: AppColors.appAdminColor1,
                                  pageNumber: 2,
                                  selectedPage: siteController
                                      .selectedPage.value,
                                  onPressed: () {
                                    siteController
                                        .lstrSelectedPage.value = "AC";
                                    changePage(2);
                                  },
                                ),
                              ),
                              gapWC(3),
                              Flexible(
                                child: TabButton(
                                  radius: 30.0,
                                  width: 0.3,
                                  text: "Terms & Condition",
                                  tabColor: AppColors.appAdminColor1,
                                  pageNumber: 3,
                                  selectedPage: siteController
                                      .selectedPage.value,
                                  onPressed: () {
                                    siteController
                                        .lstrSelectedPage.value = "TC";
                                    changePage(3);
                                  },
                                ),
                              ),
                            ],
                          )),
                        ),
                        Expanded(
                          child: PageView(
                            onPageChanged: (int page) {
                              siteController
                                  .selectedPage.value = page;
                            },
                            controller:
                            siteController.pageController,
                            children: [
                              wDetails(),
                              wPlayArea(),
                              wAvailbleCards(),
                              wTermsConditn(),
                            ],
                          ),

                        )


                      ],
                    ),
                  ))

      ],
    )
    )
            ]  );

}


  changePage(int pageNum) {
    siteController.selectedPage.value = pageNum;

    siteController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      siteController.lstrSelectedPage.value = "D";
    }

    if (pageNum == 1) {
      siteController.lstrSelectedPage.value = "PA";
    }
    if (pageNum == 2) {
      siteController.lstrSelectedPage.value = "AC";
    }
    if (pageNum == 3) {
      siteController.lstrSelectedPage.value = "TC";
    }
  }

  wAvailbleCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Container(

    decoration: boxBaseDecoration(
    AppColors.white, 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children:wCardList()
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),

                  child: ClipRRect(

                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Container(
                      width: 280,
                      height: 150,
                      child: Center(
                        child: Bounce(
                          onPressed: (){},
                          duration: Duration(milliseconds: 110),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration:BoxDecoration(
                              color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade100,
                                    blurRadius: 3.0, // soften the shadow
                                    spreadRadius: 3.0, //extend the shadow
                                    offset: Offset(
                                      0.0, // Move to right 5  horizontally
                                      1.4, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],


                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Icon(Icons.add,size: 30,color: AppColors.appAdminColor2),
                          ),
                        ),
                      ),




                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  wTermsConditn() {
  return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(

    decoration: boxBaseDecoration(
    AppColors.white, 6),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Terms 1", AppColors.appAdminColor2,
                    TextAlign.start),

                wCommonTextFieldAdminV1(siteController
                    .txtTerm1.value,
                  MediaQuery.of(context).size.width/3,)

              ],
            ),
            gapHC(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Terms 2", AppColors.appAdminColor2,
                    TextAlign.start),

                wCommonTextFieldAdminV1(siteController
                    .txtTerm2.value,
                  MediaQuery.of(context).size.width/3,)

              ],
            ),
            gapHC(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Terms 3", AppColors.appAdminColor2,
                    TextAlign.start),

                wCommonTextFieldAdminV1(siteController
                    .txtTerm3.value,
                  MediaQuery.of(context).size.width/3,)

              ],
            ),

          ],
        ),
      ),
    );
  }

  wPlayArea() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: boxBaseDecoration(
            AppColors.white, 6),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          children: [
            Container(
              decoration: boxBaseDecoration(AppColors.appAdminBgLightBlue, 20),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: Row(
                        children: [
                          tBody('Play Area', AppColors.appAdminColor2,TextAlign.center)
                        ],
                      )),
                  Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .end,
                        children: [
                          tBody('Price', AppColors.appAdminColor2,TextAlign.center)
                        ],
                      )),
                  Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .end,
                        children: [
                          tBody('Duration',AppColors.appAdminColor2,TextAlign.center)
                        ],
                      )),
                  Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .end,
                        children: [
                          tBody('Max.Guest', AppColors.appAdminColor2,TextAlign.center)
                        ],
                      )),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  wDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: boxBaseDecoration(
            AppColors.white, 6),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Address1", AppColors.appAdminColor2,
                    TextAlign.start),

                wCommonTextFieldAdminV1(siteController
                    .txtAddress1.value,
                  MediaQuery.of(context).size.width/3,6)

              ],
            ),
            gapHC(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tBody("Address2", AppColors.appAdminColor2,
                    TextAlign.start),

                wCommonTextFieldAdminV1(siteController
                    .txtAddress2.value,
                  MediaQuery.of(context).size.width/3,6)

              ],
            ),
            gapHC(15),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tBody("PO Box", AppColors.appAdminColor2,
                          TextAlign.start),

                      wCommonTextFieldAdminV1(siteController
                          .txtPoBox.value,MediaQuery.of(context).size.width/4.5
                       )

                    ],
                  ),
                ),
                gapWC(30),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tBody("Email", AppColors.appAdminColor2,
                          TextAlign.start),

                      wCommonTextFieldAdminV1(siteController
                          .txtEmail.value,MediaQuery.of(context).size.width/4.5
                     )

                    ],
                  ),
                ),
              ],
            ),
            gapHC(15),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tBody("Mobile", AppColors.appAdminColor2,
                          TextAlign.start),

                      wCommonTextFieldAdminV1(siteController
                          .txtMobile.value,MediaQuery.of(context).size.width/4.5
                      )

                    ],
                  ),
                ),
                gapWC(30),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tBody("Tel", AppColors.appAdminColor2,
                          TextAlign.start),

                      wCommonTextFieldAdminV1(siteController
                          .txtTel.value,MediaQuery.of(context).size.width/4.5
                      )

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


wCards( color1, color2, cardName,cardlist){
    dprint(siteController.cardlIST.last);
 return Padding(
   padding: EdgeInsets.only(right: 15,bottom: 15),
   child: Container(
     width: 300,
     height: 150,

     decoration: boxGradientCLCR(color1, color1, 25.0),
     child: Stack(

       children: [
         Positioned(
             top: 1,
             right: 1,
             child: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius:45 ,)),
         Positioned(
             top: 13,
             right: 90,
             child: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius:20 ,)),
         Positioned(
             top: 28,
             right: 68,
             child: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius:30 ,)),

         Positioned(
             right: 10,
             bottom: 10,
             child: tc("XXX XXX XXXXX", Colors.white,14)),
         Padding(
           padding: const EdgeInsets.only(left: 15),
           child: Align(
             alignment: Alignment.centerLeft,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 tc(cardName, Colors.white,18),
                 Container(
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(16),
                           bottomLeft: Radius.circular(16),

                         )
                     ),
                     padding: EdgeInsets.only(left: 8,top: 10,bottom: 10,right: 5),

                     child: Icon(Icons.delete_forever,color: AppColors.appAdminColor2,))

               ],
             ),
           ),
         ),

       ],
     ),


   ),
 );
}


  List<Widget> wCardList(){
    List<Widget> rtnList = [];
    var cardList =  siteController.cardlIST;
    for(var e in cardList){
      var color1 = e["color1"];
      var color2 = e["color2"];
      var name = e["name"];

      rtnList.add(
          wCards(color1, color2, name,cardList)

      );

    }
    return rtnList;
  }



}

