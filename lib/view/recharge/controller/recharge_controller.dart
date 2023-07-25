import 'dart:typed_data';

import 'package:beams_tapp/common_widgets/CommonAlertDialog.dart';
 
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/intialmode.dart';
  
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/model/card_detailModel.dart';
   
import 'package:beams_tapp/model/customerDetailModel.dart';
     
import 'package:beams_tapp/storage/preference.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

import '../../commonController.dart';


class RechargeController extends GetxController{
  RxBool gotDtas = false.obs;
  RxBool isTaped = true.obs;
  RxBool isAvailable = false.obs ;
  RxString initial_payment_mode = 'Cash'.obs;
  RxString cardnumber="".obs;
  String printCode  ='RECH';
  final TextEditingController txtAmount = TextEditingController();
  RxString customer_name=''.obs;
  RxString customer_email=''.obs;
  RxString slcode =''.obs;
  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  Rx<BluetoothDevice> _device=BluetoothDevice().obs;

  // RxString histryTitle=''.obs;
  // RxString histDocDate=''.obs;
  // RxString histDocno=''.obs;
  // RxDouble histAmount=0.0.obs;
  // RxString customer_gender=''.obs;
  late Future <dynamic> futureform;
  RxList printData  = [].obs;

  RxString customer_mobile=''.obs;
  RxDouble customer_remaingBalnce=0.0.obs;
  RxString cardValidity=''.obs;
  final CommonController commonController = Get.put(CommonController());
 RxList historyList = [].obs;

  final topupFormKey = GlobalKey<FormState>();

  var paymnet_mode = [
    'Cash',
    'Card',
    'Other',
    'Foc',
  ];

  fnOnChangePayment(val){
    initial_payment_mode.value = val;
  }

  ApiRepository apiRepository = ApiRepository();

  Future fnCheckNFCAvailability(context,histrymode) async {
    // Check availability
    isAvailable.value = await NfcManager.instance.isAvailable();
    dprint("AVAILABLE  ${isAvailable.value}");
    if(isAvailable.value){
      dprint("hold..............");
      // ///Payment Enabled
      // cardIssueController.payment_enable.value = true;
      fnTagRead(histrymode);
    }
  }

  fnTaped(context,histrymode)async{
    fnCheckNFCAvailability(context,histrymode);
    isTaped.value = false;
    // if(val == false){
    //   dprint("tap function working}");
    //   checkNFCAvailability();
    //   // if(isAvailable==false){
    //   //   isTaped.value = true;
    //   //   dprint(isTaped.value);
    //   // };
    // }else{
    //   Get.to(RechargeScreen());
    // }

  }

  ValueNotifier<dynamic> result = ValueNotifier(null);

  void fnTagRead(histrymode) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        var ndef = Ndef.from(tag);
        var record = ndef?.cachedMessage?.records.first;

        ///Getting serialNumber
        Uint8List identifier= Uint8List.fromList(tag.data["mifareclassic"]['identifier']);
        final String? serialnumb= identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');

