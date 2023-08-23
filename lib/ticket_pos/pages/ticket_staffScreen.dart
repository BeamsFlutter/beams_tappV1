import 'package:beams_tapp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/tabButton.dart';
import '../../constants/color_code.dart';
import '../controller/tktStaffController.dart';

class TicketStaffScreen extends StatefulWidget {
  const TicketStaffScreen({super.key});

  @override
  State<TicketStaffScreen> createState() => _TicketStaffScreenState();
}

class _TicketStaffScreenState extends State<TicketStaffScreen> {
  final TicketStaffController ticketStaffController = Get.put(TicketStaffController());
  @override
  void initState() {
    ticketStaffController.pageController = PageController();
    ticketStaffController.selectedPage.value = 0;
    ticketStaffController.lstrSelectedPage.value = "UD";

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: MediaQuery.of(context).padding,
        decoration: boxGradientCLBR(
            AppColors.appReaderBgRed, AppColors.appReaderBgBlue, 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tHead("Beams", AppColors.white,),
                          tcnH(
                              "VERSION V1.0",
                              AppColors.appBgGreyshde.withOpacity(0.5),
                              10,
                              TextAlign.center,
                              0.11),
                        ],
                      ),
                      tcS("   Fungate ", AppColors.white, 30),
                    ],
                  ),
                  Container(
                    decoration: boxBaseDecoration(
                        AppColors.appReaderDarkBlck.withOpacity(0.36), 23),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20,
                        ),
                        gapWC(6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc("D0001", AppColors.white, 10),
                            tcnH("DEIRA CITY CENTER", AppColors.white, 10,
                                TextAlign.start, 0.95),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.wifi, color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("192.168.0.100", Colors.white, 12, TextAlign.center)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone_android_outlined,
                          color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("9787826367", Colors.white, 12, TextAlign.center)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance,
                          color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("SPLASH AND PARTY LLC.", Colors.white, 12,
                          TextAlign.start)
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 2),
                        decoration: boxBaseDecoration(Colors.transparent, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: double.maxFinite,
                                height: 60,
                                padding: const EdgeInsets.only(left: 20),
                                decoration: boxBaseDecoration(Colors.white, 15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    tHead2(
                                      "User",
                                      AppColors.appTicketDarkBlue,

                                    ),
                                    Container(
                                      width: size.width / 3.6,
                                      margin: const EdgeInsets.all(7),
                                      // decoration: boxBaseDecoration(Colors.grey.shade100, 30),
                                      child: TextField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(Icons.search,
                                              color: Colors.grey, size: 35),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            gapHC(20),
                            Expanded(
                                child: GridView.builder(
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
                                        childAspectRatio: 0.62,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                    // {
                                    //   "dev_name":"DEVICE 1",
                                    //   "staff_id":"ASPOIGG POJKFFJF",
                                    //   "staff_name":"AHMED",
                                    //   "date":"12 JULY 12:44 AM",
                                    //   "counter":"KIDS TRAIN",
                                    //   "status":"A",
                                    // },

                                    itemCount: ticketStaffController
                                        .lstr_staffList.length,
                                    itemBuilder: (context, index) {
                                      var datas = ticketStaffController.lstr_staffList;
                                      var staff_name =
                                      (datas[index]["staff_name"] ?? "")
                                          .toString();
                                      var staff_id =
                                      (datas[index]["staff_id"] ?? "").toString();
                                      var dev_name =
                                      (datas[index]["dev_name"] ?? "")
                                          .toString();
                                      var counter =
                                      (datas[index]["counter"] ?? "")
                                          .toString();
                                      var date = (datas[index]["date"] ?? "")
                                          .toString();
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
                                                        20),
                                                    margin:
                                                    const EdgeInsets.only(
                                                        bottom: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    height: 100,
                                                    child:        Center(
                                                      child: Image.asset(
                                                        "assets/images/ticketPos/receptionist.png",
                                                        fit: BoxFit.cover,

                                                      ),
                                                    ),
                                                  ),
                                                  gapHC(5),
                                                  tBodyBold(
                                                    "#${staff_id.toString()}",
                                                    AppColors.appTicketDarkBlue,

                                                  ),
                                                  gapHC(1),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.person,
                                                          color:
                                                          Colors.black,
                                                          size: 20),
                                                      gapWC(3),
                                                      tBody(
                                                          staff_name
                                                              .toString(),
                                                          AppColors.appTicketDarkBlue,

                                                          TextAlign.start),
                                                    ],
                                                  ),
                                                  gapHC(5),
                                                  tBody("Last Login Details", Colors.grey.shade500,  TextAlign.start),
                                                  tBody("     ${counter.toString()}", Colors.black,  TextAlign.start),
                                                  tBody("     ${dev_name.toString()}",Colors.black,  TextAlign.start),
                                                  tBody("     ${date.toString()}", Colors.black,  TextAlign.start)

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Container(
                                                decoration: boxDecoration(
                                                    Colors.white, 20),
                                                padding:
                                                const EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        decoration: boxBaseDecoration(status=="A"?AppColors.appTicketColor1:AppColors.white, 12),
                                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),

                                                          child: tBody("Active",  status=="A"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                                                    ),
                                                         Flexible(
                                                           child: Container(
                                                              decoration: boxBaseDecoration(status=="B"?Colors.red:AppColors.white, 12),
                                                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                                                              child: tBody("Block", status=="B"?AppColors.white:AppColors.appTicketDarkBlue, TextAlign.start)),
                                                         ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            gapHC(10)
                                          ],
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      ),
                    ),
                    gapWC(20),
                    Flexible(
                      flex: 3,
                      child: Obx(() => Container(
                          width: double.maxFinite,
                          decoration: boxBaseDecoration(Colors.white, 30),

                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 2),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: boxBaseDecoration(AppColors.appTicketColor1, 20),

                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                      height: 70,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/ticketPos/receptionist.png",
                                                fit: BoxFit.cover,

                                              ),
                                              gapWC(20),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  tBodyBold(
                                                    "#C0001",
                                                    AppColors.white,

                                                  ),
                                                  tBodyBold(
                                                    "Ahmed",
                                                    AppColors.white,
                                                    height1: 0.9

                                                  ),
                                                ],
                                              ),


                                            ],
                                          ),
                                          tc(
                                            "****",
                                            AppColors.white,
                                            23,
                                          ),
                                        ],
                                      ),
                                    ),
                                    gapHC(10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        tBody("Last Login Details", Colors.grey,  TextAlign.start),
                                        tBody("More Log Details", Colors.grey,  TextAlign.start),
                                      ],
                                    ),
                                    gapHC(10),
                                    Container(
                                      width: double.maxFinite,
                                      decoration: boxBaseDecoration(Colors.grey.shade100, 15),
                                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          tBody("COUNTER 1", Colors.black,  TextAlign.start),
                                          tBody("DEVICE 100", Colors.black, TextAlign.start),
                                          tBody("12 JULY 2023 11:33 AM", Colors.black,  TextAlign.start)
                                        ],
                                      ),
                                    ),
                                    gapHC(10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 2),
                                      decoration: boxDecoration(Colors.white, 30),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: TabButton(
                                              radius: 30.0,
                                              width: 0.3,
                                              tabColor: AppColors.appTicketDarkBlue,
                                              text: "User Details",
                                              pageNumber: 0,
                                              selectedPage: ticketStaffController
                                                  .selectedPage.value,
                                              onPressed: () {
                                                ticketStaffController.lstrSelectedPage.value = "UD";
                                                changePage(0);
                                              },
                                            ),
                                          ),
                                          gapWC(3),
                                          Flexible(
                                            child: TabButton(
                                              radius: 30.0,
                                              width: 0.3,
                                              text: "Permission",
                                              pageNumber: 1,              tabColor: AppColors.appTicketDarkBlue,
                                              selectedPage: ticketStaffController
                                                  .selectedPage.value,
                                              onPressed: () {
                                                ticketStaffController
                                                    .lstrSelectedPage.value = "PR";
                                                changePage(1);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: PageView(
                                  onPageChanged: (int page) {
                                    ticketStaffController
                                        .selectedPage.value = page;
                                  },
                                  controller:
                                  ticketStaffController.pageController,
                                  children: [
                                    wUserDetails(),
                                    wPermission(),
                                  ],
                                ),
                              ),

                            ],
                          )
                      )) ,
                    ),
                  ],
                ),
              ),
            ),
            gapHC(20)
          ],
        ),
      ),
    );
  }


  changePage(int pageNum) {
    ticketStaffController.selectedPage.value = pageNum;

    ticketStaffController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      ticketStaffController.lstrSelectedPage.value = "UD";
    }

    if (pageNum == 1) {
      ticketStaffController.lstrSelectedPage.value = "PR";
    }
  }
  wPermission(){
    return Container(
      child: Column(
        children: [
          gapHC(10),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                  child: tBody("Counter Permission", Colors.black,  TextAlign.start),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.greenAccent,
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))) ,
                    value: ticketStaffController.checkboxval.value,
                    onChanged: (bool? value) {
                      setState(() {
                        ticketStaffController.checkboxval.value = value!;
                      });
                    },

                  ),
                ),
              ],
            ),
          ),
          gapHC(10),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                    child: tBody("Other Permission", Colors.black,  TextAlign.start),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.greenAccent,
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))) ,
                    value: ticketStaffController.checkboxOther.value,
                    onChanged: (bool? value) {
                      setState(() {
                        ticketStaffController.checkboxOther.value = value!;
                      });
                    },

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  wUserDetails(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                tHead2("AHMED MELANGADI",
                  AppColors.appTicketDarkBlue,),
              ],
            ),
            gapHC(8),
            Row(
              children: [
                const Icon(Icons.phone_android, size: 15,color: Colors.black,),
                gapWC(2),
                tBodyBold(
                  "9723737373",
                  Colors.black,

                ),
              ],
            ),
            gapHC(3),
            Row(
              children: [
                const Icon(Icons.alternate_email_outlined,color: Colors.black,
                    size: 15),
                gapWC(2),
                tBodyBold(
                    "hakeem.beams@gmail.com",
                    Colors.black,height1: 0.9

                ),
              ],
            ),
            gapHC(3),
            Row(
              children: [
                const Icon(Icons.calendar_month,color: Colors.black,
                    size: 15),
                gapWC(2),
                tBodyBold(
                    "10-10-1997",
                    Colors.black,height1: 0.9

                ),
              ],
            ),
            gapHC(3),
            Row(
              children: [
                const Icon(Icons.apartment,color: Colors.black,
                    size: 15),
                gapWC(2),
                tBodyBold(
                    "Dubai",
                    Colors.black,height1: 0.9
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
