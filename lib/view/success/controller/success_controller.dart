
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
//import 'package:flutter_pos_printer_platform/esc_pos_utils_platform/src/capability_profile.dart';
import 'package:flutter_pos_printer_platform/src/printer_manager.dart';
import 'package:flutter_pos_printer_platform/src/connectors/usb.dart';
import 'package:flutter_pos_printer_platform/src/connectors/bluetooth.dart';
import 'package:flutter_pos_printer_platform/src/connectors/tcp.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';

import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

import '../../../printerNewPackageForTest/homeScreen.dart';
import '../../imageUtils.dart';

import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';

class SuccessController extends GetxController{


  ApiRepository apiRepository = ApiRepository();
  late Future <dynamic> futureform;
  RxList printData  = [].obs;
  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  //BluetoothPrinter? selectedPrinter;
  final CommonController commonController = Get.put(CommonController());
  bool _connected = false;
  Rx<BluetoothDevice> _device=BluetoothDevice().obs;


  //============================ =========================================19/jul/23 VARIABLE
  Rx<BTStatus> currentStatus = BTStatus.none.obs;
  var defaultPrinterType = PrinterType.bluetooth.obs;
  var isBle = false.obs;
  var reconnect = false.obs;
  var isConnected = false.obs;
  var printerManager = PrinterManager.instance;
  var devices = [];
  StreamSubscription<PrinterDevice>? subscription;
  StreamSubscription<BTStatus>? subscriptionBtStatus;
  StreamSubscription<USBStatus>? subscriptionUsbStatus;
  // BTStatus currentStatus = BTStatus.none;
  List<int>? pendingTask;



  //============================ =========================================19/jul/23 END_____VARIABLE




  fnPrintSetup(printcode,amount,transactionid,cardnumber,slcode,sldesc,balance){
    dprint("token function");
    try{
      futureform =  apiRepository.apiGetPrintSetup(printcode);
      futureform.then((value) => fnPrintSetupes(value,amount,transactionid,cardnumber,slcode,sldesc,balance));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }
  fnPrintSetupes(val,amount,transactionid,cardnumber,slcode,sldesc,balance){
    dprint("0000.............");
    dprint(val);
    printData.value.clear();
    if(mfnCheckValue(val)) {
      printData.value = val;
      fnBlutoothConnect(amount,transactionid,cardnumber,slcode,sldesc,balance);
    }
  }



  fnBlutoothConnect(amount,transactionid,cardnumber,slcode,sldesc,balance) async {
    Future.delayed(
      Duration(seconds: 1),
          () {
        if (commonController.printYn.value == "Y") {
          //   fnPrint(amount,transactionid,cardnumber,slcode,sldesc,balance);
          //  fnsunmiPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance);
          fncommonPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance);

        }
      });
    // );

   // List<BtDevice> devices = await flutterbluetoothconnector.getDevices();


    // if (devices.isNotEmpty) {
    //   print("DEVICE ADDRESS>>ww>>>>>>>>> "+devices[0].address.toString());
    //   print("DEVICE NAME>>>>>>>>>>> "+devices[0].name.toString());
    //
    //
    //
    //   BluetoothDevice d = BluetoothDevice();
    //   d.address = devices[0].address;
    //   d.name = devices[0].name;
    //   _device.value = d;
    //   dprint("DEVICE>>>>>>>>>>>>>>>>>>>>SSS ${_device.value}");
    //
    //   if (_device.value.name != null && _device.value.address != null) {
    //     await bluetoothPrint.connect(_device.value);
    //     Future.delayed(
    //       Duration(seconds: 1),
    //           () {
    //         if (commonController.printYn.value == "Y") {
    //           //   fnPrint(amount,transactionid,cardnumber,slcode,sldesc,balance);
    //           //  fnsunmiPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance);
    //           fncommonPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance);
    //
    //         }
    //       },
    //     );
    //   }
    // }





    // commonController.wstrSunmiDevice.value=="Y"?fnsunmiPrintText(amount, transactionid, cardnumber, slcode, sldesc, balance)
    //     :fncommonPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance);

    //fnPrint(amount, transactionid, cardnumber, slcode, sldesc, balance);


  }

