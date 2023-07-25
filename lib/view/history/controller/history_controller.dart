import 'package:beams_tapp/common_widgets/lookup_search.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/filterMode.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/historyModel.dart';
import 'package:beams_tapp/notification/notification.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class HistoryController extends GetxController{


  ApiRepository apiRepository =ApiRepository();
  String iconCode = 'f33d';
  // Initial Selected Value
  RxString dropdownvalue = 'Today'.obs;
  dynamic filmode;
  // RxBool fromtoOpen=false.obs;
  // var fromDate;
  // var toDate;
  TextEditingController txtdeviceName = TextEditingController();
  Rx<DateTime> fromcurrentDate = DateTime.now().obs;
  Rx<DateTime> tocurrentDate = DateTime.now().obs;
  RxList historyList = [].obs;
  RxList printData  = [].obs;
  RxString device_id=''.obs;
  RxString adminuser=''.obs;
  RxString reportMode='D'.obs;
  var from = "".obs;
  var to = "".obs;
  final CommonController commonController = Get.put(CommonController());
  bool _connected = false;
  Rx<BluetoothDevice> _device=BluetoothDevice().obs;
  // List of items in our dropdown menu
  var items = [
    'This Month',
    'Today',
    'Yesterday',
    'From - To',
  ];
  var deviceItems = [
    'All',
    'This Device',
    'Choose a Device',
  ];
  RxString dropdownDeviceItemsValue = 'This Device'.obs;
  RxBool choosedevice = false.obs;
  RxBool fromto = false.obs;
  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  late Future <dynamic> futureform;
  void fnChangeItemDevice() {
    choosedevice.toggle();
  }



  void fnChangeStatus() {
    fromto.toggle();
  }

  fnOnChnagedDay(val){
    dropdownvalue.value = val;
    dprint("Dropdownvall ${dropdownvalue.value}");
    if(dropdownvalue.value == "From - To"){
      fromto.value = true;

    }else{
      fromto.value = false;
    }

fnGetHistory(dropdownvalue.value);
  }

  fnOnChnageDeviceItems(val,page,reportmode){
    dropdownDeviceItemsValue.value = val;
    dprint("Dropdownvall ${dropdownDeviceItemsValue.value}");
    if(dropdownDeviceItemsValue.value == "Choose a Device"){
      reportMode.value = "";
      choosedevice.value = true;

    }else if(dropdownDeviceItemsValue.value == "This Device"){
      reportMode.value = "D";
      choosedevice.value = false;
    } else{
      reportMode.value = "All";
      choosedevice.value = false;


    }

    dprint("Choosedevice..... ${choosedevice.value}");
    dprint("page..fdf... ${page}");
    dprint("Call apii for ${dropdownDeviceItemsValue.value}");

    fnGetHistory(dropdownvalue.value);


  }



  fnHistory(from,to)async{

    if(commonController.wstrRoleCode.value=="ADMIN"){
      adminuser.value = "Y";
      update();
    }else{
      adminuser.value = "N";
      update();
    }


    try{
        var devid = await  Prefs.getString(AppStrings.deviceId);

        if(dropdownDeviceItemsValue.value == "Choose a Device"){
          device_id.value =device_id.value;
        }else if(dropdownDeviceItemsValue.value == "This Device"){
          device_id.value = devid!;
        } else{
          device_id.value = devid!;

        }

        final responseJson = await apiRepository.apiHistory(devid,from,to,adminuser.value,reportMode.value, device_id.value);
        HistoryModel historyModel = HistoryModel.fromJson(responseJson);
        historyList.value = historyModel.hISTORY!;


      }catch(e){
        dprint(e);
      }


  }
  // var from = "";
  // var to = "";
  fnGetHistory(lstrFilterMode){
    var now = DateTime.now();
    if (lstrFilterMode == "Today") {
      from.value = setDate(2, now);
      to.value = setDate(2, now);


    } else if (lstrFilterMode == "Yesterday") {

      from.value = setDate(2, now.subtract(Duration(days: 1)));
      to.value = setDate(2, now.subtract(Duration(days: 1)));

    } else if (lstrFilterMode == "This Month") {
      from.value = setDate(2, DateTime(now.year, now.month, 1));
      to.value = setDate(2, DateTime(now.year, now.month + 1, 0));

    }else if (lstrFilterMode == "From - To") {

      from.value = setDate(2, fromcurrentDate.value);
      to.value = setDate(2, tocurrentDate.value);
    }

    fnHistory(from.value,to.value);
  }



  fnPrintSetup(){
    try{
      futureform =  apiRepository.apiGetPrintSetup("HIS");
      futureform.then((value) => fnPrintSetupes(value));
      // dprint("Token :: > "+commonController.acessToken.value);
    }catch(e){
      dprint(e.toString());
    }

  }
  fnPrintSetupes(val){
    dprint("0000.............");
    dprint(val);
    printData.value.clear();
    if(mfnCheckValue(val)) {
      printData.value = val;
      fnBlutoothConnect();
    }
  }


  fnBlutoothConnect() async {
    List<BtDevice> devices = await flutterbluetoothconnector.getDevices();
    dprint("CONNNECT HISTORY>>>>>>>>>>>>>");
    dprint("devices HISTORY>>>>>>>>>>>>${devices}>");
    if (devices.isNotEmpty) {
      print(devices[0].address.toString());
      print(devices[0].name.toString());
      print("commonCAAAAAAAAAontroller.printYn.value ${commonController.printYn.value }");


      BluetoothDevice d = BluetoothDevice();
      d.address = devices[0].address;
      d.name = devices[0].name;
      _device.value = d;

      if (_device != null && _device.value.address != null) {
        await bluetoothPrint.connect(_device.value);
        if (commonController.printYn.value == "Y") {
          Future.delayed(
            Duration(seconds: 2),
                () {
              if (commonController.printYn.value == "Y") {
                dprint(" commonController.wstrSunmiDevice.value>>>> ${ commonController.wstrSunmiDevice.value}");
                fnPrint();
               // fnPrint();
              //  fnsunmiPrintText();
              }
            },
          );
        }
        // Future.delayed(
        //   Duration(seconds: 2),
        //       () {
        //
        //   },
        // );
      }
    }else{
      commonController.wstrSunmiDevice.value=="Y"?fnsunmiPrintText():fnPrint();
    }
  }




  fnPrint() async {
    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName= await  Prefs.getString(AppStrings.phonmodel);
    Map<String, dynamic> config = Map();
    // config['gap'] = 2;
    List<LineText> list = [];

    for(var e in printData.value) {
      var type = e["TYPE"] ?? "";
      var key = e["KEY"] ?? "";

      dprint("type:>>ret>> ${type}");
      if (type == "L") {
        dprint("feed:>>>> ${ e["FEED"]}");
        list.add(LineText(linefeed: 1));
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      } else if (key == "DATA") {
        var srno  = 1;
        for(var d in historyList){
          var docdate= "";
          try{
            docdate =setDate(15, DateTime.parse(d.dOCDATE.toString()));
          }catch(e){}
          list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "$srno. ${d.tITLE}",
              size: 15,
            )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   ${d.dOCNO.toString()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   ${docdate.toString()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   USER : ${d.cREATEUSER.toString().toUpperCase()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   DEVICE : ${d.deviceName.toString().toUpperCase()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "  ",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   ${d.cARDNO.toString().toUpperCase()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   PARTY : ${d.sLDESC.toString().toUpperCase()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   ${d.mOBILE.toString().toUpperCase()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "     ${mfnDbl(d.aMT).toStringAsFixed(2)}",
            size: 15,
            weight:2,
              align:LineText.ALIGN_RIGHT
          )
          );

          srno = srno+1;
        }
      }
      else {
        var title = e["TITLE"] ?? "";

        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";
        var weight = e["WEIGHT"] ?? 0;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value.toString().isEmpty && key.toString().isNotEmpty) {
          if (key == "DATE") {
            value = (title + " " + setDate(9, DateTime.now()));
          } else if (key == "CODE") {
            value = (title + " " + "transactionid");
          }
          else if (key == "TIME") {
            value = (title + " " + setDate(11, DateTime.now()));
          }
          else if (key == "SLCODE") {
            value = (title + " " + "slcode");
          }
          else if (key == "SLDESCP") {
            value = (title + " " + "sldesc");
          }
          else if (key == "AMT") {
            value = (title + " " +mfnDbl("amount").toStringAsFixed(2));
          }
          else if (key == "CARD") {
            // value = (title + "xxxxx" + "cardnumb".substring(5,8));
            // value = (title + "  " + cardnumb.toString());
          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {

            value = (title + " " + devid.toString());
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString());
          }
          else if (key == "FILTER") {
            value = (title + " From " + from.value+" To "+to.value);
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
    if(list.isNotEmpty){

      await bluetoothPrint.printReceipt(config, list);
    }

  }

  //=============================================================SUNMIPRINTER


  Future fnsunmiPrintText() async {

    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);
    dprint("devid>>> ${devid.toString()}");
    dprint("devName>>> ${devName.toString()}");
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
     await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);




    // List list = [];

    for(var e in printData.value) {
      var type = e["TYPE"] ?? "";
      var key = e["KEY"] ?? "";

      dprint("type:>>ret>> ${type}");
      if (type == "L") {
        SunmiPrinter.lineWrap(1);
      //  list.add(SunmiPrinter.lineWrap(2));
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      }

      else if (key == "DATA") {
        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        var srno  = 1;
        for(var d in historyList.value){
          dprint("History>>>>details>>>> ${d}");
          var docdate= "";
          try{
            docdate =setDate(15, DateTime.parse(d.dOCDATE.toString()));
          }catch(e){}

            SunmiPrinter.printText("$srno. ${d.tITLE}"

          );

              SunmiPrinter.printText("   ${d.dOCNO.toString()}"

          );

              SunmiPrinter.printText("   ${docdate.toString()}"

          );

              SunmiPrinter.printText("   USER : ${d.cREATEUSER.toString().toUpperCase()}"

          );

              SunmiPrinter.printText("   DEVICE : ${d.deviceName.toString().toUpperCase()}"

          );

              SunmiPrinter.printText("  "

          );
          SunmiPrinter.printText("   ${d.cARDNO.toString().toUpperCase()}");
          SunmiPrinter.printText("   PARTY : ${d.sLDESC.toString().toUpperCase()}");
         SunmiPrinter.printText("   ${d.mOBILE.toString().toUpperCase()}");
        SunmiPrinter.printText("     ${mfnDbl(d.aMT).toStringAsFixed(2)}");

          srno = srno+1;
        }
      }

      else {
        var title = e["TITLE"] ?? "";

        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";
        var weight = e["WEIGHT"] ?? 0;
        var zoom = e["ZOOM"] ?? 1;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value.toString().isEmpty && key.toString().isNotEmpty) {
          await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
          if (key == "DATE") {
            value = (title + " " + setDate(9, DateTime.now()));
          } else if (key == "CODE") {
            value = (title + " " + "transactionid");
          }
          else if (key == "TIME") {
            value = (title + " " + setDate(11, DateTime.now()));
          }
          else if (key == "SLCODE") {
            value = (title + " " + "slcode");
          }
          else if (key == "SLDESCP") {
            value = (title + " " + "sldesc");
          }
          else if (key == "AMT") {
            value = (title + " " +mfnDbl("amount").toStringAsFixed(2));
          }
          else if (key == "CARD") {
            // value = (title + "xxxxx" + "cardnumb".substring(5,8));
            // value = (title + "  " + cardnumb.toString());
          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {

            value = (title + " " + devid.toString());
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString());
          }
          else if (key == "FILTER") {
            value = (title + " From " + from.value+" To "+to.value);
          }
        }
        // else if(value.toString().isNotEmpty && key.toString().isEmpty){
        //   value = (value.toString());
        // }
        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            SunmiPrinter.printText(
            value,
                style:SunmiStyle(
                  fontSize: value.toString().isNotEmpty &&weight==1 && zoom==2?SunmiFontSize.XL:SunmiFontSize.MD,
                  align: align == "L" ? SunmiPrintAlign.LEFT : align == "C" ? SunmiPrintAlign.CENTER: align == "R" ? SunmiPrintAlign.RIGHT :SunmiPrintAlign.LEFT,
                )



        );
      }
    }



    SunmiPrinter.cut();
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);


  }

  //////////////////////////LOOKUP
  fnDeviceLookup(){
    Get.to(() => LookupSearch(
      callbackfn: (data) {
        dprint(data);
        if(data!=null){
          txtdeviceName.text =data["DEVICE_NAME"].toString();
          device_id.value =data["DEVICE_ID"].toString();
          // getusername.value=true;
          // txtCounterDesc.text = data["DESCP"].toString();
          // txtCounterCode.text = data["CODE"].toString();
          fnGetHistory(dropdownvalue.value);
          Get.back();
        }
      },
      table_name: "TAP_DEVICES",
      column_names: const [
        {"COLUMN": "DEVICE_ID", 'DISPLAY': "Device Id: "},
        {"COLUMN": "DEVICE_NAME", 'DISPLAY': "Device Name: "},

      ],
      filter: [],
    )
    );

  }


//////////////////WIDGET========================
  Future<void> wSelectDate(BuildContext context,DateMode dateMode) async {
    dprint("DteMode  "+dateMode.toString());
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateMode==DateMode.to?fromcurrentDate.value:tocurrentDate.value,
        firstDate:dateMode==DateMode.from? DateTime(2015):fromcurrentDate.value,
        lastDate:DateTime(2050 ));
    if (pickedDate != null && pickedDate != fromcurrentDate){

      if(dateMode==DateMode.to){
        tocurrentDate.value = pickedDate;
        // dprint("FROM  DATE::  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");
        dprint("TO  DATE:  ${DateFormat('dd-MM-yyyy').format(tocurrentDate.value)}");
        fnGetHistory(dropdownvalue.value);
      }else {
        fromcurrentDate.value = pickedDate;
        fnGetHistory(dropdownvalue.value);
        dprint("FROM  DATE::  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");
        // dprint("TO  DATE:  ${DateFormat('dd-MM-yyyy').format(tocurrentDate.value)}");
        // tocurrentDate.value = fromcurrentDate.value;
        // dprint("Start  DATE  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");

      }

      }
    // update();

  }


}