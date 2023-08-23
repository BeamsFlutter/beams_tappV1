import 'package:beams_tapp/adminV1/controllers/counterController/counterController.dart';
import 'package:beams_tapp/adminV1/controllers/deviceController/deviceController.dart';
import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../common_widgets/commonbutton.dart';
import '../../../common_widgets/masterMenus.dart';
import '../../../common_widgets/tabButton.dart';
import '../../../constants/color_code.dart';
import '../../../constants/common_functn.dart';
import '../../../constants/styles.dart';

class AdminV1DeviceScreen extends StatefulWidget {
  const AdminV1DeviceScreen({super.key});

  @override
  State<AdminV1DeviceScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<AdminV1DeviceScreen> {
  final DeviceController deviceController =
  Get.put(DeviceController());

  @override
  void initState() {

    deviceController.pageController = PageController();
    deviceController.selectedPage.value = 0;
    deviceController.lstrSelectedPage.value = "R";

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
                  tSubHead("Devices",AppColors.appTicketDarkBlue, TextAlign.start),



                ],
              ),

            ),
          ),

          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  children: [
                    Flexible(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6,right:10),
                          child: Column(
                            children: [
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
                                        text: "Reader App",
                                        pageNumber: 0,
                                        selectedPage: deviceController
                                            .selectedPage.value,
                                        onPressed: () {
                                          deviceController.lstrSelectedPage.value = "R";
                                          changePage(0);
                                        },
                                      ),
                                    ),
                                    gapWC(3),
                                    Flexible(
                                      child: TabButton(
                                        radius: 30.0,
                                        width: 0.3,
                                        text: "Ticket Counter",
                                        tabColor: AppColors.appAdminColor1,
                                        pageNumber: 1,
                                        selectedPage: deviceController
                                            .selectedPage.value,
                                        onPressed: () {
                                          deviceController
                                              .lstrSelectedPage.value = "TC";
                                          changePage(1);
                                        },
                                      ),
                                    ),
                                    gapWC(3),
                                    Flexible(
                                      child: TabButton(
                                        radius: 30.0,
                                        width: 0.3,
                                        text: "Admin",
                                        tabColor: AppColors.appAdminColor1,
                                        pageNumber: 2,
                                        selectedPage: deviceController
                                            .selectedPage.value,
                                        onPressed: () {
                                          deviceController
                                              .lstrSelectedPage.value = "A";
                                          changePage(2);
                                        },
                                      ),
                                    ),
                                    gapWC(3),
                                    Flexible(child:  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      height: 30,
                                      child: TextField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(right: 5,left: 10,top: 5),
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
                                    ),)

                                  ],
                                )),
                              ),

                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),


                                  child: PageView(
                                    onPageChanged: (int page) {
                                      deviceController.selectedPage.value = page;
                                    },
                                    controller: deviceController.pageController,
                                    children: [

                                      wReaderApp(),
                                      wTicketCounter(),
                                      wAdmin(),
                                    ],
                                  ),
                                ),
                              )




                            ],
                          ),
                        )),


                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Container(
                          decoration: boxDecoration1(
                              Colors.blueAccent.withOpacity(0.2), 20),
                          padding: const EdgeInsets.all(12),
                          child: Obx(() => Column(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                                          decoration: boxBaseDecoration(Colors.grey.shade100, 10),
                                          child: Image.asset("assets/images/ticketPos/pos-terminal.png"
                                              ,width: 100,height: 100),
                                        ),
                                        Positioned(
                                            top: 6,right: 6,
                                            child: CircleAvatar(backgroundColor: Colors.greenAccent,radius: 12,))

                                      ],
                                    ),
                                    gapHC(5),
                                    tBodyBold("DEVICE 1", AppColors.appAdminColor2),
                                    tBody("DSDESF SDFSD", AppColors.appAdminColor2,TextAlign.start),
                                    Row(
                                      children: [
                                        Icon(Icons.tv_rounded,color: Colors.black,size: 18,),
                                        gapWC(4),
                                        tBody("SITE : D001 - DEIRA CITY CENTER", Colors.black,TextAlign.start),
                                      ],
                                    ),
                                    gapHC(20),
                                    tBody("Device Name", AppColors.appAdminColor2, TextAlign.start),
                                    wCommonTextFieldAdminV1(deviceController.txtDevicename.value),
                                    gapHC(5),
                                    tBody("Site", AppColors.appAdminColor2, TextAlign.start),
                                    wCommonTextFieldAdminV1(deviceController.txtSite.value)

                                  ],
                                ),
                              ),
                              AdminV1CommonButton(buttoncolor: AppColors.appAdminColor1,
                                  buttonText: "UPDATE",
                                  onpressed: (){
                                dprint("UPDATE");
                                  },
                                  icon_need: false,
                                radius: 50,
                                  buttonTextColor: Colors.white,
                                  border: Border.all(color: AppColors.appAdminColor1,),
                              )

                            ],
                          ),)

                        ),
                      ),
                    ),

                  ],
                ),
              )
          )
        ]  );

  }



  changePage(int pageNum) {
    deviceController.selectedPage.value = pageNum;

    deviceController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      deviceController.lstrSelectedPage.value = "R";
    }

    if (pageNum == 1) {
      deviceController.lstrSelectedPage.value = "TC";
    }
    if (pageNum == 2) {
      deviceController.lstrSelectedPage.value = "A";
    }

  }

  wReaderApp() {

    return  GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: 4,
          // //   childAspectRatio: 0.5,
          // childAspectRatio: 0.7,
          // mainAxisSpacing: 10,
          // crossAxisSpacing: 10

            crossAxisCount: 4,
            //   childAspectRatio: 0.5,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),


        itemCount: deviceController
            .lstr_deviceList.length,
        itemBuilder: (context, index) {
          var datas = deviceController
              .lstr_deviceList;
          var user_name =
          (datas[index]["user_name"] ?? "")
              .toString();
          var dev_id =
          (datas[index]["id"] ?? "").toString();
          var dev_name =
          (datas[index]["dev_name"] ?? "")
              .toString();
          var counter =
          (datas[index]["counter"] ?? "")
              .toString();
          var date = (datas[index]["date"] ?? "")
              .toString();

          var image ="assets/images/ticketPos/pos-terminal.png";
          var status =
          (datas[index]["status"] ?? "")
              .toString();

          return Container(
            decoration:
            boxBaseDecoration(Colors.white, 20),
            // width: 220,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration:
                        boxBaseDecoration(
                            Colors
                                .grey.shade100,
                            10),


                        height: 100,
                        child: Stack(children: [
                          Center(
                            child: Image.asset(
                              (image).toString(),
                              fit: BoxFit.cover,width: 70,height: 70,

                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 6,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                              status == "O"
                                  ?Colors.greenAccent: Colors
                                  .red
                                ,
                            ),
                          )
                        ]),
                      ),
                      gapHC(5),
                      tBodyBold(
                        dev_name.toString(),
                        AppColors.appTicketDarkBlue,

                      ),
                      gapHC(1),
                      tBody(
                        dev_id.toString(),
                        AppColors.appTicketDarkBlue,
                        TextAlign.start,
                      ),
                      gapHC(2),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                  Icons.person,
                                  color:
                                  Colors.black,
                                  size: 20),
                              gapWC(3),
                              tBody(
                                  user_name
                                      .toString(),
                                  Colors.black,

                                  TextAlign.start),
                            ],
                          ),
                          gapWC(3),
                          Expanded(
                              child: tcn(
                                  date.toString(),
                                  AppColors
                                      .appTicketDarkBlue,
                                  8,
                                  TextAlign.start)),
                        ],
                      ),
                      gapHC(8),
                      Row(
                        children: [
                          const Icon(Icons.tv,
                              color: Colors.black,
                              size: 20),
                          gapWC(3),
                          tBody(
                              counter.toString(),
                              Colors.black,

                              TextAlign.start),
                        ],
                      ),
                      gapHC(5),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Container(
                    decoration: boxDecoration(
                        Colors.white, 20),
                    padding: const EdgeInsets.all(5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Container(
                              decoration: boxBaseDecoration(status=="O"?Colors.greenAccent:AppColors.white, 12),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),

                              child: tBody("OPEN",  status=="O"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                        ),
                        Flexible(
                          child: Container(
                              decoration: boxBaseDecoration(status=="A"?Colors.red:AppColors.white, 12),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                              child: tBody("CLOSE", status=="A"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                        ),

                      ],
                    ),
                  ),
                ),
                gapHC(10)
              ],
            ),
          );
        });
  }

  wTicketCounter() {


    return  GridView.builder(
        shrinkWrap: true,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: 4,
          // //   childAspectRatio: 0.5,
          // childAspectRatio: 0.7,
          // mainAxisSpacing: 10,
          // crossAxisSpacing: 10

            crossAxisCount: 4,
            //   childAspectRatio: 0.5,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),


        itemCount: deviceController
            .lstr_ticketCounterDeviceList.length,
        itemBuilder: (context, index) {
          var datas = deviceController
              .lstr_ticketCounterDeviceList;
          var user_name =
          (datas[index]["user_name"] ?? "")
              .toString();
          var dev_id =
          (datas[index]["id"] ?? "").toString();
          var dev_name =
          (datas[index]["dev_name"] ?? "")
              .toString();
          var counter =
          (datas[index]["counter"] ?? "")
              .toString();
          var date = (datas[index]["date"] ?? "")
              .toString();

          var image ="assets/images/ticketPos/pos-terminal.png";
          var status =
          (datas[index]["status"] ?? "")
              .toString();

          return Container(
            decoration:
            boxBaseDecoration(Colors.white, 20),
            // width: 220,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration:
                        boxBaseDecoration(
                            Colors
                                .grey.shade100,
                            10),


                        height: 100,
                        child: Stack(children: [
                          Center(
                            child: Image.asset(
                              (image).toString(),
                              fit: BoxFit.cover,width: 70,height: 70,

                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 6,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                              status == "O"
                                  ?Colors.greenAccent: Colors
                                  .red
                              ,
                            ),
                          )
                        ]),
                      ),
                      gapHC(5),
                      tBodyBold(
                        dev_name.toString(),
                        AppColors.appTicketDarkBlue,

                      ),
                      gapHC(1),
                      tBody(
                        dev_id.toString(),
                        AppColors.appTicketDarkBlue,
                        TextAlign.start,
                      ),
                      gapHC(2),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                  Icons.person,
                                  color:
                                  Colors.black,
                                  size: 20),
                              gapWC(3),
                              tBody(
                                  user_name
                                      .toString(),
                                  Colors.black,

                                  TextAlign.start),
                            ],
                          ),
                          gapWC(3),
                          Expanded(
                              child: tcn(
                                  date.toString(),
                                  AppColors
                                      .appTicketDarkBlue,
                                  8,
                                  TextAlign.start)),
                        ],
                      ),
                      gapHC(8),
                      Row(
                        children: [
                          const Icon(Icons.tv,
                              color: Colors.black,
                              size: 20),
                          gapWC(3),
                          tBody(
                              counter.toString(),
                              Colors.black,

                              TextAlign.start),
                        ],
                      ),
                      gapHC(5),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Container(
                    decoration: boxDecoration(
                        Colors.white, 20),
                    padding: const EdgeInsets.all(5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Container(
                              decoration: boxBaseDecoration(status=="O"?Colors.greenAccent:AppColors.white, 12),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),

                              child: tBody("OPEN",  status=="O"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                        ),
                        Flexible(
                          child: Container(
                              decoration: boxBaseDecoration(status=="A"?Colors.red:AppColors.white, 12),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                              child: tBody("CLOSE", status=="A"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                        ),

                      ],
                    ),
                  ),
                ),
                gapHC(10)
              ],
            ),
          );
        });
  }

  wAdmin() {

    return  GridView.builder(
        shrinkWrap: true,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: 4,
          // //   childAspectRatio: 0.5,
          // childAspectRatio: 0.7,
          // mainAxisSpacing: 10,
          // crossAxisSpacing: 10

            crossAxisCount: 4,
            //   childAspectRatio: 0.5,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),


        itemCount: deviceController
            .lstr_adminDeviceList.length,
        itemBuilder: (context, index) {
          var datas = deviceController
              .lstr_adminDeviceList;
          var user_name =
          (datas[index]["user_name"] ?? "")
              .toString();
          var dev_id =
          (datas[index]["id"] ?? "").toString();
          var dev_name =
          (datas[index]["dev_name"] ?? "")
              .toString();
          var counter =
          (datas[index]["counter"] ?? "")
              .toString();
          var date = (datas[index]["date"] ?? "")
              .toString();

          var image ="assets/images/ticketPos/pos-terminal.png";
          var status =
          (datas[index]["status"] ?? "")
              .toString();

          return Container(
            decoration:
            boxBaseDecoration(Colors.white, 20),
            // width: 220,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration:
                        boxBaseDecoration(
                            Colors
                                .grey.shade100,
                            10),


                        height: 100,
                        child: Stack(children: [
                          Center(
                            child: Image.asset(
                              (image).toString(),
                              fit: BoxFit.cover,width: 70,height: 70,

                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 6,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                              status == "O"
                                  ?Colors.greenAccent: Colors
                                  .red
                              ,
                            ),
                          )
                        ]),
                      ),
                      gapHC(5),
                      tBodyBold(
                        dev_name.toString(),
                        AppColors.appTicketDarkBlue,

                      ),
                      gapHC(1),
                      tBody(
                        dev_id.toString(),
                        AppColors.appTicketDarkBlue,
                        TextAlign.start,
                      ),
                      gapHC(2),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                  Icons.person,
                                  color:
                                  Colors.black,
                                  size: 20),
                              gapWC(3),
                              tBody(
                                  user_name
                                      .toString(),
                                  Colors.black,

                                  TextAlign.start),
                            ],
                          ),
                          gapWC(3),
                          Expanded(
                              child: tcn(
                                  date.toString(),
                                  AppColors
                                      .appTicketDarkBlue,
                                  8,
                                  TextAlign.start)),
                        ],
                      ),
                      gapHC(8),
                      Row(
                        children: [
                          const Icon(Icons.tv,
                              color: Colors.black,
                              size: 20),
                          gapWC(3),
                          tBody(
                              counter.toString(),
                              Colors.black,

                              TextAlign.start),
                        ],
                      ),
                      gapHC(5),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Container(
                    decoration: boxDecoration(
                        Colors.white, 20),
                    padding: const EdgeInsets.all(5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Container(
                              decoration: boxBaseDecoration(status=="O"?Colors.greenAccent:AppColors.white, 12),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),

                              child: tBody("OPEN",  status=="O"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                        ),
                        Flexible(
                          child: Container(
                              decoration: boxBaseDecoration(status=="A"?Colors.red:AppColors.white, 12),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                              child: tBody("CLOSE", status=="A"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                        ),

                      ],
                    ),
                  ),
                ),
                gapHC(10)
              ],
            ),
          );
        });
  }


}