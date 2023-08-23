import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/settings/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';

import '../../../storage/preference.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingsController settingsController = Get.put(SettingsController());
  final CommonController commonController = Get.put(CommonController());

  //=================================================04/Aug/2023 START variable
  var devices = <BluetoothPrinter>[];
  var defaultPrinterType = PrinterType.bluetooth;
  var _isBle = false;
  var _reconnect = false;
  var _isConnected = false;
  var printerManager = PrinterManager.instance;
  StreamSubscription<PrinterDevice>? subscription;
  StreamSubscription<BTStatus>? subscriptionBtStatus;
  StreamSubscription<USBStatus>? subscriptionUsbStatus;
  List<int>? pendingTask;
  BluetoothPrinter? selectedPrinter;
  BTStatus currentStatus = BTStatus.none;
  //=================================================04/Aug/2023 END  variable

  @override
  void dispose() {
    subscription?.cancel();
    subscriptionBtStatus?.cancel();
    subscriptionUsbStatus?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    settingsController.fngetpagedata();
    // TODO: implement initState
    super.initState();
    //==============================================================04/Aug/2023
    scan();

    // subscription to listen change status of bluetooth connection
    subscriptionBtStatus = PrinterManager.instance.stateBluetooth.listen((status) {
      dprint(' ----------------- status bt $status ------------------ ');
      currentStatus = status;
      if (status == BTStatus.connected) {
        setState(() {
          _isConnected = true;
        });
      }
      if (status == BTStatus.none) {
        setState(() {
          _isConnected = false;
        });
      }
      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance.send(type: PrinterType.bluetooth, bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance.send(type: PrinterType.bluetooth, bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw("Settings",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const TitleWithUnderLine(title: "Settings",),
                gapHC(20),
                tsw("Printer",AppColors.fontcolor,14,FontWeight.w500),
                gapHC(10),
                Material(
                  elevation: 30,
                  borderRadius: BorderRadius.circular(8) ,
                  shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
                  child: TextFormField(
                    showCursor:false,
                    keyboardType: TextInputType.none,
                    controller: settingsController.txtPrinter,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: "Printer",
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                        filled: true,

                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        suffixIcon: Icon(Icons.search,color: AppColors.fontcolor,)
                    ),
                    onTap: (){
                      print("object");
                      settingsController.fnGetPrinters();
                      wShowDialog(context);

                    },

                  ),
                ),
                gapHC(20),
                tsw("System Printer",AppColors.fontcolor,14,FontWeight.w500),
                gapHC(10),
                Material(
                  elevation: 30,
                  borderRadius: BorderRadius.circular(8) ,
                  shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
                  child: TextFormField(
                    enableInteractiveSelection: false,
                    showCursor:false,
                    keyboardType: TextInputType.none,
                    controller: settingsController.txtSystemPrinter,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: "System Printer",
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                        filled: true,

                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        suffixIcon: Icon(Icons.search,color: AppColors.fontcolor,)
                    ),
                    onTap: (){
                      print("object");
                      // fnGetSystemPrinters();
                      wShowSystemPrinterDialog(context);

                    },

                  ),
                )





              ],
            ),
          ),
        ),
      ),
    );
  }

  wShowDialog(context){
    Size size = MediaQuery.of(context).size;

    showDialog(context: context, builder: (_) {
      return Obx(() => AlertDialog(
        title: Text("Choose a printer"),
        content: SizedBox(
          width: double.maxFinite,
          height: size.height/2,
          child: ListView.builder(
            itemCount: settingsController.printerList.length,
            itemBuilder: (_, i) {
              return  RadioListTile(
                activeColor: AppColors.primarycolor,
                contentPadding: EdgeInsets.zero,
                value:settingsController.printerList[i],
                groupValue: settingsController.txtPrinter.text,
                dense: true,
                onChanged: (value){
                  settingsController.txtPrinter.text = value["NAME"];
                  settingsController.fnSavePrinterdatas(value["PATH"],value["NAME"],value["CODE"]);
                  print("Printerrrr value>>>> ${settingsController.txtPrinter.text}");
                  Get.back();
                },

                title: Text(settingsController.printerList[i]["NAME"].toString()),
              );
            },
          ),
        ),
      ));
    });

  }

  wShowSystemPrinterDialog(context){
    Size size = MediaQuery.of(context).size;

    showDialog(context: context, builder: (_) {
      return  AlertDialog(
        title: const Text("Choose a system Printer"),
        content: SizedBox(
          width: double.maxFinite,
          height: size.height/2,
          child:SingleChildScrollView(
            child: Column(
                children: devices
                    .map(
                      (device) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: ListTile(
                          dense:true,minVerticalPadding: 10,
                          contentPadding: EdgeInsets.only(left: 3.0),
                          visualDensity: VisualDensity(horizontal: -3, vertical: -2),
                          shape: RoundedRectangleBorder(
                            side:new  BorderSide(color: Color(0xFF2A8068)),
                            borderRadius: new BorderRadius.all(new Radius.circular(4)),),
                          title: Text('${device.deviceName}'),
                          subtitle: Text("${device.address}"),
                          onTap: () {
                            // do something
                            selectDevice(device);
                            Get.back();
                          },

                        ),
                      ),


                )
                    .toList()),
          )
        ),
      );
    });

  }

  //=================================================04/Aug/2023 START function
  void scan() {
    devices.clear();
    subscription = printerManager.discovery(type: defaultPrinterType, isBle: _isBle).listen((device) {
      dprint("List of Devicess>>>> ${device}");
      devices.add(BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: _isBle,
        typePrinter: defaultPrinterType,
      ));
      setState(() {});
    });
  }
  void selectDevice(BluetoothPrinter device) async {
    //Save printer_data to Session and Global
    dprint("1231231231321");
    dprint(device.deviceName);
    dprint(device.address);
    dprint(device.isBle);
    dprint(device.typePrinter);
    settingsController.txtSystemPrinter.text=device.deviceName.toString();
    Prefs.setString(AppStrings.select_bt_device, json.encode(device));
    dprint("33333333333333");
    commonController.wBluetoothPrinter.value = device;


    // if (selectedPrinter != null) {
    //   if (device.address != selectedPrinter!.address) {
    //     await PrinterManager.instance.disconnect(type: selectedPrinter.typePrinter);
    //   }
    // }
    //
    // selectedPrinter = device;
    setState(() {});

  }

 //=================================================04/Aug/2023 END  function







}
//=================================================04/Aug/2023
class BluetoothPrinter {
  String? deviceName;
  String? address;
  bool? isBle;
  PrinterType? typePrinter;

  BluetoothPrinter(
      {this.deviceName,
        this.address,
        this.typePrinter,
        this.isBle});

  BluetoothPrinter.fromJson(Map<String, dynamic> json):
        deviceName = json['devName'],
        address = json['devAddress'],
        typePrinter=PrinterType.bluetooth,
        isBle=false;

  Map<String, dynamic> toJson() => {
    'devName': deviceName,
    'devAddress': address,

  };


}