        dprint("identifierddff  ${serialnumb}");
        // commonController.Cardserial_number.value = serialnumb!;
        if(serialnumb != null){
          dprint("Gotdataaaaaas ${gotDtas.value}");
          fnCardDetails(serialnumb,histrymode);
          await NfcManager.instance.stopSession();
        }
        result.value = tag.data;
        if (result.value == null) return;
        await NfcManager.instance.stopSession();
      } catch (e) {
        await NfcManager.instance.stopSession();
      }
      NfcManager.instance.stopSession();
    });
  }

  fnCustomerData(slcode)async{
    // cstmrdetailLoading.value = true;
    dprint("!! Slcode "+slcode.toString());
    try{
      final responseJson = await apiRepository.apiCustomerData(slcode);
      dprint(responseJson.toString());
      CustomerDetailsModel customerDetailsModel = CustomerDetailsModel.fromJson(responseJson[0]);
      DateTime dob = DateTime.parse(customerDetailsModel.dOB.toString());
      print(dob); // 2020-01-02 03:04:05.000
      // cstmrdetailLoading.value = false;
      gotDtas.value=true;
      customer_name.value = customerDetailsModel.sLDESCP.toString();
      customer_email.value = customerDetailsModel.eMAIL.toString();
      // customer_dob.value = setDate(13,dob);
      customer_mobile.value = customerDetailsModel.mOBILE.toString();
      // customer_city.value = customerDetailsModel.cITY.toString();

    }catch(e){
      // cstmrdetailLoading.value = false;
      // CustomToast.showToast(
      //     e.toString(), ToastType.error, ToastPositionType.end);
      dprint("!! @@@@::>> "+e.toString());
    }


  }

  fnCardDetails(cardnumb,histrymode)async{
    dprint("histrymodehistrymodehistrymode ${histrymode}");
    // cstmrdetailLoading.value = true;

    var devid = await  Prefs.getString(AppStrings.deviceId);
    dprint("DEVICE IDDD ${devid}");
    try{
      final responseJson = await apiRepository.apiCardDetails(cardnumb,devid,histrymode);
      dprint(responseJson.toString());
      CardDetailsModel cardDetailsModel = CardDetailsModel.fromJson(responseJson);


      if(cardDetailsModel.sTATUS=="1"){
        historyList.value = cardDetailsModel.hISTORY! ;
        dprint("bbbbbbb");
        cardnumber.value =cardnumb;
        gotDtas.value =true;
        customer_name.value = cardDetailsModel.dATA![0].sLDESCP!;
        customer_email.value =cardDetailsModel.dATA![0].eMAIL!;
        customer_mobile.value =cardDetailsModel.dATA![0].mOBILE!;
        slcode.value = cardDetailsModel.dATA![0].sLCODE!;
        customer_remaingBalnce.value = cardDetailsModel.dATA![0].aMOUNT! as double;
        cardValidity.value = cardDetailsModel.dATA![0].expDate!;
        // histryTitle.value = cardDetailsModel.hISTORY![0].tITLE!;
        // histDocDate.value = cardDetailsModel.hISTORY![0].dOCDATE!;
        // histDocno.value = cardDetailsModel.hISTORY![0].dOCNO!;
        // histAmount.value =  mfnDbl(cardDetailsModel.hISTORY![0].aMT!) ;
        dprint("!!!!!");
        dprint(historyList[0].dOCNO.toString());
        update();
      }else if(cardDetailsModel.sTATUS=="0"){
        CustomToast.showToast(
            cardDetailsModel.mSG.toString(), ToastType.error, ToastPositionType.end);
        fnTagRead("N");
        gotDtas.value = false;
      }else{
        gotDtas.value =false;
        fnTagRead("N");
        CustomToast.showToast(
            cardDetailsModel.mSG.toString(), ToastType.error, ToastPositionType.end);
      }



    //   DateTime dob = DateTime.parse(customerDetailsModel.dOB.toString());
    //  print(dob); // 2020-01-02 03:04:05.000


    }catch(e){
      // cstmrdetailLoading.value = false;
      // CustomToast.showToast(
      //     e.toString(), ToastType.error, ToastPositionType.end);
      dprint("!! @@@@::>> "+e.toString());
    }


  }

  fnResetDatas(){
    gotDtas.value =false;
    isTaped.value =true;
    customer_name.value="";

    cardnumber.value ="";
    txtAmount.clear();
    initial_payment_mode.value = 'Cash';
    update();
  }


  fnTopup(topupamount, cardnumber, paymode,returnyn,partyname)async {

    dprint("caaaaaaaaaaaar  ${customer_name.value.toString()}");
    dprint("caaaaaaaaaaaar  ${cardnumber.toString()}");
    var pcode = printCode;
    if(returnyn=="Y"){
      pcode ="RTN";
    }

       try {
         var devid = await  Prefs.getString(AppStrings.deviceId);
         dprint("DEVICE IDDD ${devid}");
         final responseJson = await apiRepository.apiTopup(topupamount, cardnumber, paymode,devid);
         dprint(responseJson.toString());
         CommonModel commonModel = CommonModel.fromJson(responseJson[0]);

         if(commonModel.sTATUS=="1"){
           CustomToast.showToast(
               commonModel.mSG.toString(), ToastType.success, ToastPositionType.end);
               if(paymode == "Cash"){
                 fnOpenDrawer();
               }
           Get.off(()=>(SuccessScreen(sldesc: partyname.toString().toUpperCase(),slcode: slcode.value,amount: topupamount,transaction_id: commonModel.cODE,card_id:cardnumber.toString().toUpperCase(),date: setDate(16,DateTime.now()),printCode: pcode,balance: commonModel.bALANCE,)));
         }else{
           CustomToast.showToast(
               commonModel.mSG.toString(), ToastType.error, ToastPositionType.end);
         }
         // cstmrdetailLoading.value = false;
       }catch(e){
         CustomToast.showToast(
             e.toString(), ToastType.error, ToastPositionType.end);
         dprint("!! @@@@::>> "+e.toString());
       }

    }



  fnPay(context,topupamount, cardnumber, paymode,returnyn,partyname) {
    if(topupamount <= 0){
      return Get.showSnackbar(
        const GetSnackBar(
          message: 'Please Enter Valid Amount',
          duration: Duration(seconds: 2),
        ),
      );
    }

    if(returnyn == "Y"){
      topupamount =topupamount *-1;
    }

    dprint(topupFormKey.currentState!.validate());
    if (topupFormKey.currentState!.validate()) {
      return showDialog(
          context: context,
          builder: (context) =>
              CommonAlertDialog(onpressed: () {
                fnTopup(topupamount, cardnumber, paymode,returnyn,partyname);
                fnResetDatas();
              }, alertmode: Alertmode.proceed,
              )
      );
    } else{
      dprint("nooovalidate");
    }

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
            Duration(seconds: 2),
                () {
              if (commonController.printYn.value == "Y") {
       //         fnPrint();
                  fnPrint();
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
      commonController.wstrSunmiDevice.value=="Y"? fnsunmiPrintText():fnPrint();
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
            content: "   ${d.dNAME.toString().toUpperCase()}",
            size: 8,
          )
          );
          list.add(LineText(
            type: type == "T" ? LineText.TYPE_TEXT : type == "I" ? LineText
                .TYPE_IMAGE : LineText.TYPE_TEXT,
            content: "   ${d.cREATEUSER.toString().toUpperCase()}",
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
            content: "   PARTY : ${customer_name.value.toString().toUpperCase()}",
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
            value = (title + " " + customer_name.value);
          }
          else if (key == "SLDESCP") {
            value = (title + " " + customer_name.value.toString().toUpperCase());
          }
          else if (key == "MOBILE") {
            value = (title + " " + customer_mobile.value.toString().toUpperCase());
          }
          else if (key == "EMAIL") {
            value = (title + " " + customer_email.value.toString().toUpperCase());
          }
          else if (key == "AMT") {
            value = (title + " " +mfnDbl("amount").toString());
          }
          else if (key == "CARD") {
            value = (title + "  " + cardnumber.toString().toUpperCase());
          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {
            value = (title + " " + devid.toString());
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString());
          }
          else if (key == "FILTER") {
            value = (title);
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
  fnOpenDrawer(){
    if(commonController.wstrPrinterPath.value.isEmpty){
      return;
    }
    futureform = apiRepository.apiOpenDrawer(commonController.wstrPrinterPath.value);
  }

  //=============================================================SUNMIPRINTER


  Future fnsunmiPrintText() async {

    var devid = await  Prefs.getString(AppStrings.deviceId);
    var devName = await  Prefs.getString(AppStrings.phonmodel);
    dprint("NAME>>> ${slcode.toString()}");

    dprint("devid>>> ${devid.toString()}");
    dprint("devName>>> ${devName.toString()}");
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    // await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);




   // List list = [];

    for(var e in printData.value) {

      var type = e["TYPE"] ?? "";
      var key = e["KEY"] ?? "";
      if (type == "L") {
        // list.add(SunmiPrinter.lineWrap(2));
        SunmiPrinter.lineWrap(1);
        //  list.add(LineText(linefeed: e["FEED"] ?? 1));
      }
      else if (key == "DATA") {
        var srno  = 1;
        for(var d in historyList) {
          var docdate = "";
          try {
            docdate = setDate(15, DateTime.parse(d.dOCDATE.toString()));
          } catch (e) {}
         SunmiPrinter.printText(
            "$srno. ${d.tITLE}",

          );
          SunmiPrinter.printText("   ${d.dOCNO.toString()}");
          SunmiPrinter.printText("   ${docdate.toString()}");

              SunmiPrinter.printText("   ${d.dNAME.toString().toUpperCase()}");
        SunmiPrinter.printText(
              "   ${d.cREATEUSER.toString().toUpperCase()}");
          SunmiPrinter.printText(" ");
        SunmiPrinter.printText(
              "   ${d.cARDNO.toString().toUpperCase()}");
          SunmiPrinter.printText(
              "   PARTY : ${customer_name.value.toString().toUpperCase()}");

              SunmiPrinter.printText("     ${mfnDbl(d.aMT).toStringAsFixed(2)}",
                  style: SunmiStyle(align: SunmiPrintAlign.RIGHT)
          );
          srno = srno + 1;
        }
      }

      else {
        var title = e["TITLE"] ?? "";
        var key = e["KEY"] ?? "";
        var zoom = e["ZOOM"] ?? 1;
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
            value = (title + " " + customer_name.value);
          }
          else if (key == "SLDESCP") {
            value = (title + " " + customer_name.value.toString().toUpperCase());
          }
          else if (key == "MOBILE") {
            value = (title + " " + customer_mobile.value.toString().toUpperCase());
          }
          else if (key == "EMAIL") {
            value = (title + " " + customer_email.value.toString().toUpperCase());
          }
          else if (key == "AMT") {
            value = (title + " " +mfnDbl("amount").toString());
          }
          else if (key == "CARD") {
            value = (title + "  " + cardnumber.toString().toUpperCase());
          }
          /////FROM SHAREDPREFERNCE
          else if (key == "DEVICEID") {
            value = (title + " " + devid.toString());
          }
          else if (key == "DEVICENAME") {
            value = (title + " " + devName.toString());
          }
          else if (key == "FILTER") {
            value = (title);
          }
        }
        // else if(value.toString().isNotEmpty && key.toString().isEmpty){
        //   value = (value.toString());
        // }

        dprint("ALIGN>>>> ${align}");
        dprint("VALUE>>>> ${value}");


            SunmiPrinter.printText(
              value,
              style:SunmiStyle(
                fontSize: value.toString().isNotEmpty &&weight==1 && zoom==2?SunmiFontSize.XL:SunmiFontSize.MD,
                // fontSize: value.toString().isNotEmpty && weight==1?SunmiFontSize.LG:SunmiFontSize.MD,
                align: align == "L" ? SunmiPrintAlign.LEFT : align == "C" ? SunmiPrintAlign.CENTER: align == "R" ? SunmiPrintAlign.RIGHT :SunmiPrintAlign.LEFT,
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

}