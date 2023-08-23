import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';

import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/printerNewPackageForTest/homeScreen.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/success/controller/success_controller.dart';

import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';

// import 'package:bluetooth_print/bluetooth_print_model.dart';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../storage/preference.dart';
import '../../imageUtils.dart';


class SuccessScreen extends StatefulWidget {
  final dynamic amount;
  final dynamic transaction_id;
  final dynamic card_id;
  final dynamic date;
  final dynamic printCode;
  final dynamic slcode;
  final dynamic sldesc;
  final dynamic balance;

  const SuccessScreen(
      {Key? key,
        required this.amount,
        required this.transaction_id,
        required this.card_id,
        required this.date, required this.printCode, required this.slcode, required this.sldesc, this.balance})
      : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  final CommonController commonController = Get.put(CommonController());
  final SuccessController successController = Get.put(SuccessController());



  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  //------------------------------------------------------------------------------Aug/1/2023
  bool connected = false;
  List availableBluetoothDevices = [];
  // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  // BluetoothDevice? _device;
  bool _connected = false;
  // List<BluetoothDevice> _devices = [];
  @override
  void dispose() {
    successController.disposePrintDatas();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    dprint("**** ${widget.amount.toString()}");
    dprint("addressaddressaddressaddress${commonController.wBluetoothPrinter.value.deviceName}");
    if(commonController.wBluetoothPrinter.value.deviceName!.isEmpty){
      successController.scan();
      posPrinterPlatformIntState();
    }







    // if(commonController.wstrSunmiDevice.value=="Y"){
    //   sunmiPrintInitState();
    // }






    //===========================================================================================END

    Future.delayed(Duration(seconds: 1),(){
      dprint("API CALLED==============================================");
      successController.fnPrintSetup(widget.printCode,widget.amount, widget.transaction_id, widget.card_id,widget.slcode,widget.sldesc,widget.balance);
    });



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
  posPrinterPlatformIntState(){
    dprint("SCAN*******************");
    successController.subscriptionBtStatus = PrinterManager.instance.stateBluetooth.listen((status) {
      dprint(' ----------------- status bt $status ------------------ ');
      successController.currentStatus.value = status;
      if (status == BTStatus.connected) {
        successController.isConnected.value = true;
        dprint("CONNECTED.....>>> ${ successController.isConnected.value}");
        setState(() {});
      }
      if (status == BTStatus.none) {
        successController.isConnected.value = false;
        dprint("CONNECTED.....>>> ${ successController.isConnected.value}");
        setState(() {});
      }
      if (successController.isConnected.value) {
        if (Platform.isAndroid) {

          Future.delayed(const Duration(milliseconds: 1000,), () {
            PrinterManager.instance.send(type: PrinterType.bluetooth, bytes: successController.pendingTask!);
            successController.pendingTask = null;
          });

        } else if (Platform.isIOS) {
          PrinterManager.instance.send(type: PrinterType.bluetooth, bytes: successController.pendingTask!);
          successController.pendingTask = null;
        }
      }
    });
  }
  // Future<void> initPlatformState() async {
  //
  //   bool? isConnected = await bluetooth.isConnected;
  //   List<BluetoothDevice> devices = [];
  //   try {
  //     devices = await bluetooth.getBondedDevices();
  //   } on PlatformException {}
  //
  //   bluetooth.onStateChanged().listen((state) {
  //     switch (state) {
  //       case BlueThermalPrinter.CONNECTED:
  //         setState(() {
  //           _connected = true;
  //           print("bluetooth device state: connected");
  //         });
  //         break;
  //       case BlueThermalPrinter.DISCONNECTED:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: disconnected");
  //         });
  //         break;
  //       case BlueThermalPrinter.DISCONNECT_REQUESTED:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: disconnect requested");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_TURNING_OFF:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth turning off");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_OFF:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth off");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_ON:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth on");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_TURNING_ON:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth turning on");
  //         });
  //         break;
  //       case BlueThermalPrinter.ERROR:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: error");
  //         });
  //         break;
  //       default:
  //         print(state);
  //         break;
  //     }
  //   });
  //
  //   if (!mounted) return;
  //   setState(() {
  //     _devices = devices;
  //   });
  //
  //   if (isConnected == true) {
  //     setState(() {
  //       _connected = true;
  //     });
  //   }
  //
  //   dprint("DEVICES.... ${_devices}");
  //   dprint("Conneted.... ${_connected}");
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Bounce(
                duration: Duration(milliseconds: 110),
                onPressed: () {
                  Get.back();
                },
                child: Container(
                    padding: EdgeInsets.only(top: 10,right: 10),
                    alignment: Alignment.topRight,
                    child: Icon(Icons.close)),
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imageSet(AppAssets.success, 100.3),
                      tcnw("Success", AppColors.primarycolor, 32, TextAlign.center,
                          FontWeight.w700),
                      tsw("Payment done Successfully ", AppColors.lightfontcolor,
                          16, FontWeight.w300),
                      gapHC(10),
                      th("${widget.amount.toString()} AED", AppColors.fontcolor, 28),
                      tsw(widget.card_id.toString().toUpperCase(), AppColors.lightfontcolor, 16,
                          FontWeight.w400),
                      tsw(widget.date, AppColors.lightfontcolor, 16,
                          FontWeight.w400),
                      gapHC(10),
                      tsw("Transaction ID", AppColors.lightfontcolor, 16,
                          FontWeight.w400),
                      tsw(widget.transaction_id, AppColors.lightfontcolor, 16,
                          FontWeight.w400),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CommonButton(
                  buttoncolor: AppColors.primarycolor,
                  buttonText: "Print",
                  onpressed: () async {

                //   successController.fnPrint(widget.amount, widget.transaction_id, widget.card_id,widget.slcode,widget.sldesc,widget.balance);
                 successController.fncommonPrintText(widget.amount, widget.transaction_id, widget.card_id,widget.slcode,widget.sldesc,widget.balance);
                  //   successController.fnsunmiPrintText(widget.amount, widget.transaction_id, widget.card_id,widget.slcode,widget.sldesc,widget.balance);
                  },
                  icon: Icons.print,
                  icon_need: true,
                ),
              ),
              gapHC(10)
            ],
          ),
        ));
  }




