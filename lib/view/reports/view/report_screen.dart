import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/filterMode.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/model/collectnReportModel.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/reports/controller/report_controller.dart';
import 'package:beams_tapp/view/reports/view/report_details.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportController reportController = Get.put(ReportController());
  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  final CommonController commonController = Get.put(CommonController());


  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";



  bool _connected = false;
  BluetoothDevice? _device;


  @override
  void initState() {
    dprint("Reportt screeen ${reportController.dropdownvalue.value}");
    reportController.fnGetreport("Today");

    if(commonController.wstrSunmiDevice.value=="Y"){
    sunmiPrintInitState();
    }

   // fnBlutoothConnect();
    // TODO: implement initState

    super.initState();
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
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }
  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw(AppStrings.report, AppColors.white, 20, FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () => reportController.fnPrintSetup()
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: commonBoxDecoration(AppColors.appBgGreyshde),
          child: Padding(
            padding: const EdgeInsets.only(top: 17, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithUnderLine(
                  title: AppStrings.report,
                ),
                gapHC(20),
                Obx(
                  () => Row(
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
                          value: reportController.dropdownDeviceItemsValue.value.toString(),
                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 13),

                          // Array list of items
                          items: reportController.deviceItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: tcnw(items, AppColors.fontcolor, 12,
                                  TextAlign.center, FontWeight.w300),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            reportController.fnOnChnageDeviceItems(value,"","");
                          },
                        ),
                      ):SizedBox(),
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
                          value: reportController.dropdownvalue.value.toString(),
                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 13),

                          // Array list of items
                          items: reportController.items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: tcnw(items, AppColors.fontcolor, 12,
                                  TextAlign.center, FontWeight.w300),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            reportController.fnOnChnagedDay(value,"report","");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                gapHC(10),
                Obx(() => reportController.fromto.value  ? wFromTo()
                    : const SizedBox()),
                gapHC(10),
                Obx(() => reportController.choosedevice.value ? wChooseDeviceField()
                    : const SizedBox()),
                gapHC(8),
                Obx(() => Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapHC(10),
                      tc("Recharge", AppColors.fontcolor, 16),
                      gapHC(5),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          Get.to(const ReportDetailScreen(reportMode: "REC", title: "Recharge"));
                       //   reportController.dropdownvalue.value = 'Today';
                        },
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.lightfontcolor.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(5)),
                            // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tsw("Amount", AppColors.fontcolor, 15,FontWeight.w500),
                                      tsw(reportController.recahrge.value.rECHARGEAMT.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ts("Number Of Cards", AppColors.fontcolor, 12),
                                      tsw(reportController.recahrge.value.nOOFRECHARGE.toString(), AppColors.fontcolor, 12,FontWeight.w500),
                                    ],
                                  ),

                                ],
                              ),
                            )),
                      ),
                      gapHC(15),
                      tc("Refund", AppColors.fontcolor, 16),
                      gapHC(5),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          Get.to(const ReportDetailScreen(reportMode: "REF", title: "Refund"));
                          //   reportController.dropdownvalue.value = 'Today';
                        },
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.lightfontcolor.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(5)),
                            // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tsw("Amount", AppColors.fontcolor, 15,FontWeight.w500),
                                      tsw(reportController.refund.value.reFundAMT.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ts("Number Of Cards", AppColors.fontcolor, 12),
                                      tsw(reportController.refund.value.nOOFREFUND.toString(), AppColors.fontcolor, 12,FontWeight.w500),
                                    ],
                                  ),

                                ],
                              ),
                            )),
                      ),
                      gapHC(15),
                      tc("Sales", AppColors.fontcolor, 16),
                      gapHC(5),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          Get.to(const ReportDetailScreen(reportMode: "SAL", title: "Sales"));
                         // reportController.dropdownvalue.value = 'Today';
                        },
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.lightfontcolor.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(5)),
                            // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tsw("Amount", AppColors.fontcolor, 15,FontWeight.w500),
                                      tsw(reportController.sales.value.nETAMT.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ts("Number Of Bills", AppColors.fontcolor, 12),
                                      tsw(reportController.sales.value.nOOFBILL.toString(), AppColors.fontcolor, 12,FontWeight.w500),
                                    ],
                                  ),

                                ],
                              ),
                            )),
                      ),
                      gapHC(15),
                      tc("New Registration", AppColors.fontcolor, 16),
                      gapHC(5),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          Get.to(const ReportDetailScreen(reportMode: "REG", title: "New Registration"));
                         // reportController.dropdownvalue.value = 'Today';
                        },
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.lightfontcolor.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(5)),
                            // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tsw("Number Of Registration", AppColors.fontcolor, 15,FontWeight.w500),
                                      tsw(reportController.registeration.value.nOOFCARDS.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                    ],
                                  ),
                                  gapHC(3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ts("Amount Collected", AppColors.fontcolor, 12),
                                      tsw(reportController.registeration.value.rEGAMOUNT.toString(), AppColors.fontcolor, 12,FontWeight.w500),

                                    ],
                                  ),

                                ],
                              ),
                            )),
                      ),
                      gapHC(15),
                      tc("Collection Summary", AppColors.fontcolor, 16),
                      gapHC(5),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.lightfontcolor.withOpacity(0.30),
                              borderRadius: BorderRadius.circular(5)),
                          // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: wCollectionList(),
                            ),
                          )),
                      gapHC(15),
                    ],
                  ),
                ),),

                gapHC(10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //=================================WIDEGT
  Widget wFromTo() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Bounce(
              onPressed: () {

                reportController.wSelectDate(context, DateMode.from,"report","");
              },
              duration: const Duration(milliseconds: 110),
              child: Material(
                elevation: 9,
                shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: tc(
                        DateFormat('dd-MM-yyyy')
                            .format(reportController.fromcurrentDate.value),
                        AppColors.fontcolor,
                        11)),
              ),
            ),
            tc("to", AppColors.fontcolor, 11),
            Bounce(
              onPressed: () {
                reportController.wSelectDate(context, DateMode.to,"report","");
              },
              duration: const Duration(milliseconds: 110),
              child: Material(
                elevation: 9,
                shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
                borderRadius: BorderRadius.circular(5.0),

                // shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: tc(
                        DateFormat('dd-MM-yyyy')
                            .format(reportController.tocurrentDate.value),
                        AppColors.fontcolor,
                        11)),
              ),
            ),
          ],
        ));
  }
  List<Widget> wCollectionList(){
    List<Widget> rtnList = [];
    var total = 0.0;
    for(var e in reportController.collection){
      rtnList.add( Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tsw(e.pAYMODE.toString(), AppColors.fontcolor, 15,FontWeight.w500),
          tsw(e.aMT?.toStringAsFixed(2) , AppColors.fontcolor, 15,FontWeight.w500),
        ],
      ));
      total = total+ mfnDbl(e.aMT);

    }
    rtnList.add( Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tsw("Total", AppColors.fontcolor, 15,FontWeight.w500),
        tsw(total.toStringAsFixed(2) , AppColors.fontcolor, 15,FontWeight.w500),
      ],
    ));
    return rtnList;
  }
  Widget wChooseDeviceField() {
    dprint("choooosw");
    return SizedBox(
      height: 40,
      child: Padding(
        padding:         const EdgeInsets.symmetric(horizontal: 20,),
        child: GestureDetector(
          onTap: (){
            print("Loookupppppppppppppppppp...");
            reportController.fnDeviceLookup();
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
              controller: reportController.txtdeviceName,
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





}