  fnPrint(amount,transactionid,cardnumber,slcode,sldesc,balance) async {
    dprint("Slcodeee in fnPrint ${slcode}");
    dprint("Sldesc in fnPrint ${sldesc}");
    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);

    Map<String, dynamic> config = Map();
    // config['gap'] = 2;
    List<LineText> list = [];

    for(var e in printData) {
      var type = e["TYPE"] ?? "";
      if (type == "L") {
        dprint("feedinSUCCES_SCREEN:>>>> ${ e}");
        list.add(LineText(linefeed: 1));
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      }
      else {
        var title = e["TITLE"] ?? "";
        var key = e["KEY"] ?? "";
        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";
        var weight = e["WEIGHT"] ?? 0;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value.toString().isEmpty && key.toString().isNotEmpty) {
          if (key == "DATE") {
            value = (title + " " + setDate(9, DateTime.now()));
          } else if (key == "CODE") {
            value = (title + " " + transactionid.toString().toUpperCase());
          }
          else if (key == "TIME") {
            value = (title + " " + setDate(11, DateTime.now()));
          }
          else if (key == "SLCODE") {
            value = (title + " " + slcode.toString().toUpperCase());
          }
          else if (key == "USER") {
            value = (title + " " + commonController.wstrUserName.value.toString().toUpperCase());
          }
          else if (key == "BALANCE") {
            value = (title + " " + (balance??"").toString());
          }
          else if (key == "SLDESCP") {
            value = (title + " " + sldesc.toString().toUpperCase());
          }
          else if (key == "AMT") {
            value = (title + " " +mfnDbl(amount).toString());
          }
          else if (key == "CARD") {
            // value = (title + "   xxx" + cardnumber.substring(3,8));
            value = (title + "  " + cardnumber.toString().toUpperCase());
          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {
            value = (title + " " + devid.toString().toUpperCase());
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString().toUpperCase());
          }
        }
        list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: value,
            relativeX: 1,
            fontZoom: e["ZOOM"]??1,
            weight: weight,
            size: fontsize,
            align: align == "L" ? LineText.ALIGN_LEFT : align == "C" ? LineText
                .ALIGN_CENTER : align == "R" ? LineText.ALIGN_RIGHT : LineText
                .ALIGN_LEFT,linefeed: e["FEED"]??0)
        );
      }
    }
    dprint("LIS>>>>>>>>>>>>>>>>>>>>>> ${list}");

    if(list.isNotEmpty){

      await bluetoothPrint.printReceipt(config, list);
    }

  }


