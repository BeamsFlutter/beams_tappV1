

import 'package:beams_tapp/common_widgets/lookup_search.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/filterMode.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/collectnReportModel.dart';
import 'package:beams_tapp/model/reportmodel/rechargeReportModel.dart';
import 'package:beams_tapp/model/reportmodel/registerReportmodel.dart';
import 'package:beams_tapp/model/reportmodel/salesReportModel.dart';
import 'package:beams_tapp/notification/notification.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

import '../../../model/reportmodel/refundReportModel.dart';

class ReportController extends GetxController {


  // Initial Selected Value
  RxString dropdownvalue = 'Today'.obs;
  dynamic filmode;
  ApiRepository apiRepository = ApiRepository();

  Rx<DateTime> fromcurrentDate = DateTime
      .now()
      .obs;
  Rx<DateTime> tocurrentDate = DateTime
      .now()
      .obs;
  TextEditingController txtdeviceName = TextEditingController();
  Rx<REGISTRATION> registeration = REGISTRATION().obs;
  Rx<RECHARGE> recahrge = RECHARGE().obs;
  Rx<REFUND> refund = REFUND().obs;
  Rx<SALES> sales = SALES().obs;
  RxList collection = [].obs;

  RxString device_id = ''.obs;
  RxString reportMode = 'D'.obs;
  RxString adminuser = ''.obs;

  //report details
  RxList rechargeDetailList = [].obs;
  RxList saleDetailList = [].obs;
  RxList registerDetailList = [].obs;
  RxList refundDetailList = [].obs;
  var from = "".obs;
  var to = "".obs;

  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  RxList printData = [].obs;
  late Future <dynamic> futureform;
  bool _connected = false;
  Rx<BluetoothDevice> _device = BluetoothDevice().obs;

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
  RxBool fromto = false.obs;
  RxBool choosedevice = false.obs;

  void fnChangeStatus() {
    fromto.toggle();
  }

  void fnChangeItemDevice() {
    choosedevice.toggle();
  }


  fnOnChnagedDay(val, page, reportmode) {
    dropdownvalue.value = val;


    dprint("Dropdownvall ${dropdownvalue.value}");
    if (dropdownvalue.value == "From - To") {
      fromto.value = true;
    } else {
      fromto.value = false;
    }

    page == "report" ? fnGetreport(dropdownvalue.value) : fnGetreportDetails(
        dropdownvalue.value, reportmode);
  }

  fnOnChnageDeviceItems(val, page, reportmode) {
    dropdownDeviceItemsValue.value = val;
    dprint("Dropdownvall ${dropdownDeviceItemsValue.value}");
    if (dropdownDeviceItemsValue.value == "Choose a Device") {
      reportMode.value = "";
      choosedevice.value = true;
    } else if (dropdownDeviceItemsValue.value == "This Device") {
      reportMode.value = "D";
      choosedevice.value = false;
    } else {
      reportMode.value = "All";
      choosedevice.value = false;
    }


    dprint("Choosedevice..... ${choosedevice.value}");
    dprint("page..fdf... ${page}");
    dprint("Call apii for ${dropdownDeviceItemsValue.value}");

    fnGetreport(dropdownvalue.value);
  }

  Future<void> wSelectDate(BuildContext context, DateMode dateMode, page,
      reportmode) async {
    dprint("DteMode  " + dateMode.toString());
    dprint("Pageeee:::   " + page.toString());
    dprint("reportmode:::   " + reportmode.toString());
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateMode == DateMode.to
            ? fromcurrentDate.value
            : tocurrentDate.value,
        firstDate: dateMode == DateMode.from ? DateTime(2015) : fromcurrentDate
            .value,
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != fromcurrentDate) {
      if (dateMode == DateMode.to) {
        tocurrentDate.value = pickedDate;
        fnGetreport(dropdownvalue.value);


        // dprint("FROM  DATE::  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");
        dprint("TO  DATE:  ${DateFormat('dd-MM-yyyy').format(
            tocurrentDate.value)}");
      } else {
        fromcurrentDate.value = pickedDate;

        dprint("FROM  DATE::  ${DateFormat('dd-MM-yyyy').format(
            fromcurrentDate.value)}");

        page == "report"
            ? fnGetreport(dropdownvalue.value)
            : fnGetreportDetails(dropdownvalue.value, reportmode);

