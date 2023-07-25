import 'dart:io';

import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/filterMode.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';

import 'package:beams_tapp/view/commonController.dart';import 'package:beams_tapp/view/history/controller/history_controller.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  final HistoryController historyController = Get.put(HistoryController());
  final CommonController commonController = Get.put(CommonController());

  Widget wFromTo() {
    return   Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Bounce(
          onPressed: (){
            historyController.wSelectDate(context,DateMode.from);
          },
          duration: const Duration(milliseconds: 110),
          child: Material(
            elevation: 9,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
            borderRadius:BorderRadius.circular(5.0) ,

            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                child: tc(DateFormat('dd-MM-yyyy').format(historyController.fromcurrentDate.value), AppColors.fontcolor, 11)
            ),
          ),
        ),
        tc("to", AppColors.fontcolor, 11),
        Bounce(
          onPressed: (){
            historyController.wSelectDate(context,DateMode.to);
          },
          duration: const Duration(milliseconds: 110),
          child: Material(
            elevation: 9,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
            borderRadius:BorderRadius.circular(5.0) ,

            // shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
            child: Container(

                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                child: tc(DateFormat('dd-MM-yyyy').format(historyController.tocurrentDate.value), AppColors.fontcolor, 11)
            ),
          ),
        ),
      ],
    ));
  }
  BluetoothDevice? _device;
  //====================================sunmi variable
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";


  @override
  void initState() {
    commonController.wstrSunmiDevice.value=="Y"?sunmiPrintInitState(): fnBlutoothConnect();

    // fnBlutoothConnect();
//    sunmiPrintInitState();
    historyController.fnGetHistory('Today');
    //
    // historyController.printData.add({
    //       "TITLE":"",
    //       "TYPE":"T",
    //       "KEY":"",
    //       "DEFAULT_VALUE":"SPLASH & PARTY",
    //       "X":10,
    //       "Y":30,
    //       "FONT_SIZE":1,
    //       "ZOOM":2,
    //       "ALIGN":"C",
    //       "WEIGHT":1
    //     });
    // historyController.printData.add({
    //   "TITLE":"",
    //   "TYPE":"T",
    //   "KEY":"",
    //   "DEFAULT_VALUE":"AL SAFA, DUBAI",
    //   "X":10,
    //   "Y":30,
    //   "FONT_SIZE":18,
    //   "ZOOM":1,
    //   "ALIGN":"C",
    // });
    // historyController.printData.add({
    //   "TITLE":"",
    //   "TYPE":"T",
    //   "KEY":"",
    //   "DEFAULT_VALUE":"UAE",
    //   "X":10,
    //   "Y":30,
    //   "ZOOM":1,
    //   "FONT_SIZE":18,
    //   "ALIGN":"C",
    //   "FEED":5
    // });
    // historyController.printData.add({
    //   "TYPE":"L",
    //   "FEED":5
    //
    // });
    // historyController. printData.add({
    //   "TITLE":"DATE",
    //   "TYPE":"T",
    //   "KEY":"DATE",
    //   "DEFAULT_VALUE":"",
    //   "X":20,
    //   "Y":30,
    //   "ZOOM":1,
    //   "ALIGN":"L",
    // });
    // historyController. printData.add({
    //   "TYPE":"L",
    //   "FEED":1
    // });
    // historyController. printData.add({
    //   "TITLE":"#",
    //   "TYPE":"T",
    //   "KEY":"CODE",
    //   "DEFAULT_VALUE":"",
    //   "X":60,
    //   "Y":30,
    //   "ZOOM":1,
    //   "ALIGN":"L",
    // });
    // historyController. printData.add({
    //   "TITLE":"",
    //   "TYPE":"T",
    //   "KEY":"",
    //   "DEFAULT_VALUE":"-----------------------------",
    //   "X":0,
    //   "Y":0,
    //   "ZOOM":1,
    //   "FONT_SIZE":20,
    //   "ALIGN":"C",
    // });
    //
    // historyController. printData.add({
    //   "TITLE":"DATE",
    //   "TYPE":"T",
    //   "KEY":"DATA",
    // });



    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build Running  ${historyController.fromto.value}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw(AppStrings.history,AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () => historyController.historyList.isNotEmpty?historyController.fnPrintSetup():null,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.appBgGreyshde),
          child: Padding(
            padding: const EdgeInsets.only(top: 17,right: 20,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithUnderLine(title: AppStrings.history,),
                gapHC(20),
                Obx(() =>     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonController.wstrRoleCode.value =="ADMIN" ? Container(
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
                        value: historyController.dropdownDeviceItemsValue.value.toString(),
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 13),

                        // Array list of items
                        items: historyController.deviceItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: tcnw(items, AppColors.fontcolor, 12,
                                TextAlign.center, FontWeight.w300),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          historyController.fnOnChnageDeviceItems(value,"","");
                        },
                      ),
                    ):SizedBox(),


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
                        value: historyController.dropdownvalue.value.toString(),
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),

                        // Array list of items
                        items: historyController.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: tcnw(items, AppColors.fontcolor, 12,TextAlign.center,FontWeight.w300),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          historyController.fnOnChnagedDay(value);
                        },
                        // onChanged: (String? newValue) {
                        //   // setState(() {
                        //   //   dropdownvalue = newValue!;
                        //   // });
                        // },
                      ),
                    ),
                  ],
                ),),
                gapHC(10),

                Obx(() =>historyController.fromto.value==true ? wFromTo():const SizedBox()),
                gapHC(10),
                Obx(() => historyController.choosedevice.value ? wChooseDeviceField()
                    : const SizedBox()),

                gapHC(8),


                Obx(() =>  Expanded(
                  child: historyController.historyList.isNotEmpty?  ListView.builder
                    (
                      itemCount: historyController.historyList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        var historyList =historyController.historyList[index];
                        var docdate= "";
                        try{
                          docdate =setDate(15, DateTime.parse(historyList.dOCDATE.toString()));
                        }catch(e){}
                        return   Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.lightfontcolor.withOpacity(0.30),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        tsw(historyList.tITLE.toString(), AppColors.fontcolor, 12,FontWeight.w600),
                                        gapHC(3),
                                        ts(historyList.dOCNO.toString(), AppColors.fontcolor, 12),
                                        gapHC(3),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time_rounded,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(docdate, AppColors.fontcolor, 12),
                                          ],
                                        ),

                                        gapHC(3),
                                        Row(
                                          children: [
                                            Icon(Icons.devices_sharp,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(historyList.deviceName??"", AppColors.fontcolor, 12),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.verified_user,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(historyList.cREATEUSER.toString().toUpperCase()??"", AppColors.fontcolor, 12),
                                          ],
                                        ),


                                        gapHC(8),
                                        Row(
                                          children: [
                                            Icon(Icons.person,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(historyList.sLDESC.toString().toUpperCase()??"", AppColors.fontcolor, 12),
                                          ],
                                        ),

                                        gapHC(3),
                                        Row(
                                          children: [
                                            Icon(Icons.credit_card_rounded,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(historyList.cARDNO.toString().toUpperCase()??"", AppColors.fontcolor, 12),
                                          ],
                                        ),

                                        gapHC(3),
                                        Row(
                                          children: [
                                            Icon(Icons.call,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(historyList.mOBILE.toString()??"", AppColors.fontcolor, 12),
                                          ],
                                        ),

                                        gapHC(3),


                                      ],

                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        historyList.dBCR.toString()=="C"?  SvgPicture.asset(
                                          AppAssets.downArrow,fit: BoxFit.fill,
                                          color: Colors.green,height: 17,width: 17,
                                        ):
                                        SvgPicture.asset(
                                          AppAssets.upArrow,
                                          color: Colors.red,height: 17,width: 17,
                                        ),
                                        historyList.dBCR.toString()=="C"?th(historyList.aMT.toString(), AppColors.fontcolor, 20):th("-${historyList.aMT.toString()}", AppColors.fontcolor, 20),
                                      ],
                                    )
                                  ],
                                ),
                              )
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
      ),
    );
  }

  ///////widget,,,,,,,,,,,
  Widget wChooseDeviceField() {
    dprint("choooosw");
    return SizedBox(
      height: 40,
      child: Padding(
        padding:         const EdgeInsets.symmetric(horizontal: 20,),
        child: GestureDetector(
          onTap: (){
            print("Loookupppppppppppppppppp...");
            historyController.fnDeviceLookup();
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
              controller: historyController.txtdeviceName,
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

  fnBlutoothConnect() async {
    List<BtDevice> devices = await historyController.flutterbluetoothconnector.getDevices();
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
        await historyController.bluetoothPrint.connect(_device!);
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

//==========================================================SUNMI INITSTATE &FUNCTIONS

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }
  void sunmiPrintInitState() {
    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind!;
      });
    });
  }
}


