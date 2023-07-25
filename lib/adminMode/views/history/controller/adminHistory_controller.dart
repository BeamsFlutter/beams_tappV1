
import 'dart:convert';
import 'dart:io';

import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;

import '../../../../common_widgets/lookup_search.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/dateformates.dart';
import '../../../../constants/enums/filterMode.dart';
import '../../../../constants/string_constant.dart';
import '../../../../model/historyModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../storage/preference.dart';

class AdminHistoryController extends GetxController{


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
  var printData  = [];
  RxString device_id=''.obs;
  RxString adminuser=''.obs;
  RxString reportMode='All'.obs;
  // List of items in our dropdown menu
  var items = [
    'This Month',
    'Today',
    'Yesterday',
    'From - To',
  ];
  var deviceItems = [
    'All',
    'Choose a Device',
  ];
  RxString dropdownDeviceItemsValue = 'All'.obs;
  RxBool choosedevice = false.obs;
  RxBool fromto = false.obs;
  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

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


    try{
      var devid = await  Prefs.getString(AppStrings.deviceId);

      if(dropdownDeviceItemsValue.value == "Choose a Device"){
        device_id.value =device_id.value;
      }
      else{
        device_id.value = '';

      }

      final responseJson = await apiRepository.apiHistory(devid??"",from,to,"Y",reportMode.value, device_id.value);
      HistoryModel historyModel = HistoryModel.fromJson(responseJson);
      historyList.value = historyModel.hISTORY!;

    }catch(e){
      dprint(e);
    }


  }
  fnGetHistory(lstrFilterMode){
    var from = "";
    var to = "";
    var now = DateTime.now();


    if (lstrFilterMode == "Today") {
      from = setDate(2, now);
      to = setDate(2, now);



    } else if (lstrFilterMode == "Yesterday") {

      from = setDate(2, now.subtract(Duration(days: 1)));
      to = setDate(2, now.subtract(Duration(days: 1)));

    } else if (lstrFilterMode == "This Month") {
      from = setDate(2, DateTime(now.year, now.month, 1));
      to = setDate(2, DateTime(now.year, now.month + 1, 0));

    }else if (lstrFilterMode == "From - To") {

      from = setDate(2, fromcurrentDate.value);
      to = setDate(2, tocurrentDate.value);
    }

    fnHistory(from,to);
  }

  fnPrint() async {
    Map<String, dynamic> config = Map();
    // config['gap'] = 2;
    List<LineText> list = [];

    for(var e in printData) {
      var type = e["TYPE"] ?? "";
      dprint("type:>>>> ${type}");
      if (type == "L") {
        dprint("feed:>>>> ${ e["FEED"]}");
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
            value = (title + " " + setDate(7, DateTime.now()));
          } else if (key == "CODE") {
            value = (title + " " +"transaction_id");
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


  //============================================ PAGE FN
  Future<void> fnExportHistory() async{
    //Create a new Excel Document.
    final Workbook workbook = Workbook(1);


    var lstrFilterMode =  dropdownvalue.value;
    var from = "";
    var to = "";
    var now = DateTime.now();

    if (lstrFilterMode == "Today") {
      from = setDate(6, now);
      to = setDate(6, now);
    } else if (lstrFilterMode == "Yesterday") {
      from = setDate(6, now.subtract(Duration(days: 1)));
      to = setDate(6, now.subtract(Duration(days: 1)));
    } else if (lstrFilterMode == "This Month") {
      from = setDate(6, DateTime(now.year, now.month, 1));
      to = setDate(6, DateTime(now.year, now.month + 1, 0));
    }else if (lstrFilterMode == "From - To") {
      from = setDate(6, fromcurrentDate.value);
      to = setDate(6, tocurrentDate.value);
    }



    final Worksheet sheet = workbook.worksheets[0];
    final Style style = workbook.styles.add('Style1');
    style.wrapText = true;
    style.bold = true;
    sheet.getRangeByName('A1:G200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;

    sheet.getRangeByName('A1:J1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP CARD HISTORY');
    sheet.getRangeByName('A2:J2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    var srno = 3;


    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Head');
    sheet.getRangeByName('B$srno').columnWidth = 30.0;
    sheet.getRangeByName('C$srno').setText('Doc#');
    sheet.getRangeByName('C$srno').columnWidth = 20.0;
    sheet.getRangeByName('D$srno').setText('Date');
    sheet.getRangeByName('D$srno').columnWidth = 20.0;
    sheet.getRangeByName('E$srno').setText('Card Number');
    sheet.getRangeByName('E$srno').columnWidth = 20.0;
    sheet.getRangeByName('F$srno').setText('Party Name');
    sheet.getRangeByName('F$srno').columnWidth = 50.0;
    sheet.getRangeByName('G$srno').setText('Mobile');
    sheet.getRangeByName('G$srno').columnWidth = 20.0;
    sheet.getRangeByName('H$srno').setText('Email');
    sheet.getRangeByName('H$srno').columnWidth = 20.0;
    sheet.getRangeByName('I$srno').setText('Device Name');
    sheet.getRangeByName('I$srno').columnWidth = 20.0;
    sheet.getRangeByName('J$srno').setText('Amount');
    sheet.getRangeByName('J$srno').columnWidth = 20.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in historyList){

      var dataList=  e;
      var docdate= "";
      try{
        docdate =setDate(15, DateTime.parse(dataList.dOCDATE.toString()));
      }catch(e){}

      var head = dataList.tITLE.toString().toUpperCase();
      var docno = dataList.dOCNO.toString().toUpperCase();
      var card = dataList.cARDNO.toString().toUpperCase();
      var party = dataList.sLDESC.toString().toUpperCase();
      var mobile = dataList.mOBILE.toString();
      var email = dataList.eMAIL.toString();
      var amount =dataList.aMT.toString();
      var device =dataList.deviceName.toString();


      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(head);
      sheet.getRangeByName('C$srno').setText(docno);
      sheet.getRangeByName('D$srno').setText(docdate);
      sheet.getRangeByName('E$srno').setText(card);
      sheet.getRangeByName('F$srno').setText(party);
      sheet.getRangeByName('G$srno').setText(mobile);
      sheet.getRangeByName('H$srno').setText(email);
      sheet.getRangeByName('I$srno').setText(device);
      sheet.getRangeByName('J$srno').setText(amount);

      srno = srno+1;
      dataSrno = dataSrno+1;
    }
    final Range range1 = sheet.getRangeByName('J$tableStart:J$srno');
    range1.cellStyle.hAlign = HAlignType.right;
    final ExcelTable table1 = sheet.tableCollection.create('Table1',  sheet.getRangeByName('A$tableStart:J$srno'));
    sheet.tableCollection.removeAt(1);

    final List<int> bytes = workbook.saveAsStream();
    File('RemoveTable.xlsx').writeAsBytes(bytes);
    workbook.dispose();
    var formatDate4 =  DateFormat('ddMMyyyyhhmmss');
    var reportDate = formatDate4.format(DateTime.now());

    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'BeamsTappHistory$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappHistory$reportDate.xlsx' : '$path/BeamsTappHistory$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }


}