        // dprint("TO  DATE:  ${DateFormat('dd-MM-yyyy').format(tocurrentDate.value)}");
        // tocurrentDate.value = fromcurrentDate.value;
        // dprint("Start  DATE  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");

      }
    }
    // update();

  }


  fnReport(from, to) async {
    if (commonController.wstrRoleCode.value == "ADMIN") {
      adminuser.value = "Y";
      update();
    } else {
      adminuser.value = "N";
      update();
    }


    try {
      var devid = await Prefs.getString(AppStrings.deviceId);


      if (dropdownDeviceItemsValue.value == "Choose a Device") {
        device_id.value = device_id.value;
      } else if (dropdownDeviceItemsValue.value == "This Device") {
        device_id.value = devid!;
      } else {
        device_id.value = devid!;
      }

      final responseJson = await apiRepository.apiCollectionReport(
          devid, from, to, reportMode.value, adminuser.value, device_id.value);

      CollectnReportModel collectnReportModel = CollectnReportModel.fromJson(
          responseJson);


      registeration.value = collectnReportModel.rEGISTRATION![0];
      recahrge.value = collectnReportModel.rECHARGE![0];
      sales.value = collectnReportModel.sALES![0];
      collection.value = collectnReportModel.cOLLECTION!;
      refund.value = collectnReportModel.reFund![0];


      // rechargeamount = collectnReportModel.rECHARGE![0].rECHARGEAMT??"0";
      //  rechargenubrofcards = collectnReportModel.rECHARGE![0].nOOFRECHARGE;
      //
      //  salenoofbill = collectnReportModel.sALES![0].nOOFBILL;
      //  salesamount = collectnReportModel.sALES![0].nETAMT;
      //
      //  regamount = collectnReportModel.rEGISTRATION![0].rEGAMOUNT;
      //  regnumbofreg = collectnReportModel.rEGISTRATION![0].nOOFCARDS;


    } catch (e) {
      dprint(e);
    }
  }


  fnGetreport(lstrFilterMode) {
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
    } else if (lstrFilterMode == "From - To") {
      from.value = setDate(2, fromcurrentDate.value);
      to.value = setDate(2, tocurrentDate.value);
    }

    fnReport(from.value, to.value);
  }

  fnGetreportDetails(lstrFilterMode, reportmode) {
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
    } else if (lstrFilterMode == "From - To") {
      from = setDate(2, fromcurrentDate.value);
      to = setDate(2, tocurrentDate.value);
    }

    fnGetReportDetails(from, to, reportmode);
  }

  fnGetReportDetails(from, to, mode) async {
    try {
      var devid = await Prefs.getString(AppStrings.deviceId);

      if (mode == "REC") {
        final responseJson = await apiRepository.apiCollectionReportDetails(
            mode,
            devid,
            from,
            to,
            adminuser.value,
            reportMode.value,
            device_id.value);
        RechrgReportModel rechrgReportModel = RechrgReportModel.fromJson(
            responseJson);
        rechargeDetailList.value = rechrgReportModel.dATA!;
        dprint("rechaargeeee  ${ rechargeDetailList.value}");
        dprint("recc  ${rechargeDetailList.length}");
      } else if (mode == "SAL") {
        dprint("SALeeee");
        final responseJson = await apiRepository.apiCollectionReportDetails(
            mode,
            devid,
            from,
            to,
            adminuser.value,
            reportMode.value,
            device_id.value);
        SaleReportModel saleReportModel = SaleReportModel.fromJson(
            responseJson);
        saleDetailList.value = saleReportModel.dATA!;
        dprint("SALEEEEEEEE  ${saleDetailList.value}");
        dprint("SALbb  ${saleDetailList.length}");
      } else if (mode == "REG") {
        final responseJson = await apiRepository.apiCollectionReportDetails(
            mode,
            devid,
            from,
            to,
            adminuser.value,
            reportMode.value,
            device_id.value);
        RgsterReportModel registerReportModel = RgsterReportModel.fromJson(
            responseJson);
        registerDetailList.value = registerReportModel.dATA!;
        dprint("rEGISTERRR  ${registerDetailList}");
        dprint("regg  ${registerDetailList.length}");
      }
      else if (mode == "REF") {
        final responseJson = await apiRepository.apiCollectionReportDetails(
            mode,
            devid,
            from,
            to,
            adminuser.value,
            reportMode.value,
            device_id.value);
        dprint("reeeefundd...........");
        RefundReportModel refundReportModel = RefundReportModel.fromJson(
            responseJson);
        refundDetailList.value = refundReportModel.dATA!;
        dprint("REFund  ${refundDetailList[0]}");
        dprint("refff ${refundDetailList.length}");
      }
    } catch (e) {
      dprint(e);
    }
  }


  fnPrintSetup() {
    try {
      futureform = apiRepository.apiGetPrintSetup("RPT");
      futureform.then((value) => fnPrintSetupes(value));
      // dprint("Token :: > "+commonController.acessToken.value);
    } catch (e) {
      dprint(e.toString());
    }
  }

  fnPrintSetupes(val) {
    dprint("REPORTCON............");
    dprint(val);
    printData.value.clear();
    if (mfnCheckValue(val)) {
      printData.value = val;
      fnBluetoothConnect("");
    }
  }


  fnPrintSetupDet(mode) {
    try {
      futureform = apiRepository.apiGetPrintSetup("RPTD");
      futureform.then((value) => fnPrintSetupDetRes(value, mode));
      // dprint("Token :: > "+commonController.acessToken.value);
    } catch (e) {
      dprint(e.toString());
    }
  }

  fnPrintSetupDetRes(val, mode) {
    dprint("REPORTCON............");
    dprint(val);
    printData.value.clear();
    if (mfnCheckValue(val)) {
      printData.value = val;
      fnBluetoothConnect(mode);
    }
  }

  fnBluetoothConnect(mode) async {
    List<BtDevice> devices = await flutterbluetoothconnector.getDevices();
    dprint("devices>>>>>>>>>>>>");
    dprint(devices);
    if (devices.isNotEmpty) {
      print(devices[0].address.toString());
      print(devices[0].name.toString());

      BluetoothDevice d = BluetoothDevice();
      d.address = devices[0].address;
      d.name = devices[0].name;
      _device.value = d;

      if (_device != null && _device.value.address != null) {
        await bluetoothPrint.connect(_device.value);
        if (commonController.printYn.value == "Y") {
          Future.delayed(
            const Duration(seconds: 2),
                () {
              if (commonController.printYn.value == "Y") {
                     fnPrint(mode);
              //  fnsunmiPrintText(mode);
              }
            },
          );
        }
      }
    }else{
      commonController.wstrSunmiDevice.value=="Y"?fnsunmiPrintText(mode):fnPrint(mode);
    }
  }


  fnPrint(mode) async {
    var devid = await Prefs.getString(AppStrings.deviceId);
    var devName = await Prefs.getString(AppStrings.phonmodel);
    Map<String, dynamic> config = Map();
    // config['gap'] = 2;
    List<LineText> list = [];

    for (var e in printData) {
      var type = e["TYPE"] ?? "";
      var key = e["KEY"] ?? "";


      dprint("type:>>ret>> ${type}");
      if (type == "L") {
        dprint("feed:>>>> ${ e["FEED"]}");
        list.add(LineText(linefeed: 1));
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      }
      else if (key == "DATA") {
        var srno = 1;
        var totalAmt = 0.0;
        for (var d in collection) {
          list.add(LineText(
            type: LineText.TYPE_TEXT,
            content: "$srno. ${d.pAYMODE.toString()}  :   ${(d.aMT
                ?.toStringAsFixed(2)).toString()}",
            size: 15,
          )
          );
          totalAmt = totalAmt + mfnDbl(d.aMT);
          srno = srno + 1;
        }
        list.add(LineText(
            type: LineText.TYPE_TEXT,
            content: "TOTAL :   ${totalAmt.toStringAsFixed(2)}",
            size: 15,
            weight: 2
        ));
      }
      else if (key == "DET_DATA") {
        var srno = 1;
        if (mode == "REC") {
          for (var det in rechargeDetailList) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.dOCDATE.toString()));
            } catch (e) {}

            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "$srno. ${det.dOCNO.toString()}",
              size: 15,
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
              content: "   ${det.dNAME.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.cREATEUSER.toString().toUpperCase()}",
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
              content: "   ${det.cARDNO.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   PARTY : ${det.sLDESCP.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.mOBILE.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
                type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                    .TYPE_IMAGE : LineText.TYPE_TEXT,
                content: "     ${mfnDbl(det.aMT).toStringAsFixed(2)}",
                size: 15,
                weight: 2,
                align: LineText.ALIGN_RIGHT
            )
            );

            srno = srno + 1;
          }
        }
        else if (mode == "REF") {
          for (var det in refundDetailList) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.dOCDATE.toString()));
            } catch (e) {}

            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "$srno. ${det.dOCNO.toString()}",
              size: 15,
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
              content: "   ${det.dNAME.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.cREATEUSER.toString().toUpperCase()}",
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
              content: "   ${det.cARDNO.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   PARTY : ${det.sLDESCP.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.mOBILE.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
                type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                    .TYPE_IMAGE : LineText.TYPE_TEXT,
                content: "     ${mfnDbl(det.aMT).toStringAsFixed(2)}",
                size: 15,
                weight: 2,
                align: LineText.ALIGN_RIGHT
            )
            );

            srno = srno + 1;
          }
        }
        else if (mode == "SAL") {
          for (var det in saleDetailList) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.dOCDATE.toString()));
            } catch (e) {}

            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "$srno. ${det.dOCNO.toString()}",
              size: 15,
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
              content: "   ${det.dNAME.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.cREATEUSER.toString().toUpperCase()}",
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
              content: "   ${det.cARDNO.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   PARTY : ${det.sLDESCP.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.mOBILE.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
                type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                    .TYPE_IMAGE : LineText.TYPE_TEXT,
                content: "     ${mfnDbl(det.nETAMT).toStringAsFixed(2)}",
                size: 15,
                weight: 2,
                align: LineText.ALIGN_RIGHT
            )
            );

            srno = srno + 1;
          }
        }
        else if (mode == "REG") {
          for (var det in registerDetailList) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.iSSUEDATE.toString()));
            } catch (e) {}

            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "$srno. ${det.sLDESCP.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.cARDNO.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.mOBILE.toString().toUpperCase()}",
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
              content: "   ${docdate.toString()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.dNAME.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
              type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                  .TYPE_IMAGE : LineText.TYPE_TEXT,
              content: "   ${det.cREATEUSER.toString().toUpperCase()}",
              size: 8,
            )
            );
            list.add(LineText(
                type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                    .TYPE_IMAGE : LineText.TYPE_TEXT,
                content: "     ${mfnDbl(det.rEGCHARGE).toStringAsFixed(2)}",
                size: 15,
                weight: 2,
                align: LineText.ALIGN_RIGHT
            )
            );

            srno = srno + 1;
          }
        }
      }
      else {
        var title = e["TITLE"] ?? "";

        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";
        var weight = e["WEIGHT"] ?? 0;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value
            .toString()
            .isEmpty && key
            .toString()
            .isNotEmpty) {
          if (key == "DATE") {
            value = (title + " " + setDate(9, DateTime.now()));
          }
          else if (key == "TIME") {
            value = (title + " " + setDate(11, DateTime.now()));
          }
          else if (key == "HEAD") {
            var thead = mode == "REC" ? "Recharge Report" : mode == "REF"
                ? "Refund Report"
                : mode == "SAL" ? "Sales Report" : mode == "REG"
                ? "Registration"
                : "";
            value = (title + "" + thead);
          }
          else if (key == "DEVICEID") {
            value = (title + " " + devid.toString());
          }
          else if (key == "FILTER") {
            value = (title + "From " + from.value + " To " + to.value);
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString());
          }
          else if (key == "REC_AMOUNT") {
            value = (title + " " + recahrge.value.rECHARGEAMT.toString());
          }
          else if (key == "REC_COUNT") {
            value =
            (title + " " + mfnInt(recahrge.value.nOOFRECHARGE).toString());
          }
          else if (key == "REF_AMOUNT") {
            value = (title + " " + refund.value.reFundAMT.toString());
          }
          else if (key == "REF_COUNT") {
            value = (title + " " + mfnInt(refund.value.nOOFREFUND).toString());
          }
          else if (key == "REG_AMOUNT") {
            value = (title + " " + registeration.value.rEGAMOUNT.toString());
          }
          else if (key == "REG_COUNT") {
            value =
            (title + " " + mfnInt(registeration.value.nOOFCARDS).toString());
          }
          else if (key == "SAL_AMOUNT") {
            value = (title + " " + sales.value.nETAMT.toString());
          }
          else if (key == "SAL_COUNT") {
            value = (title + " " + mfnInt(sales.value.nOOFBILL).toString());
          }
        }
        list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: value,
            relativeX: 1,
            fontZoom: e["ZOOM"] ?? 1,
            weight: weight,
            size: fontsize,
            align: align == "L" ? LineText.ALIGN_LEFT : align == "C" ? LineText
                .ALIGN_CENTER : align == "R" ? LineText.ALIGN_RIGHT : LineText
                .ALIGN_LEFT,
            linefeed: e["FEED"] ?? 0)
        );
      }
    }
    if (list.isNotEmpty) {
      await bluetoothPrint.printReceipt(config, list);
    }
  }

  //=============================================================SUNMIPRINTER


  Future fnsunmiPrintText(mode) async {
    var devid = await Prefs.getString(AppStrings.deviceId);
    var devName = await Prefs.getString(AppStrings.phonmodel);

    dprint("devid>>> ${devid.toString()}");
    dprint("devName>>> ${devName.toString()}");
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);


    // List list = [];

    for (var e in printData.value) {
      dprint("feed:>>>> ${e}");
      var type = e["TYPE"] ?? "";
      var key = e["KEY"] ?? "";
      if (type == "L") {
        SunmiPrinter.lineWrap(1);
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      }
      else if (key == "DATA") {
        var srno = 1;
        var totalAmt = 0.0;
        for (var d in collection) {
          SunmiPrinter.printText(
              "$srno. ${d.pAYMODE.toString()}  :   ${(d.aMT?.toStringAsFixed(2))
                  .toString()}"

          );
          totalAmt = totalAmt + mfnDbl(d.aMT);
          srno = srno + 1;
        }

            SunmiPrinter.printText("TOTAL :   ${totalAmt.toStringAsFixed(2)}");
      }
      else if (key == "DET_DATA") {
        var srno = 1;
        if (mode == "REC") {
          for (var det in rechargeDetailList.value) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.dOCDATE.toString()));
            } catch (e) {}
            SunmiPrinter.printText(
              "$srno. ${det.dOCNO.toString()}",);
            SunmiPrinter.printText(
              "   ${docdate.toString()}");
          SunmiPrinter.printText(
                "   ${det.dNAME.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.cREATEUSER.toString().toUpperCase()}");
            SunmiPrinter.printText("  ");
           SunmiPrinter.printText(
                "   ${det.cARDNO.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   PARTY : ${det.sLDESCP.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.mOBILE.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "     ${mfnDbl(det.aMT).toStringAsFixed(2)}",
                style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
            srno = srno + 1;
          }
        }
        else if (mode == "REF") {
          for (var det in refundDetailList.value) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.dOCDATE.toString()));
            } catch (e) {}
           SunmiPrinter.printText("$srno. ${det.dOCNO.toString()}");
           SunmiPrinter.printText("   ${docdate.toString()}");
            SunmiPrinter.printText(
                "   ${det.dNAME.toString().toUpperCase()}");
          SunmiPrinter.printText(
                "   ${det.cREATEUSER.toString().toUpperCase()}");
           SunmiPrinter.printText("  ");
           SunmiPrinter.printText(
                "   ${det.cARDNO.toString().toUpperCase()}");
           SunmiPrinter.printText(
                "   PARTY : ${det.sLDESCP.toString().toUpperCase()}");
           SunmiPrinter.printText(
                "   ${det.mOBILE.toString().toUpperCase()}");
           SunmiPrinter.printText(
                "     ${mfnDbl(det.aMT).toStringAsFixed(2)}",
                style: SunmiStyle(align: SunmiPrintAlign.RIGHT)
            );
            srno = srno + 1;
          }
        }
        else if (mode == "SAL") {
          for (var det in saleDetailList.value) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.dOCDATE.toString()));
            } catch (e) {}
            SunmiPrinter.printText("$srno. ${det.dOCNO.toString()}");
            SunmiPrinter.printText("   ${docdate.toString()}");
            SunmiPrinter.printText(
                "   ${det.dNAME.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.cREATEUSER.toString().toUpperCase()}");
            SunmiPrinter.printText("  ");
            SunmiPrinter.printText(
                "   ${det.cARDNO.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   PARTY : ${det.sLDESCP.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.mOBILE.toString().toUpperCase()}");
           SunmiPrinter.printText(
                "     ${mfnDbl(det.nETAMT).toStringAsFixed(2)}",
                style: SunmiStyle(
                    align: SunmiPrintAlign.RIGHT
                ));
            srno = srno + 1;
          }
        }
        else if (mode == "REG") {
          for (var det in registerDetailList.value) {
            var docdate = "";
            try {
              docdate = setDate(15, DateTime.parse(det.iSSUEDATE.toString()));
            } catch (e) {}
            SunmiPrinter.printText(
                "$srno. ${det.sLDESCP.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.cARDNO.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.mOBILE.toString().toUpperCase()}");
            SunmiPrinter.printText("  ");
            SunmiPrinter.printText("   ${docdate.toString()}");
            SunmiPrinter.printText(
                "   ${det.dNAME.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "   ${det.cREATEUSER.toString().toUpperCase()}");
            SunmiPrinter.printText(
                "     ${mfnDbl(det.rEGCHARGE).toStringAsFixed(2)}",
                style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
            srno = srno + 1;
          }
        }



      }
      else {
        var title = e["TITLE"] ?? "";
        var zoom = e["ZOOM"] ?? 1;
        var align = e["ALIGN"] ?? "";
        var value = e["DEFAULT_VALUE"] ?? "";

        var weight = e["WEIGHT"] ?? 0;
        var fontsize = e["FONT_SIZE"] ?? 15;
        if (value.toString().isEmpty && key.toString().isNotEmpty) {
          await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
          if (key == "DATE") {
            value = (title + " " + setDate(9, DateTime.now()));
          }
          else if (key == "TIME") {
            value = (title + " " + setDate(11, DateTime.now()));
          }
          else if (key == "HEAD") {
            var thead = mode == "REC" ? "Recharge Report" : mode == "REF"
                ? "Refund Report"
                : mode == "SAL" ? "Sales Report" : mode == "REG"
                ? "Registration"
                : "";
            value = (title + "" + thead);
          }
          else if (key == "DEVICEID") {
            value = (title + " " + devid.toString());
          }
          else if (key == "FILTER") {
            value = (title + "From " + from.value + " To " + to.value);
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString());
          }
          else if (key == "REC_AMOUNT") {
            value = (title + " " + recahrge.value.rECHARGEAMT.toString());
          }
          else if (key == "REC_COUNT") {
            value =
            (title + " " + mfnInt(recahrge.value.nOOFRECHARGE).toString());
          }
          else if (key == "REF_AMOUNT") {
            value = (title + " " + refund.value.reFundAMT.toString());
          }
          else if (key == "REF_COUNT") {
            value =
            (title + " " + mfnInt(refund.value.nOOFREFUND).toString());
          }
          else if (key == "REG_AMOUNT") {
            value = (title + " " + registeration.value.rEGAMOUNT.toString());
          }
          else if (key == "REG_COUNT") {
            value =
            (title + " " + mfnInt(registeration.value.nOOFCARDS).toString());
          }
          else if (key == "SAL_AMOUNT") {
            value = (title + " " + sales.value.nETAMT.toString());
          }
          else if (key == "SAL_COUNT") {
            value = (title + " " + mfnInt(sales.value.nOOFBILL).toString());
          }
        }


        SunmiPrinter.printText(
          value,
          style: SunmiStyle(
            fontSize: value.toString().isNotEmpty &&weight==1 && zoom==2?SunmiFontSize.XL:SunmiFontSize.MD,
            align: align == "L" ? SunmiPrintAlign.LEFT : align == "C"
                ? SunmiPrintAlign.CENTER
                : align == "R" ? SunmiPrintAlign.RIGHT : SunmiPrintAlign
                .LEFT,
            // bold: value.toString().isNotEmpty && weight==1?true:false
          ),

        );
      }



    }
    SunmiPrinter.cut();
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
  }

//////////////////////////LOOKUP
    fnDeviceLookup() {
      Get.to(() =>
          LookupSearch(
            callbackfn: (data) {
              dprint(data);
              if (data != null) {
                txtdeviceName.text = data["DEVICE_NAME"].toString();
                device_id.value = data["DEVICE_ID"].toString();
                // getusername.value=true;
                // txtCounterDesc.text = data["DESCP"].toString();
                // txtCounterCode.text = data["CODE"].toString();
                fnGetreport(dropdownvalue.value);
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
  }