//=====================================================================19/jul/2023

// void scan() {
//
//    devices.clear();
//   _subscription = printerManager.discovery(type: defaultPrinterType, isBle: _isBle).listen((device) {
//     dprint(device);
//
//
//
//     print("DEVICES>>>>> ${device.name}");
//     print("address>>>>> ${device.address}");
//     print("operatingSystem>>>>> ${device.operatingSystem}");
//     print("productId>>>>> ${device.productId}");
//     print("vendorId>>>>> ${device.vendorId}");
//     print("DEVICESssssssssss>>>>> ${devices}");
//
//     setState(() {
//       devices.add(BluetoothPrinter(
//         deviceName: device.name,
//         address: device.address,
//         isBle: _isBle,
//         vendorId: device.vendorId,
//         productId: device.productId,
//         typePrinter: defaultPrinterType,
//       ));
//
//     });
//   });
//   print("===========================================${devices}");
//
// }
//
// void printEscPos(List<int> bytes, Generator generator) async {
//   dprint(devices);
//   var select =devices[0];
//   dprint("PRINT>>>FUNCTION...............................${select}.");
//   selectedPrinter=select;
//   var connectedTCP = false;
//   if (selectedPrinter == null) return;
//   var bluetoothPrinter = selectedPrinter!;
//
//   dprint("printType>>>>>>>>>>>>>>> ${bluetoothPrinter.typePrinter}");
//
//   switch (bluetoothPrinter.typePrinter) {
//     // case PrinterType.usb:
//     //   bytes += generator.feed(2);
//     //   bytes += generator.cut();
//     //   await printerManager.connect(
//     //       type: bluetoothPrinter.typePrinter,
//     //       model: UsbPrinterInput(name: bluetoothPrinter.deviceName, productId: bluetoothPrinter.productId, vendorId: bluetoothPrinter.vendorId));
//     //   pendingTask = null;
//     //   break;
//     case PrinterType.bluetooth:
//       bytes += generator.cut(mode:PosCutMode.partial );
//       dprint("deviceName>>>>  ${bluetoothPrinter.deviceName}");
//       dprint("address>>>dd  ${bluetoothPrinter.address}");
//       dprint("isBle>>>>  ${bluetoothPrinter.isBle}");
//       dprint("_reconnect>>>>  ${_reconnect}");
//       await printerManager.connect(
//           type: bluetoothPrinter.typePrinter,
//           model: BluetoothPrinterInput(
//               name: bluetoothPrinter.deviceName,
//               address: bluetoothPrinter.address!,
//               isBle: bluetoothPrinter.isBle ?? false,
//               autoConnect: _reconnect));
//       pendingTask = null;
//       if (Platform.isAndroid) pendingTask = bytes;
//       break;
//     // case PrinterType.network:
//     //   bytes += generator.feed(2);
//     //   bytes += generator.cut();
//     //   connectedTCP = await printerManager.connect(type: bluetoothPrinter.typePrinter, model: TcpPrinterInput(ipAddress: bluetoothPrinter.address!));
//     //   if (!connectedTCP) debugPrint(' --- please review your connection ---');
//     //   break;
//     default:
//   }
//   if (bluetoothPrinter.typePrinter == PrinterType.bluetooth && Platform.isAndroid) {
//     if (_currentStatus == BTStatus.connected) {
//       printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
//       pendingTask = null;
//     }
//   } else {
//     printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
//     if (bluetoothPrinter.typePrinter == PrinterType.network) {
//       printerManager.disconnect(type: bluetoothPrinter.typePrinter);
//     }
//   }
// }
//
//
// Future fncommonPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance) async {
//   var devid = await  Prefs.getString(AppStrings.deviceId);
//   var devName = await  Prefs.getString(AppStrings.phonmodel);
//   dprint("NAME>>> ${slcode.toString()}");
//   dprint("amount>>> ${amount.toString()}");
//   dprint("transactionid>>> ${transactionid.toString()}");
//   dprint("cardnumber>>> ${cardnumber.toString()}");
//   dprint("balance>>> ${balance.toString()}");
//   dprint("devid>>> ${devid.toString()}");
//   dprint("devName>>> ${devName.toString()}");
//
//
//   List<LineText> list = [];
//   List<int> bytes = [];
//   dprint("TAP________Print.................");
//
//
//
//
//   // Xprinter XP-N160I
//   final profile = await CapabilityProfile.load(name: 'XP-N160I');
//   // default profile
//   // final profile = await CapabilityProfile.load();
//
//   // PaperSize.mm80 or PaperSize.mm58
//   final generator = Generator(PaperSize.mm58, profile);
//
//
//   for(var e in successController.printData.value) {
//     var type = e["TYPE"] ?? "";
//     if (type == "L") {
//       dprint("feed:>>>> ${ e}");
//       // list.add(LineText(linefeed: 1));
//       bytes += generator.feed(1);
//
//     }
//     else {
//       var title = e["TITLE"] ?? "";
//       var key = e["KEY"] ?? "";
//       var align = e["ALIGN"] ?? "";
//       var value = e["DEFAULT_VALUE"] ?? "";
//       var weight = e["WEIGHT"] ?? 0;
//       var fontsize = e["FONT_SIZE"] ?? 15;
//       if (value.toString().isEmpty && key.toString().isNotEmpty) {
//         if (key == "DATE") {
//           value = (title + " " + setDate(9, DateTime.now()));
//           //bytes += generator.text(title + " " + setDate(9, DateTime.now()),styles: PosStyles(fontType:PosFontType.fontA,height: PosTextSize.size2));
//
//         } else if (key == "CODE") {
//           value = (title + " " + transactionid.toString().toUpperCase());
//          // bytes += generator.text(title + " " + transactionid.toString().toUpperCase(),styles:  PosStyles(fontType:PosFontType.fontA,height: PosTextSize.size2));
//         }
//         else if (key == "TIME") {
//           value = (title + " " + setDate(11, DateTime.now()));
//           //bytes += generator.text(title + " " + setDate(11, DateTime.now()),styles: PosStyles(fontType:PosFontType.fontA,height: PosTextSize.size2));
//         }
//         else if (key == "SLCODE") {
//          value = (title + " " + slcode.toString().toUpperCase());
//          // bytes += generator.text(title + " " + slcode.toString().toUpperCase());
//         }
//         else if (key == "USER") {
//           value = (title + " " + commonController.wstrUserName.value.toString().toUpperCase());
//          // bytes += generator.text(title + " " + commonController.wstrUserName.value.toString().toUpperCase());
//         }
//         else if (key == "BALANCE") {
//          value = (title + " " + (balance??"").toString());
//           //bytes += generator.text(title + " " + (balance??"").toString());
//         }
//         else if (key == "SLDESCP") {
//           value = (title + " " + sldesc.toString().toUpperCase());
//           //bytes += generator.text(title + " " + sldesc.toString().toUpperCase());
//         }
//         else if (key == "AMT") {
//           value = (title + " " +mfnDbl(amount).toString());
//          // bytes += generator.text(title + " " + mfnDbl(amount).toString());
//         }
//         else if (key == "CARD") {
//
//           value = (title + "  " + cardnumber.toString().toUpperCase());
//          // bytes += generator.text(title + " " + cardnumber.toString().toUpperCase());
//         }
//         /////FROM SHAREDPREFERNCE
//         else if (key == "DEVICEID") {
//           value = (title + " " + devid.toString().toUpperCase());
//          // bytes += generator.text(title + " " + devid.toString().toUpperCase());
//         }
//         else if (key == "DEVICENAME") {
//           value = (title + " " + devName.toString().toUpperCase());
//           //bytes += generator.text(title + " " + devName.toString().toUpperCase());
//         }
//       }
//
//
//       bytes += generator.text(value, styles: PosStyles(fontType:PosFontType.fontA,height: PosTextSize.size1,align: align == "L" ?PosAlign.left: align == "C" ?PosAlign.center: align == "R"?PosAlign.right:PosAlign.left ));
//       // list.add(LineText(
//       //     type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
//       //         .TYPE_IMAGE : LineText.TYPE_TEXT,
//       //     content: value,
//       //     relativeX: 1,
//       //     fontZoom: e["ZOOM"]??1,
//       //     weight: weight,
//       //     size: fontsize,
//       //     align: align == "L" ? LineText.ALIGN_LEFT : align == "C" ? LineText
//       //         .ALIGN_CENTER : align == "R" ? LineText.ALIGN_RIGHT : LineText
//       //         .ALIGN_LEFT,linefeed: e["FEED"]??0)
//
//     }
//   }
//   printEscPos(bytes, generator);
//
//
//
//
//
//
//
//
//
//
//
//
//   //
//   // // bytes += generator.setGlobalCodeTable('CP1250');
//   // bytes += generator.text('Amonut= ${amount.toString()}', styles: const PosStyles(align: PosAlign.left,));
//   // bytes += generator.text('Transactionid= ${transactionid.toString()}');
//   // // print accent
//   // bytes += generator.text('${slcode.toString()}', styles: const PosStyles(align: PosAlign.left, codeTable: 'CP1252'));
//   // // bytes += generator.emptyLines(1);
//   //
//   // // sum width total column must be 12
//   // bytes += generator.row([
//   //   PosColumn(width: 2, text: 'Amonut', styles: const PosStyles(align: PosAlign.left,underline: true,bold: true)),
//   //   PosColumn(width: 2, text: 'transactionid', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
//   //   PosColumn(width: 2, text: 'cardnumber', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
//   //   PosColumn(width: 2, text: 'slcode', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
//   //   PosColumn(width: 4, text: 'balance', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
//   // ]);
//   //
//   // bytes += generator.row([
//   //   PosColumn(width: 2, text: amount.toString(), styles: const PosStyles(align: PosAlign.left)),
//   //   PosColumn(width: 2, text: transactionid.toString(), styles: const PosStyles(align: PosAlign.right)),
//   //   PosColumn(width: 2, text:cardnumber.toString() , styles: const PosStyles(align: PosAlign.right)),
//   //   PosColumn(width: 2, text:slcode.toString() , styles: const PosStyles(align: PosAlign.right)),
//   //   PosColumn(width: 4, text:balance.toString()??"0" , styles: const PosStyles(align: PosAlign.right)),
//   // ]);
//   //
//   // final ByteData data = await rootBundle.load('assets/images/tapplogo.png');
//   // if (data.lengthInBytes > 0) {
//   //   final Uint8List imageBytes = data.buffer.asUint8List();
//   //   // decode the bytes into an image
//   //   final decodedImage = img.decodeImage(imageBytes)!;
//   //   // Create a black bottom layer
//   //   // Resize the image to a 130x? thumbnail (maintaining the aspect ratio).
//   //   img.Image thumbnail = img.copyResize(decodedImage, height: 130);
//   //   // creates a copy of the original image with set dimensions
//   //   img.Image originalImg = img.copyResize(decodedImage, width: 380, height: 130);
//   //   // fills the original image with a white background
//   //   // img.fill(originalImg, color: img.ColorRgb8(255, 255, 255));
//   //   var padding = (originalImg.width - thumbnail.width) / 2;
//   //
//   //   //insert the image inside the frame and center it
//   //   drawImage(originalImg, thumbnail, dstX: padding.toInt());
//   //
//   //   // convert image to grayscale
//   //   var grayscaleImage = img.grayscale(originalImg);
//   //
//   //   // bytes += generator.feed(1);
//   //   // // bytes += generator.imageRaster(img.decodeImage(imageBytes)!, align: PosAlign.center);
//   //   // bytes += generator.imageRaster(grayscaleImage, align: PosAlign.center);
//   //   // bytes += generator.feed(1);
//   // }
//   //
//   // // PosCodeTable.westEur or CP1252
//   // // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: const PosStyles(codeTable: 'CP1252'));
//   // // bytes += generator.text('Special 2: blåbærgrød', styles: const PosStyles(codeTable: 'CP1252'));
//   //
//   // // var esc = '\x1B';
//   // // to support arabic must to know code page and the correct encode for example in some printers the code page is 22: arabic code page printer
//   // // bytes += Uint8List.fromList(List.from('${esc}t'.codeUnits)..add(22));
//   // // bytes += generator.textEncoded(Uint8List.fromList(utf8.encode('مرحبا بك')));
//   //
//   // // Chinese characters
//   // // bytes += generator.row([
//   // //   PosColumn(width: 8, text: '豚肉・木耳と玉子炒め弁当', styles: const PosStyles(align: PosAlign.left), containsChinese: true),
//   // //   PosColumn(width: 4, text: '￥1,990', styles: const PosStyles(align: PosAlign.right), containsChinese: true),
//   // // ]);
//   //
//   // printEscPos(bytes, generator);
// }


}
