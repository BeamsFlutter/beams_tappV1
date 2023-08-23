import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/color_code.dart';
import '../../constants/styles.dart';
import '../controller/tktDeviceController.dart';

class TicketDeviceScreen extends StatefulWidget {
  const TicketDeviceScreen({super.key});

  @override
  State<TicketDeviceScreen> createState() => _TicketDeviceScreenState();
}

class _TicketDeviceScreenState extends State<TicketDeviceScreen> {
  final TicketDeviceController ticketDeviceController = Get.put(TicketDeviceController());
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
                                      "Devices",
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
                                            childAspectRatio: 0.68,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    // "dev_name":"DEVICE 1",
                                    // "id":"ASPOIGG POJKFFJF",
                                    // "user_name":"AHMED",
                                    // "date":"12 JULY 12:44 AM",
                                    // "counter":"KIDS TRAIN",
                                    // "status":"A"

                                    itemCount: ticketDeviceController
                                        .lstr_deviceList.length,
                                    itemBuilder: (context, index) {
                                      var datas = ticketDeviceController
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

                                      var image =
                                          (datas[index]["imageUrl"] ?? "")
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
                                                    child: Stack(children: [
                                                      Center(
                                                        child: Image.network(
                                                          (image).toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Container(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  Container(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 1,
                                                        right: 1,
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              status == "O"
                                                                  ? AppColors
                                                                      .appTicketColor1
                                                                  : Colors.red,
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
                                                      horizontal: 18),
                                              child: Container(
                                                decoration: boxDecoration(
                                                    Colors.white, 20),
                                                padding: const EdgeInsets.all(5),
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
                                    }))
                          ],
                        ),
                      ),
                    ),
                    gapWC(20),
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: double.maxFinite,
                        decoration: boxBaseDecoration(Colors.white, 30),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 2),
                        child: Column(
                          children: [
                            Container(
                              decoration:
                                  boxBaseDecoration(Colors.grey.shade100, 20),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  gapWC(5),
                                  tHead2("Add New Device", Colors.black, )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                tHead2("Scan QR Code", AppColors.appTicketDarkBlue,
                                    ),
                                gapHC(5),
                                tBody(
                                    "To initiate the process of adding a new device to this site,Please scan the QR code provided",
                                    Colors.black.withOpacity(0.5),
                                    TextAlign.center),
                                gapHC(15),
                                QrImageView(
                                  data: 'This QR code has an embedded image as well',
                                  version: QrVersions.auto,
                                  size: 200,
                                  gapless: false,
                                  embeddedImage: const AssetImage(
                                      'assets/images/my_embedded_image.png'),
                                  embeddedImageStyle: const QrEmbeddedImageStyle(
                                    size: Size(80, 80),
                                  ),
                                ),
                                gapHC(15),
                                tHead2("OR", Colors.black.withOpacity(0.4), ),
                                gapHC(10),
                                tHead2("Use site code.",
                                    AppColors.appTicketDarkBlue, ),
                                gapHC(20),
                                GestureDetector(
                                    onTap: () {
                                      ticketDeviceController
                                          .wPasscodeBottomsheet(context);
                                    },
                                    child: tHead3("AB00253", Colors.black,)),
                                tSubHead("DEIRA CITY CENTER", Colors.black,
                                    TextAlign.center),
                              ],
                            ))
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
}