//=======================================================================================================19/JUL/2023 ANAS
  disposePrintDatas(){
    subscription?.cancel();
    subscriptionBtStatus?.cancel();
    subscriptionUsbStatus?.cancel();

  }

  scan()async {
    print("START SCAN");
    devices.clear();
    subscription =await printerManager.discovery(type: defaultPrinterType.value, isBle: isBle.value).listen((device) {
      dprint(device);



      print("DEVICES>>>>> ${device.name}");
      print("address>>>>> ${device.address}");
      print("operatingSystem>>>>> ${device.operatingSystem}");

      devices.add(
          BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: isBle.value,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: defaultPrinterType.value,
      ));
      print("==================ffddd=========================${devices}");

    });


  }

  void printEscPos(List<int> bytes, Generator generator) async {
    var  selectedPrinter;
    try{
      if(commonController.wBluetoothPrinter.value.address!.isNotEmpty){
        selectedPrinter = commonController.wBluetoothPrinter.value;
        dprint("gLOBAL INTERTTT >>${commonController.wBluetoothPrinter.value.typePrinter}");
        dprint("gLOBAL INTER >>${selectedPrinter.typePrinter}");
      }else{
        selectedPrinter=devices[0];
        dprint("LOCAL INTER >>${selectedPrinter.typePrinter}");
      }

    }catch(e){
      dprint(e);
    }


    dprint("PRINT>>>FUNCTIONfffff...............................>>${selectedPrinter.deviceName}.");


    if (selectedPrinter == null) return;
    var bluetoothPrinter = selectedPrinter;


    dprint("PRINT>>>typePrinter........................>>${bluetoothPrinter.typePrinter}.");
    dprint("PRINT>>>deviceName........................>>${bluetoothPrinter.deviceName}.");
    dprint("PRINT>>>address........................>>${bluetoothPrinter.address}.");
    dprint("PRINT>>>isBle........................>>${bluetoothPrinter.isBle}.");

    switch (bluetoothPrinter.typePrinter) {
      case PrinterType.bluetooth:
        bytes += generator.cut(mode:PosCutMode.partial );
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: BluetoothPrinterInput(
                name: bluetoothPrinter.deviceName,
                address: bluetoothPrinter.address!,
                isBle: bluetoothPrinter.isBle ?? false,
                autoConnect: reconnect.value));
        pendingTask = null;
        if (Platform.isAndroid) pendingTask = bytes;
        break;
      default:
    }
    if (bluetoothPrinter.typePrinter == PrinterType.bluetooth && Platform.isAndroid) {
      // dprint("isConnected.value>>>> ${currentStatus}");


        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;


    } else {
      printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
      if (bluetoothPrinter.typePrinter == PrinterType.network) {
        printerManager.disconnect(type: bluetoothPrinter.typePrinter);
      }
    }
  }


  Future fncommonPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance) async {
    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);
    // dprint("NAME>>> ${slcode.toString()}");
    // dprint("amount>>> ${amount.toString()}");
    // dprint("transactionid>>> ${transactionid.toString()}");
    // dprint("cardnumber>>> ${cardnumber.toString()}");
    // dprint("balance>>> ${balance.toString()}");
    // dprint("devid>>> ${devid.toString()}");
    // dprint("devName>>> ${devName.toString()}");


    //  List<LineText> list = [];
    List<int> bytes = [];
    dprint("TAP________Print.................");




    // Xprinter XP-N160I
    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    // default profile
    // final profile = await CapabilityProfile.load();

    // PaperSize.mm80 or PaperSize.mm58
    final generator = await Generator(PaperSize.mm80, profile);


    for(var e in printData.value) {
      var type = e["TYPE"] ?? "";
      if (type == "L") {

        bytes +=await generator.feed(1);

      }
      else {
        var title = e["TITLE"] ?? "";
        var key = e["KEY"] ?? "";
        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";
        var weight = e["WEIGHT"] ?? 0;
        var zoom = e["ZOOM"] ?? 1;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value.toString().isEmpty && key.toString().isNotEmpty) {
          if (key == "DATE") {
            //  value = (title + " " + setDate(9, DateTime.now()));
            bytes += generator.text(title + ": " + setDate(9, DateTime.now()),);

          } else if (key == "CODE") {
            //  value = (title + " " + transactionid.toString().toUpperCase());
            bytes += generator.text(title + ": " + transactionid.toString().toUpperCase(),);
          }
          else if (key == "TIME") {
            //  value = (title + " " + setDate(11, DateTime.now()));
            bytes += generator.text(title + ": " + setDate(11, DateTime.now()),);
          }
          else if (key == "SLCODE") {
            //  value = (title + " " + slcode.toString().toUpperCase());
            bytes += generator.text(title + ": " + slcode.toString().toUpperCase(),);
          }
          else if (key == "USER") {
            // value = (title + " " + commonController.wstrUserName.value.toString().toUpperCase());
            bytes += generator.text(title + ": " + commonController.wstrUserName.value.toString().toUpperCase(),);
          }
          else if (key == "BALANCE") {
            // value = (title + " " + (balance??"").toString());
            bytes += generator.text(title + ": " + (balance??"").toString(),);
          }
          else if (key == "SLDESCP") {
            // value = (title + " " + sldesc.toString().toUpperCase());
            bytes += generator.text(title + ": " + sldesc.toString().toUpperCase(),);
          }
          else if (key == "AMT") {
            //  value = (title + " " +mfnDbl(amount).toString());
            bytes += generator.text(title + ": " + mfnDbl(amount).toString(),);
          }
          else if (key == "CARD") {

            // value = (title + "  " + cardnumber.toString().toUpperCase());
            bytes += generator.text(title + ": " + cardnumber.toString().toUpperCase(),);
          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {
            // value = (title + " " + devid.toString().toUpperCase());
            bytes += generator.text(title + ": " + devid.toString().toUpperCase(),);
          }
          else if (key == "DEVICENAME") {
            //value = (title + " " + devName.toString().toUpperCase());
            bytes += generator.text(title + ": " + devName.toString().toUpperCase());
          }
        }


        bytes += generator.text(value,
            styles: PosStyles(
              height: bytes.toString().isNotEmpty &&weight==1 && zoom==2?PosTextSize.size2:PosTextSize.size1,
              align: align == "L" ?PosAlign.left: align == "C" ?PosAlign.center: align == "R"?PosAlign.right:PosAlign.left,
            )
        );
        // list.add(LineText(
        //     type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
        //         .TYPE_IMAGE : LineText.TYPE_TEXT,
        //     content: value,
        //     relativeX: 1,
        //     fontZoom: e["ZOOM"]??1,
        //     weight: weight,
        //     size: fontsize,
        //     align: align == "L" ? LineText.ALIGN_LEFT : align == "C" ? LineText
        //         .ALIGN_CENTER : align == "R" ? LineText.ALIGN_RIGHT : LineText
        //         .ALIGN_LEFT,linefeed: e["FEED"]??0)

      }
    }
    printEscPos(bytes, generator);

    //
    // // bytes += generator.setGlobalCodeTable('CP1250');
    // bytes += generator.text('Amonut= ${amount.toString()}', styles: const PosStyles(align: PosAlign.left,));
    // bytes += generator.text('Transactionid= ${transactionid.toString()}');
    // // print accent
    // bytes += generator.text('${slcode.toString()}', styles: const PosStyles(align: PosAlign.left, codeTable: 'CP1252'));
    // // bytes += generator.emptyLines(1);
    //
    // // sum width total column must be 12
    // bytes += generator.row([
    //   PosColumn(width: 2, text: 'Amonut', styles: const PosStyles(align: PosAlign.left,underline: true,bold: true)),
    //   PosColumn(width: 2, text: 'transactionid', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
    //   PosColumn(width: 2, text: 'cardnumber', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
    //   PosColumn(width: 2, text: 'slcode', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
    //   PosColumn(width: 4, text: 'balance', styles: const PosStyles(align: PosAlign.right,underline: true,bold: true)),
    // ]);
    //
    // bytes += generator.row([
    //   PosColumn(width: 2, text: amount.toString(), styles: const PosStyles(align: PosAlign.left)),
    //   PosColumn(width: 2, text: transactionid.toString(), styles: const PosStyles(align: PosAlign.right)),
    //   PosColumn(width: 2, text:cardnumber.toString() , styles: const PosStyles(align: PosAlign.right)),
    //   PosColumn(width: 2, text:slcode.toString() , styles: const PosStyles(align: PosAlign.right)),
    //   PosColumn(width: 4, text:balance.toString()??"0" , styles: const PosStyles(align: PosAlign.right)),
    // ]);
    //
    // final ByteData data = await rootBundle.load('assets/images/tapplogo.png');
    // if (data.lengthInBytes > 0) {
    //   final Uint8List imageBytes = data.buffer.asUint8List();
    //   // decode the bytes into an image
    //   final decodedImage = img.decodeImage(imageBytes)!;
    //   // Create a black bottom layer
    //   // Resize the image to a 130x? thumbnail (maintaining the aspect ratio).
    //   img.Image thumbnail = img.copyResize(decodedImage, height: 130);
    //   // creates a copy of the original image with set dimensions
    //   img.Image originalImg = img.copyResize(decodedImage, width: 380, height: 130);
    //   // fills the original image with a white background
    //   // img.fill(originalImg, color: img.ColorRgb8(255, 255, 255));
    //   var padding = (originalImg.width - thumbnail.width) / 2;
    //
    //   //insert the image inside the frame and center it
    //   drawImage(originalImg, thumbnail, dstX: padding.toInt());
    //
    //   // convert image to grayscale
    //   var grayscaleImage = img.grayscale(originalImg);
    //
    //   // bytes += generator.feed(1);
    //   // // bytes += generator.imageRaster(img.decodeImage(imageBytes)!, align: PosAlign.center);
    //   // bytes += generator.imageRaster(grayscaleImage, align: PosAlign.center);
    //   // bytes += generator.feed(1);
    // }
    //
    // // PosCodeTable.westEur or CP1252
    // // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: const PosStyles(codeTable: 'CP1252'));
    // // bytes += generator.text('Special 2: blåbærgrød', styles: const PosStyles(codeTable: 'CP1252'));
    //
    // // var esc = '\x1B';
    // // to support arabic must to know code page and the correct encode for example in some printers the code page is 22: arabic code page printer
    // // bytes += Uint8List.fromList(List.from('${esc}t'.codeUnits)..add(22));
    // // bytes += generator.textEncoded(Uint8List.fromList(utf8.encode('مرحبا بك')));
    //
    // // Chinese characters
    // // bytes += generator.row([
    // //   PosColumn(width: 8, text: '豚肉・木耳と玉子炒め弁当', styles: const PosStyles(align: PosAlign.left), containsChinese: true),
    // //   PosColumn(width: 4, text: '￥1,990', styles: const PosStyles(align: PosAlign.right), containsChinese: true),
    // // ]);
    //
    // printEscPos(bytes, generator);
  }


  //=============================================================SUNMIPRINTER


  Future fnsunmiPrintText(amount,transactionid,cardnumber,slcode,sldesc,balance) async {

    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);
    dprint("NAME>>> ${slcode.toString()}");
    dprint("amount>>> ${amount.toString()}");
    dprint("transactionid>>> ${transactionid.toString()}");
    dprint("cardnumber>>> ${cardnumber.toString()}");
    dprint("balance>>> ${balance.toString()}");
    dprint("devid>>> ${devid.toString()}");
    dprint("devName>>> ${devName.toString()}");
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);

    List list = [];
    dprint("printData:>>>> ${ printData}");
    dprint("printData:length>>>> ${ printData.length}");
    for(var e in printData.value) {

      dprint("feed:>>>> ${e}");
      var type = e["TYPE"] ?? "";
      if (type == "L") {
        await SunmiPrinter.lineWrap(1);
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      }
      else {
        var title = e["TITLE"] ?? "";
        var key = e["KEY"] ?? "";
        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";
        var weight = e["WEIGHT"] ?? 0;
        var zoom = e["ZOOM"] ?? 1;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value.toString().isEmpty && key.toString().isNotEmpty) {
          if (key == "DATE") {
            value = (title + ": " + setDate(9, DateTime.now()));
          } else if (key == "CODE") {
            value = (title + ": " + transactionid.toString().toUpperCase());
          }
          else if (key == "TIME") {
            value = (title + ": " + setDate(11, DateTime.now()));
          }
          else if (key == "SLCODE") {
            value = (title + ": " + slcode.toString().toUpperCase());

          }
          else if (key == "USER") {
            value = (title + ": " + commonController.wstrUserName.value.toString().toUpperCase());

          }
          else if (key == "BALANCE") {
            value = (title + ": " + (balance??"").toString());

          }
          else if (key == "SLDESCP") {
            value = (title + ": " + sldesc.toString().toUpperCase());

          }
          else if (key == "AMT") {
            value = (title + ": " +mfnDbl(amount).toString());

          }
          else if (key == "CARD") {
            // value = (title + "   xxx" + cardnumber.substring(3,8));
            value = (title + ": " + cardnumber.toString().toUpperCase());

          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {
            value = (title + ": " + devid.toString().toUpperCase());

          }
          else if (key == "DEVICENAME") {
            value = (title + ": " + devName.toString().toUpperCase());

          }
        }
        else if(value.toString().isNotEmpty && key.toString().isEmpty){
          value = (value.toString());
        }


        dprint("ALIGN>>>> ${align}");
        dprint("VALUE>>>> ${value}");


        await SunmiPrinter.printText(
          value,
          style:SunmiStyle(
            fontSize: value.toString().isNotEmpty &&weight==1 && zoom==2?SunmiFontSize.XL:SunmiFontSize.MD,
            align: align == "L" ? SunmiPrintAlign.LEFT : align == "C" ? SunmiPrintAlign.CENTER: align == "R" ? SunmiPrintAlign.RIGHT :SunmiPrintAlign.LEFT,
            // bold: value.toString().isNotEmpty && weight==1?true:false
          ),
        );

      }
    }

    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);


  }

}





class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter(
      {this.deviceName,
        this.address,
        this.port,
        this.state,
        this.vendorId,
        this.productId,
        this.typePrinter = PrinterType.bluetooth,
        this.isBle = false});
}