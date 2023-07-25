
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common_widgets/title_withUnderline.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/dateformates.dart';
import '../../../../constants/enums/filterMode.dart';
import '../../../../constants/string_constant.dart';
import '../../../../constants/styles.dart';
import '../../../../view/commonController.dart';
import '../controller/adminHistory_controller.dart';

class AdminHistoryScreen extends StatefulWidget {
  const AdminHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminHistoryScreen> createState() => _AdminHistoryScreenState();
}

class _AdminHistoryScreenState extends State<AdminHistoryScreen> {

  final AdminHistoryController adminHistoryController = Get.put(AdminHistoryController());
  final CommonController commonController = Get.put(CommonController());

  Widget wFromTo() {
    return   Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Bounce(
          onPressed: (){
            adminHistoryController.wSelectDate(context,DateMode.from);
          },
          duration: const Duration(milliseconds: 110),
          child: Material(
            elevation: 9,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
            borderRadius:BorderRadius.circular(5.0) ,

            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                child: tc(DateFormat('dd-MM-yyyy').format(adminHistoryController.fromcurrentDate.value), AppColors.fontcolor, 11)
            ),
          ),
        ),
        tc("to", AppColors.fontcolor, 11),
        Bounce(
          onPressed: (){
            adminHistoryController.wSelectDate(context,DateMode.to);
          },
          duration: const Duration(milliseconds: 110),
          child: Material(
            elevation: 9,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
            borderRadius:BorderRadius.circular(5.0) ,

            // shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
            child: Container(

                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                child: tc(DateFormat('dd-MM-yyyy').format(adminHistoryController.tocurrentDate.value), AppColors.fontcolor, 11)
            ),
          ),
        ),
      ],
    ));
  }
  BluetoothDevice? _device;
  @override
  void initState() {
    fnBlutoothConnect();
    adminHistoryController.fnGetHistory('Today');
    adminHistoryController.printData.add({
      "TITLE":"",
      "TYPE":"T",
      "KEY":"",
      "DEFAULT_VALUE":"SPLASH & PARTY",
      "X":10,
      "Y":30,
      "FONT_SIZE":1,
      "ZOOM":2,
      "ALIGN":"C",
      "WEIGHT":1
    });
    adminHistoryController.printData.add({
      "TITLE":"",
      "TYPE":"T",
      "KEY":"",
      "DEFAULT_VALUE":"AL SAFA, DUBAI",
      "X":10,
      "Y":30,
      "FONT_SIZE":18,
      "ZOOM":1,
      "ALIGN":"C",
    });
    adminHistoryController.printData.add({
      "TITLE":"",
      "TYPE":"T",
      "KEY":"",
      "DEFAULT_VALUE":"UAE",
      "X":10,
      "Y":30,
      "ZOOM":1,
      "FONT_SIZE":18,
      "ALIGN":"C",
      "FEED":5
    });
    adminHistoryController.printData.add({
      "TYPE":"L",
      "FEED":5

    });
    adminHistoryController. printData.add({
      "TITLE":"DATE",
      "TYPE":"T",
      "KEY":"DATE",
      "DEFAULT_VALUE":"",
      "X":20,
      "Y":30,
      "ZOOM":1,
      "ALIGN":"L",
    });
    adminHistoryController. printData.add({
      "TYPE":"L",
      "FEED":1
    });
    adminHistoryController. printData.add({
      "TITLE":"#",
      "TYPE":"T",
      "KEY":"CODE",
      "DEFAULT_VALUE":"",
      "X":60,
      "Y":30,
      "ZOOM":1,
      "ALIGN":"L",
    });
    adminHistoryController. printData.add({
      "TITLE":"",
      "TYPE":"T",
      "KEY":"",
      "DEFAULT_VALUE":"-----------------------------",
      "X":0,
      "Y":0,
      "ZOOM":1,
      "FONT_SIZE":20,
      "ALIGN":"C",
    });



    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build Running  ${adminHistoryController.fromto.value}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      // resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.primarycolor,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: tsw(AppStrings.history,AppColors.white,20,FontWeight.w500),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      //     onPressed: () => Get.back(),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.print, color: Colors.white),
      //       onPressed: () => adminHistoryController.historyList.isNotEmpty?adminHistoryController.fnPrint():null,
      //     ),
      //   ],
      // ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: boxDecoration(Colors.white, 10),
        margin: const EdgeInsets.all(10),
        padding:const  EdgeInsets.all(10),

        child: Padding(
          padding: const EdgeInsets.only(top: 17,right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWithUnderLine(title: AppStrings.history,),
              gapHC(20),
              Obx(() =>     Container(
                padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                decoration: BoxDecoration(
                    color: AppColors.primarycolor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 23,
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.primarycolor,
                              )),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                            // Initial Value
                            value: adminHistoryController.dropdownDeviceItemsValue.value.toString(),
                            // Down Arrow Icon
                            icon: const Icon(Icons.arrow_forward_ios_rounded,
                                size: 13),

                            // Array list of items
                            items: adminHistoryController.deviceItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: tcnw(items, AppColors.fontcolor, 12,
                                    TextAlign.center, FontWeight.w300),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              adminHistoryController.fnOnChnageDeviceItems(value,"","");
                            },
                          ),
                        ),
                        gapWC(10),
                        Container(

                          height: 23,
                          padding: const EdgeInsets.only(right: 10,left: 10,),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.primarycolor,
                              )),
                          child:   DropdownButton(
                            underline: const SizedBox(),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            // Initial Value
                            value: adminHistoryController.dropdownvalue.value.toString(),
                            // Down Arrow Icon
                            icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),

                            // Array list of items
                            items: adminHistoryController.items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: tcnw(items, AppColors.fontcolor, 12,TextAlign.center,FontWeight.w300),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              adminHistoryController.fnOnChnagedDay(value);
                            },
                            // onChanged: (String? newValue) {
                            //   // setState(() {
                            //   //   dropdownvalue = newValue!;
                            //   // });
                            // },
                          ),
                        ),
                      ],
                    ),
                    Bounce(
                      onPressed: (){
                        adminHistoryController.fnExportHistory();
                      },
                      duration: const Duration(milliseconds: 110),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: boxDecoration(AppColors.white, 30),
                        child: tc("Export",Colors.black,12),
                      ),
                    ),
                  ],
                ),
              ),),
              gapHC(10),

              Obx(() =>adminHistoryController.fromto.value==true ? wFromTo():const SizedBox()),
              gapHC(10),
              Obx(() => adminHistoryController.choosedevice.value ? wChooseDeviceField()
                  : const SizedBox()),

              gapHC(8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(AppColors.primarycolor, 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th('Sr.No', Colors.white, 12)
                        ],
                      ),
                    ),
                    gapWC(10),
                    wRowHead(1, "Head","L"),
                    wRowHead(1, "Doc #","L"),
                    wRowHead(1, "Date","L"),
                    wRowHead(1, "Card Number","L"),
                    wRowHead(2, "Party Name","L"),
                    wRowHead(1, "Device Name","L"),
                    wRowHead(1, "Create User","L"),
                    wRowHead(1, "Amount","R"),
                  ],
                ),
              ),
              gapHC(5),
              Obx(() =>  Expanded(
                child: adminHistoryController.historyList.isNotEmpty?  ListView.builder
                  (
                    itemCount: adminHistoryController.historyList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      var datas =adminHistoryController.historyList[index];
                      var docdate= "";
                      try{
                        docdate =setDate(15, DateTime.parse(datas.dOCDATE.toString()));
                      }catch(e){}
                      return Container(
                        margin: const EdgeInsets.only(bottom: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration(Colors.white, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(),
                                  th((index+1).toString(), Colors.black, 12)
                                ],
                              ),
                            ),
                            gapWC(10),
                            wRowDet(1, datas.tITLE.toString().toUpperCase(),"L"),
                            wRowDet(1, datas.dOCNO.toString(),"L"),
                            wRowDet(1, docdate.toString(),"L"),
                            wRowDet(1, datas.cARDNO.toString().toUpperCase(),"L"),


                            Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(),
                                    tc((datas.sLDESC??"").toString().toUpperCase(), Colors.black, 12),
                                    tc((datas.mOBILE??"").toString().toUpperCase(), Colors.black, 12),
                                    tc((datas.eMAIL??"").toString().toUpperCase(), Colors.black, 12),
                                  ],
                                )
                            ),
                            wRowDet(1, datas.deviceName.toString().toUpperCase(),"L"),
                            wRowDet(1, datas.cREATEUSER.toString().toUpperCase(),"L"),
                            wRowDet(1, datas.aMT.toString().toString(),"R"),
                          ],
                        ),
                      );
                    }):    Center(
                  child: tc("No Data Found", AppColors.lightfontcolor, 14),
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
  //=======================================================WIDGET
  Widget wChooseDeviceField() {
    dprint("choooosw");
    return SizedBox(
      height: 40,
      child: Padding(
        padding:         const EdgeInsets.symmetric(horizontal: 20,),
        child: GestureDetector(
          onTap: (){
            print("Loookupppppppppppppppppp...");
            adminHistoryController.fnDeviceLookup();
          },
          child: Material(
            elevation: 30,
            borderRadius: BorderRadius.circular(8) ,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
            child: TextFormField(
              showCursor:false,
              enabled: false,
              autofocus: false,
              keyboardType: TextInputType.none,
              controller: adminHistoryController.txtdeviceName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  hintText: "Choose a Device",
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                  filled: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 15.0),
                  suffixIcon: Icon(Icons.search)


              ),


            ),
          ),
        ),
      ),
    );
  }
  Widget wRowHead(flex,head,align){
    return Flexible(
        flex: flex,
        child: Column(
          crossAxisAlignment:align == "L"? CrossAxisAlignment.start:align == "R"? CrossAxisAlignment.end:CrossAxisAlignment.center,
          children: [
            Row(),
            th(head, Colors.white, 12)
          ],
        )
    );
  }
  Widget wRowDet(flex,head,align){
    return Flexible(
        flex: flex,
        child: Column(
          crossAxisAlignment:align == "L"? CrossAxisAlignment.start:align == "R"? CrossAxisAlignment.end:CrossAxisAlignment.center,
          children: [
            Row(),
            tc(head, Colors.black, 12)
          ],
        )
    );
  }

  //=================================================PAGE FN
  fnBlutoothConnect() async {
    List<BtDevice> devices = await adminHistoryController.flutterbluetoothconnector.getDevices();
    if (devices.isNotEmpty) {
      print(devices[0].address.toString());
      print(devices[0].name.toString());
      setState(() {
        BluetoothDevice d = BluetoothDevice();
        d.address = devices[0].address;
        d.name = devices[0].name;
        _device = d;
      });
      if (_device != null && _device!.address != null) {
        await adminHistoryController.bluetoothPrint.connect(_device!);
        // Future.delayed(
        //   Duration(seconds: 2),
        //       () {
        //     if (commonController.printYn.value == "Y") {
        //       historyController.fnPrint();
        //     }
        //   },
        // );
      }
    }
  }
}
