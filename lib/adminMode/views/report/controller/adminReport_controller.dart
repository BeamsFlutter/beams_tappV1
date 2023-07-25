import 'dart:convert';
import 'dart:io';




import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'as excel;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import '../../../../common_widgets/lookup_search.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/dateformates.dart';
import '../../../../constants/enums/filterMode.dart';
import '../../../../constants/string_constant.dart';
import '../../../../model/collectnReportModel.dart';
import '../../../../model/reportmodel/rechargeReportModel.dart';
import '../../../../model/reportmodel/refundReportModel.dart';
import '../../../../model/reportmodel/registerReportmodel.dart';
import '../../../../model/reportmodel/salesReportModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../storage/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminReportController extends GetxController {



  // Initial Selected Value
  RxString dropdownvalue = 'Today'.obs;
  RxString selectedReport = 'OVER'.obs;
  dynamic filmode;
  ApiRepository apiRepository =ApiRepository();

  Rx<DateTime> fromcurrentDate = DateTime.now().obs;
  Rx<DateTime> tocurrentDate = DateTime.now().obs;
  TextEditingController txtdeviceName = TextEditingController();
  TextEditingController txtcardno = TextEditingController();
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtDays = TextEditingController();
  Rx<REGISTRATION> registeration = REGISTRATION().obs;
  Rx<RECHARGE> recahrge = RECHARGE().obs;
  Rx<SALES> sales = SALES().obs;
  Rx<REFUND> refund = REFUND().obs;
  RxList collection = [].obs;
  late Future <dynamic> futureform;
  RxString device_id=''.obs;
  RxString reportMode='All'.obs;
  RxString adminuser='Y'.obs;

  //report details
  RxList rechargeDetailList = [].obs;
  RxList saleDetailList = [].obs;
  RxList registerDetailList = [].obs;
  RxList refundDetailList = [].obs;

  var totalAmount=0.0.obs;
  //
  RxList ad_regiterList = [].obs;
  RxList ad_rechargeList = [].obs;
  RxList ad_refundList = [].obs;
  RxList ad_saleList = [].obs;
  RxList ad_expList = [].obs;
  RxList ad_cardusageList = [].obs;
  RxList ad_historyList = [].obs;



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
  RxBool fromto = false.obs;
  RxBool choosedevice = false.obs;


  Future<void> wSelectDate(BuildContext context,DateMode dateMode,page,reportmode) async {
    dprint("DteMode  $dateMode");
    dprint("Pageeee:::   $page");
    dprint("reportmode:::   $reportmode");
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateMode==DateMode.to?fromcurrentDate.value:tocurrentDate.value,
        firstDate:dateMode==DateMode.from? DateTime(2015):fromcurrentDate.value,
        lastDate:DateTime(2050 ));
    if (pickedDate != null && pickedDate != fromcurrentDate){

      if(dateMode==DateMode.to){

        tocurrentDate.value = pickedDate;
        fnGetreport(dropdownvalue.value);


        // dprint("FROM  DATE::  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");
        dprint("TO  DATE:  ${DateFormat('dd-MM-yyyy').format(tocurrentDate.value)}");
      }else {
        fromcurrentDate.value = pickedDate;

        dprint("FROM  DATE::  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");

        page=="report" ? fnGetreport(dropdownvalue.value):fnGetreportDetails(dropdownvalue.value,reportmode);

        // dprint("TO  DATE:  ${DateFormat('dd-MM-yyyy').format(tocurrentDate.value)}");
        // tocurrentDate.value = fromcurrentDate.value;
        // dprint("Start  DATE  ${DateFormat('dd-MM-yyyy').format(fromcurrentDate.value)}");

      }

    }
    // update();

  }
  void fnChangeStatus() {
    fromto.toggle();
  }
  void fnChangeItemDevice() {
    choosedevice.toggle();
  }
  fnOnChnagedDay(val,page,reportmode){
    dropdownvalue.value = val;


    dprint("Dropdownvall ${dropdownvalue.value}");
    if(dropdownvalue.value == "From - To"){
      fromto.value = true;
    }else{
      fromto.value = false;
    }
    fnGetreportDetails(dropdownvalue.value, reportmode);
    // page=="report" ? fnGetreport(dropdownvalue.value):fnGetreportDetails(dropdownvalue.value,reportmode);
  }
  fnOnChnageDeviceItems(val,page,reportmode){
    dropdownDeviceItemsValue.value = val;
    dprint("Dropdownvall ${dropdownDeviceItemsValue.value}");
    if(dropdownDeviceItemsValue.value == "Choose a Device"){
      reportMode.value = "";
      choosedevice.value = true;

    } else{
      reportMode.value = "All";
      choosedevice.value = false;


    }



    dprint("Choosedevice..... ${choosedevice.value}");
    dprint("page..fdf... ${page}");
    dprint("Call apii for ${dropdownDeviceItemsValue.value}");
    //
    // fnGetreport(dropdownvalue.value);


  }


  fnReport(from,to)async{

    dprint("apiiiicalll");
    // if(commonController.wstrRoleCode.value=="ADMIN"){
    //   adminuser.value = "Y";
    //   update();
    // }else{
    //   adminuser.value = "N";
    //   update();
    // }

    try{

      var devid = await  Prefs.getString(AppStrings.deviceId);
      dprint("Deviceeeidd ${devid.toString()}");


      if(dropdownDeviceItemsValue.value == "Choose a Device"){
        device_id.value =device_id.value;
      }else{
        device_id.value = "";

      }


      final responseJson = await apiRepository.apiCollectionReport(devid??"",from,to,reportMode.value,"Y",device_id.value);

      CollectnReportModel collectnReportModel = CollectnReportModel.fromJson(responseJson);


      registeration.value =collectnReportModel.rEGISTRATION![0];
      recahrge.value =collectnReportModel.rECHARGE![0];
      sales.value =collectnReportModel.sALES![0];
      collection.value =collectnReportModel.cOLLECTION!;
      refund.value =collectnReportModel.reFund![0];



      // rechargeamount = collectnReportModel.rECHARGE![0].rECHARGEAMT??"0";
      //  rechargenubrofcards = collectnReportModel.rECHARGE![0].nOOFRECHARGE;
      //
      //  salenoofbill = collectnReportModel.sALES![0].nOOFBILL;
      //  salesamount = collectnReportModel.sALES![0].nETAMT;
      //
      //  regamount = collectnReportModel.rEGISTRATION![0].rEGAMOUNT;
      //  regnumbofreg = collectnReportModel.rEGISTRATION![0].nOOFCARDS;


    }catch(e){

      dprint("AdminReportControllerr................. ${e.toString()}");
      dprint(e);
    }

  }
  fnGetreport(lstrFilterMode) {
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

    fnReport(from,to);
  }
  fnGetreportDetails(lstrFilterMode,reportmode){
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

    fnReportDetails(from,to,reportmode);
  }
  fnReportDetails(from,to,mode)async{
    try{
      var devid = await  Prefs.getString(AppStrings.deviceId);

      if(mode=="REC"){
        final responseJson = await apiRepository.apiCollectionReportDetails(mode,devid,from,to,adminuser.value,reportMode.value,device_id.value);
        RechrgReportModel rechrgReportModel = RechrgReportModel.fromJson(responseJson);
        rechargeDetailList.value = rechrgReportModel.dATA!;

        dprint("recc  ${rechargeDetailList.length}");
      }else if(mode=="SAL"){
        dprint("SALeeee");
        final responseJson = await apiRepository.apiCollectionReportDetails(mode,devid,from,to,adminuser.value,reportMode.value,device_id.value);
        SaleReportModel saleReportModel = SaleReportModel.fromJson(responseJson);
        saleDetailList.value = saleReportModel.dATA!;
        dprint("SALEEEEEEEE  ${saleDetailList.value}");
        dprint("SALbb  ${saleDetailList.length}");
      }else if(mode=="REG"){
        final responseJson = await apiRepository.apiCollectionReportDetails(mode,devid,from,to,adminuser.value,reportMode.value,device_id.value);
        RgsterReportModel registerReportModel = RgsterReportModel.fromJson(responseJson);
        registerDetailList.value = registerReportModel.dATA!;
        dprint("rEGISTERRR  ${registerDetailList}"); dprint("regg  ${registerDetailList.length}");

      }
      else if(mode=="REF"){
        final responseJson = await apiRepository.apiCollectionReportDetails(mode,devid,from,to,adminuser.value,reportMode.value,device_id.value);
        dprint("reeeefundd...........");
        RefundReportModel refundReportModel = RefundReportModel.fromJson(responseJson);
        refundDetailList.value = refundReportModel.dATA!;
        dprint("REFund  ${refundDetailList[0]}"); dprint("refff ${refundDetailList.length}");

      }







    }catch(e){
      dprint(e);
    }

  }
  fnApply(){
    totalAmount.value =0.0;
    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
    }

    var lstrFilterMode =  dropdownvalue.value;
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

    if( selectedReport.value == "REG"){
      apiReg(from, to, fcreatuser, fcardnumb,fdevid);
    }else
    if( selectedReport.value == "RECH"){
      apiRecharge(from, to, fcreatuser, fcardnumb,fdevid);
    }else
    if( selectedReport.value == "REFU"){
      apiRefund(from, to, fcreatuser, fcardnumb,fdevid);
    }else
    if( selectedReport.value == "SALE"){
      apiSale(fdevid, from, to, fcreatuser, fcardnumb) ;
    }
    else
    if( selectedReport.value == "OVER"){
      fnGetreport(lstrFilterMode);
    }
    else
    if( selectedReport.value == "EXP"){
      apiExpiryCard(fdevid, from, to, fcardnumb);
    }
    else
    if( selectedReport.value == "NON"){
      apiCardUsage(fdays);
    }
    else
    if( selectedReport.value == "HIS"){
      apiHistory(fcardnumb,from,to);
    }

  }
  fnClear(){
    reportMode.value='All';
    dropdownvalue.value="Today";
    txtcardno.clear();
    txtUser.clear();
    totalAmount.value =0.0;
    txtdeviceName.clear();
    ad_rechargeList.clear();
    ad_refundList.clear();
    ad_saleList.clear();
    ad_regiterList.clear();
    txtDays.text = "60";
    ad_historyList.clear();
    ad_cardusageList.clear();
    ad_expList.clear();

  }

  fnDataDetailsClear(){
    rechargeDetailList.clear();
    saleDetailList.clear();
    registerDetailList .clear();
    refundDetailList .clear();
    dropdownvalue.value="Today";
    fromto.value=false;
    Get.back();
  }

  /////=====================================================================Export

  Future<void> fnExportRecharge() async{
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

    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
    }


    final Worksheet sheet = workbook.worksheets[0];
    final Style style = workbook.styles.add('Style1');
    style.wrapText = true;
    style.bold = true;
    sheet.getRangeByName('A1:J200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;

    sheet.getRangeByName('A1:J1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP RECHARGE REPORT');
    sheet.getRangeByName('A2:J2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:J3').merge();
    sheet.getRangeByName('A3').setText('REPORT : $from to $to');

    var srno = 4;


    if(fdevid.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('DEVICE : $fdevid');
      srno = srno+1;
    }
    if(fcreatuser.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('CREATE USER : $fcreatuser');
      srno = srno+1;
    }
    if(fcardnumb.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('CARD NO : $fcardnumb');
      srno = srno+1;
    }
    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Doc #');
    sheet.getRangeByName('B$srno').columnWidth = 20.0;
    sheet.getRangeByName('C$srno').setText('Date');
    sheet.getRangeByName('C$srno').columnWidth = 20.0;
    sheet.getRangeByName('D$srno').setText('Card');
    sheet.getRangeByName('D$srno').columnWidth = 20.0;
    sheet.getRangeByName('E$srno').setText('Party Name');
    sheet.getRangeByName('E$srno').columnWidth = 50.0;
    sheet.getRangeByName('F$srno').setText('Mobile');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Email');
    sheet.getRangeByName('G$srno').columnWidth = 30.0;
    sheet.getRangeByName('H$srno').setText('Device Name');
    sheet.getRangeByName('H$srno').columnWidth = 30.0;
    sheet.getRangeByName('I$srno').setText('Create User');
    sheet.getRangeByName('I$srno').columnWidth = 30.0;
    sheet.getRangeByName('J$srno').setText('Amount');
    sheet.getRangeByName('J$srno').columnWidth = 20.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in ad_rechargeList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var doc =   dataList["DOCNO"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();
      var device = dataList["DEVICE_NAME"].toString()??"";
      var user = (dataList["CREATE_USER"]??"").toString().toUpperCase();
      var amount =dataList["AMT"].toString()??"";

      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(doc);
      sheet.getRangeByName('C$srno').setText(date);
      sheet.getRangeByName('D$srno').setText(card);
      sheet.getRangeByName('E$srno').setText(party);
      sheet.getRangeByName('F$srno').setText(mobile);
      sheet.getRangeByName('G$srno').setText(email);
      sheet.getRangeByName('H$srno').setText(device);
      sheet.getRangeByName('I$srno').setText(user);
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
        ..setAttribute('download', 'BeamsTappRecharge$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappRecharge$reportDate.xlsx' : '$path/BeamsTappRecharge$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
  Future<void> fnExportRegister() async{
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

    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
    }


    final Worksheet sheet = workbook.worksheets[0];
    final Style style = workbook.styles.add('Style1');
    style.wrapText = true;
    style.bold = true;
    sheet.getRangeByName('A1:I200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;

    sheet.getRangeByName('A1:I1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP REGISTRATION REPORT');
    sheet.getRangeByName('A2:I2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:I3').merge();
    sheet.getRangeByName('A3').setText('REPORT : $from to $to');

    var srno = 4;


    if(fdevid.isNotEmpty){
      sheet.getRangeByName('A$srno:I$srno').merge();
      sheet.getRangeByName('A$srno').setText('DEVICE : $fdevid');
      srno = srno+1;
    }
    if(fcreatuser.isNotEmpty){
      sheet.getRangeByName('A$srno:I$srno').merge();
      sheet.getRangeByName('A$srno').setText('CREATE USER : $fcreatuser');
      srno = srno+1;
    }
    if(fcardnumb.isNotEmpty){
      sheet.getRangeByName('A$srno:I$srno').merge();
      sheet.getRangeByName('A$srno').setText('CARD NO : $fcardnumb');
      srno = srno+1;
    }
    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Date');
    sheet.getRangeByName('B$srno').columnWidth = 20.0;
    sheet.getRangeByName('C$srno').setText('Card Number');
    sheet.getRangeByName('C$srno').columnWidth = 30.0;
    sheet.getRangeByName('D$srno').setText('Party Name');
    sheet.getRangeByName('D$srno').columnWidth = 50.0;
    sheet.getRangeByName('E$srno').setText('Mobile');
    sheet.getRangeByName('E$srno').columnWidth = 20.0;
    sheet.getRangeByName('F$srno').setText('Email');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Device Name');
    sheet.getRangeByName('G$srno').columnWidth = 30.0;
    sheet.getRangeByName('H$srno').setText('Create User');
    sheet.getRangeByName('H$srno').columnWidth = 30.0;
    sheet.getRangeByName('I$srno').setText('Amount');
    sheet.getRangeByName('I$srno').columnWidth = 20.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in ad_regiterList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["ISSUE_DATE"]));
      var party =   dataList["SLDESCP"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var device = dataList["DEVICE_NAME"].toString()??"";
      var amount =dataList["REG_CHARGE"].toString()??"";
      var user =(dataList["CREATE_USER"]??"").toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();

      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(date);
      sheet.getRangeByName('C$srno').setText(card);
      sheet.getRangeByName('D$srno').setText(party);
      sheet.getRangeByName('E$srno').setText(mobile);
      sheet.getRangeByName('F$srno').setText(email);
      sheet.getRangeByName('G$srno').setText(device);
      sheet.getRangeByName('H$srno').setText(user);
      sheet.getRangeByName('I$srno').setText(amount);

      srno = srno+1;
      dataSrno = dataSrno+1;
    }
    final Range range1 = sheet.getRangeByName('I$tableStart:I$srno');
    range1.cellStyle.hAlign = HAlignType.right;
    final ExcelTable table1 = sheet.tableCollection.create('Table1',  sheet.getRangeByName('A$tableStart:I$srno'));
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
        ..setAttribute('download', 'BeamsTappRegistration$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappRegistration$reportDate.xlsx' : '$path/BeamsTappRegistration$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
  Future<void> fnExportRefund() async{
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

    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
    }


    final Worksheet sheet = workbook.worksheets[0];
    final Style style = workbook.styles.add('Style1');
    style.wrapText = true;
    style.bold = true;
    sheet.getRangeByName('A1:J200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;

    sheet.getRangeByName('A1:J1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP REFUND REPORT');
    sheet.getRangeByName('A2:J2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:J3').merge();
    sheet.getRangeByName('A3').setText('REPORT : $from to $to');

    var srno = 4;


    if(fdevid.isNotEmpty){
      sheet.getRangeByName('A$srno:I$srno').merge();
      sheet.getRangeByName('A$srno').setText('DEVICE : $fdevid');
      srno = srno+1;
    }
    if(fcreatuser.isNotEmpty){
      sheet.getRangeByName('A$srno:I$srno').merge();
      sheet.getRangeByName('A$srno').setText('CREATE USER : $fcreatuser');
      srno = srno+1;
    }
    if(fcardnumb.isNotEmpty){
      sheet.getRangeByName('A$srno:I$srno').merge();
      sheet.getRangeByName('A$srno').setText('CARD NO : $fcardnumb');
      srno = srno+1;
    }
    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Doc #');
    sheet.getRangeByName('B$srno').columnWidth = 20.0;
    sheet.getRangeByName('C$srno').setText('Date');
    sheet.getRangeByName('C$srno').columnWidth = 20.0;
    sheet.getRangeByName('D$srno').setText('Card');
    sheet.getRangeByName('D$srno').columnWidth = 20.0;
    sheet.getRangeByName('E$srno').setText('Party Name');
    sheet.getRangeByName('E$srno').columnWidth = 50.0;
    sheet.getRangeByName('F$srno').setText('Mobile');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Email');
    sheet.getRangeByName('G$srno').columnWidth = 30.0;
    sheet.getRangeByName('H$srno').setText('Device Name');
    sheet.getRangeByName('H$srno').columnWidth = 30.0;
    sheet.getRangeByName('I$srno').setText('Create User');
    sheet.getRangeByName('I$srno').columnWidth = 30.0;
    sheet.getRangeByName('J$srno').setText('Amount');
    sheet.getRangeByName('J$srno').columnWidth = 20.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in ad_refundList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var doc =   dataList["DOCNO"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();
      var device = dataList["DEVICE_NAME"].toString()??"";
      var user = (dataList["CREATE_USER"]).toString().toUpperCase();
      var amount =dataList["AMT"].toString()??"";

      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(doc);
      sheet.getRangeByName('C$srno').setText(date);
      sheet.getRangeByName('D$srno').setText(card);
      sheet.getRangeByName('E$srno').setText(party);
      sheet.getRangeByName('F$srno').setText(mobile);
      sheet.getRangeByName('G$srno').setText(email);
      sheet.getRangeByName('H$srno').setText(device);
      sheet.getRangeByName('I$srno').setText(user);
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
        ..setAttribute('download', 'BeamsTappRefund$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappRefund$reportDate.xlsx' : '$path/BeamsTappRefund$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
  Future<void> fnExportSales() async{
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

    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
    }


    final Worksheet sheet = workbook.worksheets[0];
    final Style style = workbook.styles.add('Style1');
    style.wrapText = true;
    style.bold = true;
    sheet.getRangeByName('A1:J200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;

    sheet.getRangeByName('A1:J1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP SALES REPORT');
    sheet.getRangeByName('A2:J2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:J3').merge();
    sheet.getRangeByName('A3').setText('REPORT : $from to $to');

    var srno = 4;


    if(fdevid.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('DEVICE : $fdevid');
      srno = srno+1;
    }
    if(fcreatuser.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('CREATE USER : $fcreatuser');
      srno = srno+1;
    }
    if(fcardnumb.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('CARD NO : $fcardnumb');
      srno = srno+1;
    }
    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Doc #');
    sheet.getRangeByName('B$srno').columnWidth = 20.0;
    sheet.getRangeByName('C$srno').setText('Date');
    sheet.getRangeByName('C$srno').columnWidth = 20.0;
    sheet.getRangeByName('D$srno').setText('Card');
    sheet.getRangeByName('D$srno').columnWidth = 20.0;
    sheet.getRangeByName('E$srno').setText('Party Name');
    sheet.getRangeByName('E$srno').columnWidth = 50.0;
    sheet.getRangeByName('F$srno').setText('Mobile');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Email');
    sheet.getRangeByName('G$srno').columnWidth = 30.0;;
    sheet.getRangeByName('H$srno').setText('Device Name');
    sheet.getRangeByName('H$srno').columnWidth = 30.0;
    sheet.getRangeByName('I$srno').setText('User');
    sheet.getRangeByName('I$srno').columnWidth = 30.0;
    sheet.getRangeByName('J$srno').setText('Amount');
    sheet.getRangeByName('J$srno').columnWidth = 20.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in ad_saleList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var doc =   dataList["DOCNO"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();
      var device = dataList["DEVICE_NAME"].toString()??"";
      var user = (dataList["CREATE_USER"]).toString().toUpperCase();
      var amount =dataList["NETAMT"].toString()??"";

      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(doc);
      sheet.getRangeByName('C$srno').setText(date);
      sheet.getRangeByName('D$srno').setText(card);
      sheet.getRangeByName('E$srno').setText(party);
      sheet.getRangeByName('F$srno').setText(mobile);
      sheet.getRangeByName('G$srno').setText(email);
      sheet.getRangeByName('H$srno').setText(device);
      sheet.getRangeByName('I$srno').setText(user);
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
        ..setAttribute('download', 'BeamsTappSales$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappSales$reportDate.xlsx' : '$path/BeamsTappSales$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
  Future<void> fnExportExp() async{
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

    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
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

    sheet.getRangeByName('A1:G1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP EXPIRE CARD REPORT');
    sheet.getRangeByName('A2:G2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:G3').merge();
    sheet.getRangeByName('A3').setText('REPORT : $from to $to');

    var srno = 4;
    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Card Number');
    sheet.getRangeByName('B$srno').columnWidth = 30.0;
    sheet.getRangeByName('C$srno').setText('Party Name');
    sheet.getRangeByName('C$srno').columnWidth = 50.0;
    sheet.getRangeByName('D$srno').setText('Mobile');
    sheet.getRangeByName('D$srno').columnWidth = 20.0;
    sheet.getRangeByName('E$srno').setText('Email');
    sheet.getRangeByName('E$srno').columnWidth = 50.0;
    sheet.getRangeByName('F$srno').setText('Expire Date');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Balance');
    sheet.getRangeByName('G$srno').columnWidth = 30.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in ad_expList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["EXP_DATE"]));
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();
      var amount =dataList["BALANCE"].toString()??"";

      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(card);
      sheet.getRangeByName('C$srno').setText(party);
      sheet.getRangeByName('D$srno').setText(mobile);
      sheet.getRangeByName('E$srno').setText(email);
      sheet.getRangeByName('F$srno').setText(date);
      sheet.getRangeByName('G$srno').setText(amount);

      srno = srno+1;
      dataSrno = dataSrno+1;
    }
    final Range range1 = sheet.getRangeByName('G$tableStart:G$srno');
    range1.cellStyle.hAlign = HAlignType.right;
    final ExcelTable table1 = sheet.tableCollection.create('Table1',  sheet.getRangeByName('A$tableStart:G$srno'));
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
        ..setAttribute('download', 'BeamsTappExpire$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappExpire$reportDate.xlsx' : '$path/BeamsTappExpire$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
  Future<void> fnExportUsage() async{
    //Create a new Excel Document.
    final Workbook workbook = Workbook(1);


    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
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

    sheet.getRangeByName('A1:G1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP INACTIVE CARDS REPORT');
    sheet.getRangeByName('A2:G2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:G3').merge();
    sheet.getRangeByName('A3').setText('DAYS : $fdays');

    var srno = 4;
    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Card Number');
    sheet.getRangeByName('B$srno').columnWidth = 30.0;
    sheet.getRangeByName('C$srno').setText('Party Name');
    sheet.getRangeByName('C$srno').columnWidth = 50.0;
    sheet.getRangeByName('D$srno').setText('Mobile');
    sheet.getRangeByName('D$srno').columnWidth = 20.0;
    sheet.getRangeByName('E$srno').setText('Email');
    sheet.getRangeByName('E$srno').columnWidth = 50.0;
    sheet.getRangeByName('F$srno').setText('Expire Date');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Balance');
    sheet.getRangeByName('G$srno').columnWidth = 30.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno  =1;
    for(var e in ad_cardusageList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["EXP_DATE"]));
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();
      var amount =dataList["BALANCE"].toString()??"";

      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(card);
      sheet.getRangeByName('C$srno').setText(party);
      sheet.getRangeByName('D$srno').setText(mobile);
      sheet.getRangeByName('E$srno').setText(email);
      sheet.getRangeByName('F$srno').setText(date);
      sheet.getRangeByName('G$srno').setText(amount);

      srno = srno+1;
      dataSrno = dataSrno+1;
    }
    final Range range1 = sheet.getRangeByName('G$tableStart:G$srno');
    range1.cellStyle.hAlign = HAlignType.right;
    final ExcelTable table1 = sheet.tableCollection.create('Table1',  sheet.getRangeByName('A$tableStart:G$srno'));
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
        ..setAttribute('download', 'BeamsTappUsage$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappUsage$reportDate.xlsx' : '$path/BeamsTappUsage$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
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

    var fdevid = txtdeviceName.text;
    var fcreatuser =txtUser.text;
    var fcardnumb =txtcardno.text;
    var fdays = txtDays.text;
    if(fdays.isEmpty){
      fdays = "60";
      txtDays.text =fdays;
    }

    if(dropdownDeviceItemsValue.value=="All"){
      fdevid = "";
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

    if(fdevid.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('DEVICE : $fdevid');
      srno = srno+1;
    }
    if(fcardnumb.isNotEmpty){
      sheet.getRangeByName('A$srno:J$srno').merge();
      sheet.getRangeByName('A$srno').setText('CARD NO : $fcardnumb');
      srno = srno+1;
    }

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
    for(var e in ad_historyList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var head = dataList["TITLE"].toString().toUpperCase()??"";
      var docno = dataList["DOCNO"].toString().toUpperCase()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var email = dataList["EMAIL"].toString();
      var amount =dataList["AMT"].toString()??"";
      var device =dataList["DEVICE_NAME"].toString()??"";


      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(head);
      sheet.getRangeByName('C$srno').setText(docno);
      sheet.getRangeByName('D$srno').setText(date);
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
  Future<void> fnExportDetails(mode,head) async{
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
    sheet.getRangeByName('A1:J200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;

    sheet.getRangeByName('A1:J1').merge();
    sheet.getRangeByName('A1').setText(head);
    sheet.getRangeByName('A2:J2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    var srno = 3;

    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Sr.No');
    sheet.getRangeByName('B$srno').setText('Date');
    sheet.getRangeByName('B$srno').columnWidth = 20.0;
    sheet.getRangeByName('C$srno').setText('Doc#');
    sheet.getRangeByName('C$srno').columnWidth = 20.0;
    sheet.getRangeByName('D$srno').setText('Party Name');
    sheet.getRangeByName('D$srno').columnWidth = 30.0;
    sheet.getRangeByName('E$srno').setText('Mobile');
    sheet.getRangeByName('E$srno').columnWidth = 20.0;
    sheet.getRangeByName('F$srno').setText('Email');
    sheet.getRangeByName('F$srno').columnWidth = 20.0;
    sheet.getRangeByName('G$srno').setText('Card Number');
    sheet.getRangeByName('G$srno').columnWidth = 20.0;
    sheet.getRangeByName('H$srno').setText('Device Name');
    sheet.getRangeByName('H$srno').columnWidth = 20.0;
    sheet.getRangeByName('I$srno').setText('Create User');
    sheet.getRangeByName('I$srno').columnWidth = 20.0;
    sheet.getRangeByName('J$srno').setText('Amount');
    sheet.getRangeByName('J$srno').columnWidth = 20.0;
    // final Range range1 = sheet.getRangeByName('A1:I5');
    // range1.merge();
    srno = srno+1;
    var dataSrno =1;
    var data =  mode=="REC"?rechargeDetailList.value: mode=="REF"?refundDetailList.value: mode=="REG"?registerDetailList.value:saleDetailList.value;
    for(var e in data){


      var dName  = "";
      var dDate  = "";
      var dDoc  = "";
      var dCard  = "";
      var dDeviceName  = "";
      var dUser  = "";
      var dAmount  = "";
      var dMobile  = "";
      var dEmail  = "";

      try{
        dDate = (setDate(15, DateTime.parse(
            mode=="REC"? e.dOCDATE.toString():
            mode=="REF"? e.dOCDATE.toString():
            mode=="REG"? e.iSSUEDATE.toString():
            e.dOCDATE.toString())

        )??"").toString();
      }catch(e){
        dprint(e);
      }

      dName  =  ((mode=="REC"? e.sLDESCP:
      mode=="REF"? e.sLDESCP:
      mode=="REG"? e.sLDESCP:
      e.iTEMDESCP)??"").toString().toUpperCase();


      dDoc  =  ((mode=="REC"? e.dOCNO:
      mode=="REF"? e.dOCNO:
      mode=="REG"? e.iSSUEDOCNO:
      e.dOCNO)??"").toString().toUpperCase();


      dCard  =  ((mode=="REC"? e.cARDNO:
      mode=="REF"? e.cARDNO:
      mode=="REG"?e.cARDNO:
      e.cARDNO)??"").toString().toUpperCase();

      dUser  =  ((mode=="REC"? e.cREATEUSER:
      mode=="REF"? e.cREATEUSER:
      mode=="REG"?e.cREATEUSER:
      e.cREATEUSER)??"").toString().toUpperCase();

      dDeviceName  =  ((mode=="REC"? e.dNAME:
      mode=="REF"? e.dNAME:
      mode=="REG"?e.dNAME:
      e.dNAME)??"").toString().toUpperCase();


      dMobile  =  ((mode=="REC"? e.mOBILE:
      mode=="REF"? e.mOBILE:
      mode=="REG"?e.mOBILE:
      e.mOBILE)??"").toString().toUpperCase();

      dEmail    =  ((mode=="REC"? e.eMAIL:
      mode=="REF"? e.eMAIL:
      mode=="REG"?e.eMAIL:
      e.eMAIL)??"").toString();

      dAmount  =  ((mode=="REC"? mfnDbl(e.aMT):
      mode=="REF"? mfnDbl(e.aMT):
      mode=="REG"?mfnDbl(e.rEGCHARGE):
      mfnDbl(e.nETAMT))??0.00).toStringAsFixed(2);


      sheet.getRangeByName('A$srno').setText(dataSrno.toString());
      sheet.getRangeByName('B$srno').setText(dDate);
      sheet.getRangeByName('C$srno').setText(dDoc);
      sheet.getRangeByName('D$srno').setText(dName);
      sheet.getRangeByName('E$srno').setText(dName);
      sheet.getRangeByName('F$srno').setText(dMobile);
      sheet.getRangeByName('G$srno').setText(dEmail);
      sheet.getRangeByName('H$srno').setText(dDeviceName);
      sheet.getRangeByName('I$srno').setText(dUser);
      sheet.getRangeByName('J$srno').setText(dAmount);

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
        ..setAttribute('download', 'BeamsTappReport$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappReport$reportDate.xlsx' : '$path/BeamsTappReport$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

  Future<void> fnExportReport() async{
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

    var fdevid = txtdeviceName.text;


    final Worksheet sheet = workbook.worksheets[0];
    final Style style = workbook.styles.add('Style1');
    style.wrapText = true;
    style.bold = true;
    sheet.getRangeByName('A1:B200').cellStyle = style;
    final Style style1 = workbook.styles.add('Style2');
    style1.bold = true;
    style1.hAlign = HAlignType.center;
    style1.fontSize = 20;
    style1.fontColor = "#1656A6FF";
    sheet.getRangeByName('A1').cellStyle = style1;


    final Style style3 = workbook.styles.add('Style3');
    style3.hAlign = HAlignType.right;
    style3.bold = true;

    final Style style4 = workbook.styles.add('Style4');
    style4.bold = true;

    sheet.getRangeByName('A1:B1').merge();
    sheet.getRangeByName('A1').setText('BEAMS TAPP REPORT');
    sheet.getRangeByName('A2:B2').merge();
    var formatDate3 =  DateFormat('dd-MM-yyyy hh:mm:ss a');
    var currentDate = formatDate3.format(DateTime.now());
    sheet.getRangeByName('A2').setText('Date/Time Generated  $currentDate');

    sheet.getRangeByName('A3:B3').merge();
    sheet.getRangeByName('A3').setText('REPORT : $from to $to');

    var srno = 4;

    if(fdevid.isNotEmpty){
      sheet.getRangeByName('A$srno:B$srno').merge();
      sheet.getRangeByName('A$srno').setText('DEVICE : $fdevid');
      srno = srno+1;
    }

    srno = srno+1;

    sheet.getRangeByName('A$srno:B$srno').merge();
    sheet.getRangeByName('A$srno').setText('Recharge');
    sheet.getRangeByName('A$srno').cellStyle = style4;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Amount');
    sheet.getRangeByName('B$srno').setText(recahrge.value.rECHARGEAMT!.toStringAsFixed(2));
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Count');
    sheet.getRangeByName('B$srno').setText(recahrge.value.nOOFRECHARGE.toString());
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+2;




    sheet.getRangeByName('A$srno:B$srno').merge();
    sheet.getRangeByName('A$srno').setText('Refund');
    sheet.getRangeByName('A$srno').cellStyle = style4;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Amount');
    sheet.getRangeByName('B$srno').setText(refund.value.reFundAMT!.toStringAsFixed(2));
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Count');
    sheet.getRangeByName('B$srno').setText(refund.value.nOOFREFUND.toString());
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+2;



    sheet.getRangeByName('A$srno:B$srno').merge();
    sheet.getRangeByName('A$srno').setText('Sales');
    sheet.getRangeByName('A$srno').cellStyle = style4;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Amount');
    sheet.getRangeByName('B$srno').setText(sales.value.nETAMT!.toStringAsFixed(2));
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Count');
    sheet.getRangeByName('B$srno').setText(sales.value.nOOFBILL.toString());
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+2;



    sheet.getRangeByName('A$srno:B$srno').merge();
    sheet.getRangeByName('A$srno').setText('Registration');
    sheet.getRangeByName('A$srno').cellStyle = style4;

    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Amount');
    sheet.getRangeByName('B$srno').setText(registeration.value.rEGAMOUNT!.toStringAsFixed(2));
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+1;

    sheet.getRangeByName('A$srno').setText('Count');
    sheet.getRangeByName('B$srno').setText(registeration.value.nOOFCARDS.toString());
    sheet.getRangeByName('B$srno').cellStyle = style3;
    srno = srno+2;



    sheet.getRangeByName('A$srno:B$srno').merge();
    sheet.getRangeByName('A$srno').setText('Collection');
    sheet.getRangeByName('A$srno').cellStyle = style4;
    srno = srno+1;


    var tableStart = srno;

    sheet.getRangeByName('A$srno').setText('Payment Mode');
    sheet.getRangeByName('A$srno').columnWidth = 50.0;
    sheet.getRangeByName('B$srno').setText('Amount');
    sheet.getRangeByName('B$srno').columnWidth = 30.0;

    srno = srno+1;
    var dataSrno =1;

    for(var e in collection){

      sheet.getRangeByName('A$srno').setText(e.pAYMODE.toString());
      sheet.getRangeByName('B$srno').setText(e.aMT.toString());

      srno = srno+1;
      dataSrno = dataSrno+1;
    }
    final Range range1 = sheet.getRangeByName('B$tableStart:B$srno');
    range1.cellStyle.hAlign = HAlignType.right;
    final ExcelTable table1 = sheet.tableCollection.create('Table1',  sheet.getRangeByName('A$tableStart:B$srno'));
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
        ..setAttribute('download', 'BeamsTappReport$reportDate.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\BeamsTappReport$reportDate.xlsx' : '$path/BeamsTappReport$reportDate.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

  Future<void> fnExport(mode) async{

    dprint(mode);

    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

// Represent the starting row.
    final int firstRow = 1;

// Represent the starting column.
    final int firstColumn = 1;

// Represents that the data should be imported horizontally.
    final bool isVertical = false;

    // Create Data Rows for importing.
    final List<excel.ExcelDataRow>? dataRows = mode=="REG"?_buildReportDataRowsforRegister():mode=="RECH"?_buildReportDataRowsforRecharge():mode=="REF"?_buildReportDataRowsforRefund():
    mode=="SAL"?_buildReportDataRowsforSale():mode=="EXP"?_buildReportDataRowsforExpCard():mode=="CRDUS"?_buildReportDataRowsforCardUsage():
    mode=="HIS"?_buildReportDataRowsforHistory():null;

// Import the Data Rows in to Worksheet.
    sheet.importData(dataRows!, 1, 1);

//Import the Object list to Sheet
    //sheet.importList(lstrExportData[0], firstRow, firstColumn, isVertical);
    //sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();

// Save and dispose workbook.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'TimeSheet.xlsx')
        ..click();
    }
    else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\TimeSheet.xlsx' : '$path/TimeSheet.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }

  ////Exccel Register
  List<excel.ExcelDataRow> _buildReportDataRowsforRegister() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getRegisterReports();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {


      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Date', value: dataRow.date),
        excel.ExcelDataCell(
            columnHeader: 'Party Name', value: dataRow.party),
        excel.ExcelDataCell(
            columnHeader: 'Card Number', value: dataRow.card),
        excel.ExcelDataCell(
            columnHeader: 'Device Name', value: dataRow.device),
        excel.ExcelDataCell(
            columnHeader: 'Amount', value: dataRow.amount),


      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getRegisterReports() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_regiterList){


      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["ISSUE_DATE"]));
      var party =   dataList["SLDESCP"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var device = dataList["CREATE_DEVICE"].toString()??"";
      var amount =dataList["REG_CHARGE"].toString()??"";
      var mobile = dataList["MOBILE"].toString();


      reports.add(_Report(srno.toString(), date, party,mobile, card, device, amount,"",""));
      srno=srno+1;

    }
    return reports;
  }

  ////Exccel Recharge
  List<excel.ExcelDataRow> _buildReportDataRowsforRecharge() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getRechargeReports();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {
      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Doc#', value: dataRow.doc),
        excel.ExcelDataCell(
            columnHeader: 'Date', value: dataRow.date),
        excel.ExcelDataCell(
            columnHeader: 'Card Number', value: dataRow.card),
        excel.ExcelDataCell(
            columnHeader: 'Party Name', value: dataRow.party),
        excel.ExcelDataCell(
            columnHeader: 'Device Name', value: dataRow.device),
        excel.ExcelDataCell(
            columnHeader: 'Amount', value: dataRow.amount),
      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getRechargeReports() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_rechargeList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var doc =   dataList["DOCNO"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var party = dataList["SLDESCP"].toString().toUpperCase();
      var mobile = dataList["MOBILE"].toString();
      var device = dataList["CREATE_DEVICE"].toString()??"";
      var amount =dataList["AMT"].toString()??"";



      reports.add(_Report(srno.toString(), date, party,mobile, card, device, amount, doc,""));
      srno=srno+1;

    }
    return reports;
  }

  ////Exccel Refund
  List<excel.ExcelDataRow> _buildReportDataRowsforRefund() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getRefundReport();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {


      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Doc#', value: dataRow.doc),
        excel.ExcelDataCell(
            columnHeader: 'Date', value: dataRow.date),
        excel.ExcelDataCell(
            columnHeader: 'Card Number ', value: dataRow.card),
        excel.ExcelDataCell(
            columnHeader: 'Device Name', value: dataRow.device),
        excel.ExcelDataCell(
            columnHeader: 'Amount', value: dataRow.amount),


      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getRefundReport() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_refundList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var doc =   dataList["DOCNO"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var device = dataList["CREATE_DEVICE"].toString()??"";
      var amount =dataList["AMT"].toString()??"";



      reports.add(_Report(srno.toString(), date, "","", card, device, amount, doc,""));
      srno=srno+1;

    }
    return reports;
  }

  ////Exccel Sale
  List<excel.ExcelDataRow> _buildReportDataRowsforSale() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getSaleReport();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {


      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Doc#', value: dataRow.doc),
        excel.ExcelDataCell(
            columnHeader: 'Date', value: dataRow.date),
        excel.ExcelDataCell(
            columnHeader: 'Card Number ', value: dataRow.card),
        excel.ExcelDataCell(
            columnHeader: 'Device Name', value: dataRow.device),
        excel.ExcelDataCell(
            columnHeader: 'Amount', value: dataRow.amount),


      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getSaleReport() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_saleList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["DOCDATE"]));
      var doc =   dataList["DOCNO"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var device = dataList["CREATE_DEVICE"].toString()??"";
      var amount =dataList["NETAMT"].toString()??"";



      reports.add(_Report(srno.toString(), date, "","", card, device, amount, doc,""));
      srno=srno+1;

    }
    return reports;
  }

  ////Exccel ExpCard
  List<excel.ExcelDataRow> _buildReportDataRowsforExpCard() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getExpCardReport();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {


      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Card Number', value: dataRow.card),
        excel.ExcelDataCell(
            columnHeader: 'Party Name', value: dataRow.party),
        excel.ExcelDataCell(
            columnHeader: 'Expiry Date', value: dataRow.date),

        excel.ExcelDataCell(
            columnHeader: 'Balance', value: dataRow.amount),


      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getExpCardReport() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_expList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["EXP_DATE"]));
      var party =   dataList["SLDESCP"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var amount =dataList["BALANCE"].toString()??"";



      reports.add(_Report(srno.toString(), date, party,"", card, "", amount, "",""));
      srno=srno+1;

    }
    return reports;
  }

  ////Exccel CardUsage
  List<excel.ExcelDataRow> _buildReportDataRowsforCardUsage() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getCardUsageReport();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {


      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Card Number', value: dataRow.card),
        excel.ExcelDataCell(
            columnHeader: 'Party Name', value: dataRow.party),
        excel.ExcelDataCell(
            columnHeader: 'Expiry Date', value: dataRow.date),

        excel.ExcelDataCell(
            columnHeader: 'Balance', value: dataRow.amount),


      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getCardUsageReport() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_cardusageList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList["EXP_DATE"]));
      var party =   dataList["SLDESCP"].toString()??"";
      var card = dataList["CARDNO"].toString().toUpperCase()??"";
      var amount =dataList["BALANCE"].toString()??"";



      reports.add(_Report(srno.toString(), date, party,"", card, "", amount, "",""));
      srno=srno+1;

    }
    return reports;
  }

  ////Exccel History
  List<excel.ExcelDataRow> _buildReportDataRowsforHistory() {
    List<excel.ExcelDataRow> excelDataRows = <excel.ExcelDataRow>[];
    final List<_Report> reports = _getHistoryReport();

    excelDataRows = reports.map<excel.ExcelDataRow>((_Report dataRow) {


      return excel.ExcelDataRow(cells: <excel.ExcelDataCell>[
        excel.ExcelDataCell(columnHeader: 'Sr.No', value: dataRow.srNo),
        excel.ExcelDataCell(
            columnHeader: 'Head', value: dataRow.head),
        excel.ExcelDataCell(
            columnHeader: 'Doc#', value: dataRow.doc),
        excel.ExcelDataCell(
            columnHeader: 'Date', value: dataRow.date),

        excel.ExcelDataCell(
            columnHeader: 'Card Number', value: dataRow.card),


      ]);
    }).toList();

    return excelDataRows;
  }
  List<_Report> _getHistoryReport() {

    final List<_Report> reports = <_Report>[];
    var srno=1;
    for(var e in ad_historyList){

      var dataList=  e;
      var date =setDate(6, DateTime.parse(dataList.dOCDATE));
      var head =   dataList.tITLE.toString()??"";
      var doc =dataList.dOCNO.toString()??"";
      var card =dataList.cARDNO.toString()??"";



      reports.add(_Report(srno.toString(), date, "","", card, "", "", doc, head));
      srno=srno+1;

    }
    return reports;
  }




//==============================================================LOOKUP
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
          // fnGetreport(dropdownvalue.value);
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
  fnUserLookup(){
    Get.to(() => LookupSearch(
      callbackfn: (data) {
        dprint(data);
        if(data!=null){
          txtUser.text =data["USERNAME"].toString();

          // getusername.value=true;
          // txtCounterDesc.text = data["DESCP"].toString();
          // txtCounterCode.text = data["CODE"].toString();

          Get.back();
        }
      },
      table_name: "USERMAST",
      column_names: const [
        {"COLUMN": "USERNAME", 'DISPLAY': "UserName: "},
        {"COLUMN": "USER_CD", 'DISPLAY': "UserCode: "},

      ],
      filter: [



      ],
    )
    );

  }
  fnCardNumbLookup(){
    Get.to(() => LookupSearch(
      callbackfn: (data) {
        dprint(data);
        if(data!=null){
          txtcardno.text =data["CARDNO"].toString().toUpperCase();
          // getusername.value=true;
          // txtCounterDesc.text = data["DESCP"].toString();
          // txtCounterCode.text = data["CODE"].toString();
          // fnGetreport(dropdownvalue.value);
          Get.back();
        }
      },
      table_name: "CUSTOMER_CARDS",
      column_names: const [
        {"COLUMN": "CARDNO", 'DISPLAY': "Card No: "},
        {"COLUMN": "SLDESCP", 'DISPLAY': "Name: "},
        {"COLUMN": "SLCODE", 'DISPLAY': "Slcode: "},

      ],
      filter: [],
    )
    );

  }


//==============================================================api call

  apiReg(from, to, creatuser, cardnumb,fdevid)async{
    try{
      futureform =  apiRepository.apiAdminRegistereReport(fdevid, from, to, creatuser, cardnumb);
      futureform.then((value) => apiRegRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiRegRes(val){
    dprint(val);
    ad_regiterList.value =val["REPORT"];
    totalAmount.value=0.0;
    for (var e in ad_regiterList){
      totalAmount.value = totalAmount.value+mfnDbl(e["REG_CHARGE"]);
    }
  }

  apiSale(devid,  from, to, creatuser, cardnumb)async{
    try{
      futureform =  apiRepository.apiAdminSalesReport(devid, from, to, creatuser, cardnumb);
      futureform.then((value) => apiSaleRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiSaleRes(val){
    dprint("apiSaleRes................");
    dprint(val);
    ad_saleList.value = val["REPORT"];
    totalAmount.value=0.0;
    for (var e in ad_saleList){
      totalAmount.value = totalAmount.value+mfnDbl(e["NETAMT"]);
    }
  }



  apiRecharge(from, to, creatuser, cardnumb,fdevid)async{
    try{

      futureform =  apiRepository.apiAdminRechargeReport(fdevid, from, to, creatuser, cardnumb);
      futureform.then((value) => apiRechargeRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiRechargeRes(val){
    dprint(val);
    ad_rechargeList.value = val["REPORT"];
    totalAmount.value=0.0;
    for (var e in ad_rechargeList){
      totalAmount.value = totalAmount.value+mfnDbl(e["AMT"]);
    }
  }


  apiRefund(from, to, creatuser, cardnumb,fdevid)async{
    try{
      futureform =  apiRepository.apiAdminRefundReport(fdevid, from, to, creatuser, cardnumb);
      futureform.then((value) => apiRefundRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiRefundRes(val){
    dprint(val);
    ad_refundList.value =val["REPORT"];
    totalAmount.value=0.0;
    for (var e in ad_refundList){
      totalAmount.value = totalAmount.value+mfnDbl(e["AMT"]);
    }
  }

  apiExpiryCard(fdevid,from, to, cardnumb)async{
    try{
      futureform =  apiRepository.apiAdminExpireReport(fdevid, from, to, cardnumb);
      futureform.then((value) => apiExpiryCardRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiExpiryCardRes(val){
    dprint(val);
    ad_expList.value =val["REPORT"];

  }

  apiCardUsage(days)async{
    try{
      futureform =  apiRepository.apiAdminCardUsage(days);
      futureform.then((value) => apiCardUsageRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiCardUsageRes(val){
    dprint(val);
    ad_cardusageList.value =val["REPORT"];

  }

  apiHistory(cardnumber,from,to)async{
    try{
      futureform =  apiRepository.apiAdminCardHistory(cardnumber,from,to);
      futureform.then((value) => apiHistoryRes(value));
    }catch(e){
      dprint("fnCardissuePending ::>> ${e.toString()}");
    }
  }
  apiHistoryRes(val){

    dprint("apiHistoryRes....................");
    dprint(val);
    ad_historyList.value=val["REPORT"];
    dprint(ad_historyList.value);
    // totalAmount.value=0.0;
    // for (var e in ad_historyList){
    //   totalAmount.value = totalAmount.value+mfnDbl(e["AMT"]);
    // }
  }




}

class _Report {



  late String srNo;
  late String date;
  late String party;
  late String mobile;
  late String card;
  late String device;
  late String amount;
  late String doc;
  late String head;


  _Report(
      this.srNo,
      this.date,
      this.party,
      this.mobile,
      this.card,
      this.device,
      this.amount,
      this.doc,
      this.head
      );
}

