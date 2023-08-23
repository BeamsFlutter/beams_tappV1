import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_code.dart';
import '../../constants/styles.dart';
import '../controller/tktCounterController.dart';

class TicketCounterScreen extends StatefulWidget {
  const TicketCounterScreen({super.key});

  @override
  State<TicketCounterScreen> createState() => _TicketCounterScreenState();
}

class _TicketCounterScreenState extends State<TicketCounterScreen> {
  final TicketCounterController ticketCounterController =
      Get.put(TicketCounterController());
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
                                      "Counter",
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
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                   //   childAspectRatio: 0.5,
                                      childAspectRatio: 0.7,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10



                                    ),
                                    itemCount: ticketCounterController
                                        .lstr_counterList.length,
                                    itemBuilder: (context, index) {
                                      var datas = ticketCounterController
                                          .lstr_counterList;
                                      var counterCode =
                                          (datas[index]["counterCode"] ?? "")
                                              .toString();
                                      var counterName =
                                          (datas[index]["counterName"] ?? "")
                                              .toString();
                                      var price = (datas[index]["price"] ?? "")
                                          .toString();
                                      var userName =
                                          (datas[index]["price"] ?? "")
                                              .toString();
                                      var activeGuestCount = (datas[index]
                                                  ["activeGuestCount"] ??
                                              "")
                                          .toString();
                                      var image =
                                          (datas[index]["imageUrl"] ?? "")
                                              .toString();
                                      var status =
                                          (datas[index]["status"] ?? "")
                                              .toString();

                                      return   Container(
                                        decoration: boxBaseDecoration(Colors.white, 20),
                                        // width: 220,
                                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: boxBaseDecoration(Colors.grey.shade100, 20),
                                                    margin: const EdgeInsets.only(bottom: 5),
                                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                    height: 100,
                                                    child: Center(
                                                      child: Image.network(
                                                        (image).toString(),
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Container(
                                                            color: Colors.grey.shade100,
                                                            alignment: Alignment.center,
                                                            child: Container(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  tBodyBold(
                                                    "#${counterCode.toString()}",
                                                    AppColors.appTicketDarkBlue,

                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      tBodyBold(
                                                        counterName.toString(),
                                                        AppColors.appTicketDarkBlue,

                                                      ),
                                                      tBodyBold(
                                                        mfnDbl(price).toString(),
                                                        AppColors.appTicketLIGHTRED,

                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.person, color: Colors.black, size: 20),
                                                      gapWC(3),
                                                      tBody(userName.toString(), Colors.black,  TextAlign.start),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.supervised_user_circle_outlined,
                                                              color: Colors.black, size: 20),
                                                          gapWC(3),
                                                          tBody("Live Guest", Colors.black,  TextAlign.start),
                                                        ],
                                                      ),
                                                      tBodyBold(activeGuestCount.toString(), Colors.black,
                                                         ),
                                                    ],
                                                  ),
                                                  gapHC(5),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 18),
                                              child: Container(
                                                decoration: boxDecoration(Colors.white, 20),

                                                padding: EdgeInsets.all(5),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                          decoration: boxBaseDecoration(status=="O"?AppColors.appTicketColor1:AppColors.white, 12),
                                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),

                                                          child: tBody("OPEN",  status=="O"?AppColors.white:AppColors.appTicketDarkBlue,  TextAlign.start)),
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                          decoration: boxBaseDecoration(status=="A"?Colors.red:AppColors.white, 12),
                                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                                                          child: tBody("CLOSE", status=="A"?AppColors.white:AppColors.appTicketDarkBlue, TextAlign.start)),
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
                      child: Container(
                        decoration: boxBaseDecoration(Colors.white, 30),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Image.network(
                                        (    (ticketCounterController
                                            .lstr_counterList[0]["imageUrl"] ?? "")
                                            .toString()).toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey.shade100,
                                            alignment: Alignment.center,
                                            child: Container(),
                                          );
                                        },
                                      ),
                                      gapWC(20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          tBodyBold(
                                            "#101",
                                            AppColors.white,

                                          ),
                                          tBodyBold(
                                            "KIDS TRAIN",
                                            AppColors.white,height1: 0.9

                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                  tHead2(
                                    "25.00",
                                    AppColors.white,
                                  ),
                                ],
                              ),
                            ),

                            gapHC(10),
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.black, size: 20),
                                gapWC(3),
                                tBody("Ahmed", Colors.black,  TextAlign.start),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.supervised_user_circle_outlined,
                                    color: Colors.black, size: 20),
                                gapWC(3),
                                tBody("Live Guest", Colors.black,  TextAlign.start),
                                gapWC(25),
                                tBodyBold("20", AppColors.appTicketDarkBlue),
                              ],
                            ),
                            gapHC(15),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              decoration: boxBaseDecoration(Colors.grey.shade100, 20),
                              child: tSubHead("Log Details", Colors.black.withOpacity(0.5),  TextAlign.start),
                            ),
                            gapHC(12),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                physics: BouncingScrollPhysics(),
                                itemCount: ticketCounterController.lstr_logDetails.length,

                                  itemBuilder: (context,index){
                                    // "name":"RAJ",
                                    // "id":"ed:tr:dfg:rr:ee",
                                    // "date":"12 JULY 2023 12:44",
                                    // "price":"-23.00"

                                    var datas = ticketCounterController.lstr_logDetails;
                                    var name = (datas[index]["name"]??"").toString();
                                    var id = (datas[index]["id"]??"").toString();
                                    var date = (datas[index]["date"]??"").toString();
                                    var price = (datas[index]["price"]??"").toString();

                                return      Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            tHead2(name.toString(), Colors.black,),
                                            tBody(id.toString(), Colors.black, TextAlign.start),
                                            tBody(date.toString(), Colors.black.withOpacity(0.5),TextAlign.start),

                                          ],
                                        ),
                                        tHead2(price.toString(), Colors.red,),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )







                          ],
                        ),




                      ),
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

  // var datas=ticketCounterController.lstr_counterList;
  // var counterCode=(datas[index]["counterCode"]??"").toString();
  // var counterName=(datas[index]["counterName"]??"").toString();
  // var price=(datas[index]["price"]??"").toString();
  // var userName=(datas[index]["price"]??"").toString();
  // var activeGuestCount=(datas[index]["activeGuestCount"]??"").toString();
  // var image=(datas[index]["imageUrl"]??"").toString();
  // var status=(datas[index]["status"]??"").toString();

  // return  Container(
  // decoration: boxBaseDecoration(Colors.white, 20),
  // width: 220,
  // padding: const EdgeInsets.only(left: 15,right:15,top: 10),
  // child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Container(
  //
  // decoration: boxBaseDecoration(Colors.grey.shade100, 20),
  // margin: const EdgeInsets.only(bottom: 5),
  // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  // height: 100,
  // child:  Center(
  // child: Image.network((image).toString(),fit: BoxFit.cover,
  // errorBuilder: (context, error, stackTrace) {
  // return Container(
  // color: Colors.grey.shade100,
  // alignment: Alignment.center,
  // child:  Container(
  //
  // ),
  // );
  // }, ),
  // ),
  //
  // ),
  // tc("#${counterCode.toString()}", AppColors.appTicketDarkBlue, 12,),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // tc(counterName.toString(), AppColors.appTicketDarkBlue, 13,),
  // tc(mfnDbl(price).toString(), AppColors.appTicketLIGHTRED, 13,),
  // ],
  // ),
  // Row(
  // children: [
  // const Icon(Icons.person,color:Colors.black,size: 20),
  // gapWC(3),
  // tcn(userName.toString(), Colors.black, 12,TextAlign.start),
  // ],
  // ),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // Row(
  // children: [
  // const Icon(Icons.supervised_user_circle_outlined,color:Colors.black,size: 20),
  // gapWC(3),
  // tcn("Live Guest", Colors.black, 12,TextAlign.start),
  // ],
  // ),
  // tcn(activeGuestCount.toString(), Colors.black, 13,TextAlign.start),
  // ],
  // ),
  // gapHC(5),
  // Container(
  // decoration: boxDecoration(Colors.white, 20),
  // margin: EdgeInsets.symmetric(horizontal: 15),
  //
  // child:Padding(
  // padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
  // child: Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // Container(
  // // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
  // // padding: const EdgeInsets.symmetric(horizontal:28 ,vertical: 6),
  // decoration: boxBaseDecoration(status=="A"?Colors.greenAccent:Colors.white, 20),
  // child:     tcn("OPEN", status=="A"?Colors.white:AppColors.appTicketDarkBlue, 12,TextAlign.start),
  // ),
  // Container(
  // // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
  // // padding: const EdgeInsets.symmetric(horizontal:28 ,vertical: 6),
  // decoration: boxBaseDecoration(status=="A"?Colors.white:Colors.red, 20),
  // child:     tcn("CLOSE",status=="A"?Colors.white:AppColors.white, 12,TextAlign.start),
  // )
  // ],
  // ),
  // ),
  // )
  //
  //
  // ],
  // ),
  // );
  //

  List<Widget> counterViewList() {
    List<Widget> rtnList = [];
    for (var e in ticketCounterController.lstr_counterList) {
      var counterCode = (e["counterCode"] ?? "").toString();
      var counterName = (e["counterName"] ?? "").toString();
      var price = (e["price"] ?? "").toString();
      var userName = (e["price"] ?? "").toString();
      var activeGuestCount = (e["activeGuestCount"] ?? "").toString();
      var image = (e["imageUrl"] ?? "").toString();
      var status = (e["status"] ?? "").toString();
      rtnList.add(
          Container(
        decoration: boxBaseDecoration(Colors.white, 20),
        width: 220,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: boxBaseDecoration(Colors.grey.shade100, 20),
              margin: const EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 100,
              child: Center(
                child: Image.network(
                  (image).toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade100,
                      alignment: Alignment.center,
                      child: Container(),
                    );
                  },
                ),
              ),
            ),
            tc(
              "#${counterCode.toString()}",
              AppColors.appTicketDarkBlue,
              12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tc(
                  counterName.toString(),
                  AppColors.appTicketDarkBlue,
                  13,
                ),
                tc(
                  mfnDbl(price).toString(),
                  AppColors.appTicketLIGHTRED,
                  13,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.black, size: 20),
                gapWC(3),
                tcn(userName.toString(), Colors.black, 12, TextAlign.start),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.supervised_user_circle_outlined,
                        color: Colors.black, size: 20),
                    gapWC(3),
                    tcn("Live Guest", Colors.black, 12, TextAlign.start),
                  ],
                ),
                tcn(activeGuestCount.toString(), Colors.black, 13,
                    TextAlign.start),
              ],
            ),
            gapHC(5),
            Container(
              decoration: boxDecoration(Colors.white, 20),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Container(
                          decoration: boxBaseDecoration(status=="O"?AppColors.appTicketColor1:AppColors.white, 12),
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),

                          child: tcn("OPEN",  status=="O"?AppColors.white:AppColors.appTicketDarkBlue, 12, TextAlign.start)),
                    ),
                    Flexible(
                      child: Container(
                          decoration: boxBaseDecoration(status=="C"?AppColors.appTicketColor1:AppColors.white, 12),
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                          child: tcn("CLOSE", status=="C"?AppColors.white:AppColors.appTicketDarkBlue, 12, TextAlign.start)),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ));
    }
    return rtnList;
  }
}
