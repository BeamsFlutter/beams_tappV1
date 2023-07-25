
import 'package:beams_tapp/adminMode/views/report/view/adminReportDetailsScreen.dart';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common_widgets/CommonAlertDialog.dart';
import '../../../../common_widgets/commonToast.dart';
import '../../../../common_widgets/title_withUnderline.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/dateformates.dart';
import '../../../../constants/enums/filterMode.dart';
import '../../../../constants/enums/intialmode.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../constants/inputFormattor.dart';
import '../../../../constants/string_constant.dart';
import '../../../../constants/styles.dart';
import '../../../../model/commonModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../view/commonController.dart';
import '../../../../view/reports/view/report_details.dart';
import '../controller/adminReport_controller.dart';
class AdminReportScreen extends StatefulWidget {
  const AdminReportScreen({Key? key}) : super(key: key);

  @override
  State<AdminReportScreen> createState() => _AdminReportScreenState();
}

class _AdminReportScreenState extends State<AdminReportScreen> {

  final AdminReportController adminReportController = Get.put(AdminReportController());
  final CommonController commonController = Get.put(CommonController());

  BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  var printData  = [];
  var sideMenu  = [];

  bool _connected = false;
  BluetoothDevice? _device;
  @override
  void dispose() {
    adminReportController.fnClear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    dprint("Reportt screeen ${adminReportController.dropdownvalue.value}");
    adminReportController.selectedReport.value="OVER";
    adminReportController.fnGetreport("Today");
    // fnBlutoothConnect();
    // TODO: implement initState


    sideMenu.clear();
    sideMenu.add({
      "CODE":"OVER",
      "DESCP":"Overview",
      "ICON":"OVER",

    });
    sideMenu.add({
      "CODE":"REG",
      "DESCP":"Registration",
      "ICON":"OVER",
    });
    sideMenu.add({
      "CODE":"RECH",
      "DESCP":"Recharge",
      "ICON":"OVER",
    });

    sideMenu.add({
      "CODE":"REFU",
      "DESCP":"Refund",
      "ICON":"OVER",
    });

    sideMenu.add({
      "CODE":"SALE",
      "DESCP":"Sales",
      "ICON":"OVER",
    });

    sideMenu.add({
      "CODE":"EXP",
      "DESCP":"Expiry Cards",
      "ICON":"OVER",
    });
    sideMenu.add({
      "CODE":"NON",
      "DESCP":"Card Usage",
      "ICON":"OVER",
    });
    sideMenu.add({
      "CODE":"HIS",
      "DESCP":"History",
      "ICON":"OVER",
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: boxDecoration(Colors.white, 10),
        child: Padding(
          padding: const EdgeInsets.only(top: 17, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWithUnderLine(
                title: AppStrings.report,
              ),
              gapHC(20),
              Obx(() => Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: boxBaseDecoration(Colors.blue.withOpacity(0.05), 5),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: boxBaseDecoration(AppColors.lightfontcolor.withOpacity(0.05) , 10),
                          width: 240,
                          child: ListView.builder(
                              itemCount: sideMenu.length,
                              itemBuilder: (context,index){
                                var data  =  sideMenu[index];
                                return Bounce(
                                  onPressed: (){
                                    adminReportController.selectedReport.value = data["CODE"]??"";
                                    adminReportController.fnApply();
                                  },
                                  duration: const Duration(milliseconds: 110),
                                  child: Container(
                                    decoration:adminReportController.selectedReport.value == data["CODE"]?
                                    boxBaseDecoration(AppColors.primarycolor, 5):boxBaseDecoration(Colors.white, 5),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: tc(data["DESCP"]??"",adminReportController.selectedReport.value == data["CODE"]?AppColors.white: AppColors.fontcolor  , 12),
                                  ),
                                );
                              }),
                        ),
                        gapWC(10),
                        Expanded(child:
                        adminReportController.selectedReport.value == "OVER"?
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: boxBaseDecoration(Colors.white, 10),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapHC(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  tc("Recharge", AppColors.fontcolor, 16),
                                  Bounce(
                                    onPressed: (){
                                      adminReportController.fnExportReport();
                                    },
                                    duration: const Duration(milliseconds: 110),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: boxDecoration(AppColors.primarycolor, 30),
                                      child: tc("Export",Colors.white,12),
                                    ),
                                  )
                                ],
                              ),
                              gapHC(15),
                              Bounce(
                                duration: const Duration(milliseconds: 110),
                                onPressed: () {
                                  Get.to(const AdminReportDetailScreen(reportMode: "REC", title: "Recharge"));
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
                                              tsw(adminReportController.recahrge.value.rECHARGEAMT.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                            ],
                                          ),
                                          gapHC(3),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ts("Number Of Cards", AppColors.fontcolor, 12),
                                              tsw(adminReportController.recahrge.value.nOOFRECHARGE.toString(), AppColors.fontcolor, 12,FontWeight.w500),
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
                                  Get.to(const AdminReportDetailScreen(reportMode: "SAL", title: "Sales"));
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
                                              tsw(adminReportController.sales.value.nETAMT.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                            ],
                                          ),
                                          gapHC(3),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ts("Number Of Bills", AppColors.fontcolor, 12),
                                              tsw(adminReportController.sales.value.nOOFBILL.toString(), AppColors.fontcolor, 12,FontWeight.w500),
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
                                  Get.to(const AdminReportDetailScreen(reportMode: "REG", title: "New Registration"));
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
                                              tsw(adminReportController.registeration.value.nOOFCARDS.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                            ],
                                          ),
                                          gapHC(3),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ts("Amount Collected", AppColors.fontcolor, 12),
                                              tsw(adminReportController.registeration.value.rEGAMOUNT.toString(), AppColors.fontcolor, 12,FontWeight.w500),

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
                                  Get.to(const AdminReportDetailScreen(reportMode: "REF", title: "Refund"));
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
                                              tsw(adminReportController.refund.value.reFundAMT.toString(), AppColors.fontcolor, 15,FontWeight.w500),
                                            ],
                                          ),
                                          gapHC(3),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ts("Number Of Cards", AppColors.fontcolor, 12),
                                              tsw(adminReportController.refund.value.nOOFREFUND.toString(), AppColors.fontcolor, 12,FontWeight.w500),
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
                        ):
                        adminReportController.selectedReport.value == "RECH"?
                        wRechargeReport():
                        adminReportController.selectedReport.value == "SALE"?
                        wSalesReport():
                        adminReportController.selectedReport.value == "REG"?
                        wRegReport():
                        adminReportController.selectedReport.value == "REFU"?
                        wRefundReport():
                        adminReportController.selectedReport.value == "EXP"?
                        wExpReport():
                        adminReportController.selectedReport.value == "NON"?
                        wCardUsage():
                        adminReportController.selectedReport.value == "HIS"?
                        wHistory():

                        Column()
                        ),
                        gapWC(10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: boxBaseDecoration(AppColors.lightfontcolor.withOpacity(0.05) , 10),
                          width: 250,
                          child: Column(
                            children: [
                              adminReportController.selectedReport=="NON"?
                              Expanded(child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tcnw("Filter", AppColors.fontcolor, 15,TextAlign.center,FontWeight.w600),
                                    const Divider(thickness: 0.6),
                                    tcnw("Days", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                    gapHC(5),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        // onTap: (){
                                        //
                                        //   adminReportController.fnUserLookup();
                                        // },
                                        showCursor:false,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: InputFormattor.mfnInputFormatters(),
                                        controller: adminReportController.txtDays,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        decoration:  InputDecoration(
                                          hintText: "Days",
                                          fillColor: Colors.white,
                                          hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                                          filled: true,

                                          border:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: AppColors.primarycolor,
                                            ),
                                          ),

                                          // suffixIcon:  Padding(
                                          //   padding: const EdgeInsets.only(right: 20),
                                          //   child: Icon(Icons.search,color: AppColors.primarycolor.withOpacity(0.7),),
                                          // )

                                        ),


                                      ),
                                    )
                                  ],
                                ),
                              )):
                              adminReportController.selectedReport=="HIS"?
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        tcnw("Filter", AppColors.fontcolor, 15,TextAlign.center,FontWeight.w600),
                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Date", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),

                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
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
                                                value: adminReportController.dropdownvalue.value.toString(),
                                                // Down Arrow Icon
                                                icon: const Icon(Icons.arrow_forward_ios_rounded,
                                                    size: 13),

                                                // Array list of items
                                                items: adminReportController.items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: tcnw(items, AppColors.fontcolor, 12,
                                                        TextAlign.center, FontWeight.w300),
                                                  );
                                                }).toList(),
                                                onChanged: (dynamic value) {
                                                  adminReportController.fnOnChnagedDay(value,"report","");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ),

                                        Obx(() => adminReportController.fromto.value  ? wFromTo()
                                            : const SizedBox()),
                                        gapHC(10),


                                        const Divider(thickness: 0.6),

                                        tcnw("Choose Card No", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),
                                        wChooseCardNOField()

                                      ],
                                    ),
                                  ),
                                ),
                              ):
                              adminReportController.selectedReport=="EXP"?
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        tcnw("Filter", AppColors.fontcolor, 15,TextAlign.center,FontWeight.w600),
                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Device", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),
                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
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
                                                value: adminReportController.dropdownDeviceItemsValue.value.toString(),
                                                // Down Arrow Icon
                                                icon: const Icon(Icons.arrow_forward_ios_rounded,
                                                    size: 13),

                                                // Array list of items
                                                items: adminReportController.deviceItems.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: tcnw(items, AppColors.fontcolor, 12,
                                                        TextAlign.center, FontWeight.w300),
                                                  );
                                                }).toList(),
                                                onChanged: (dynamic value) {
                                                  adminReportController.fnOnChnageDeviceItems(value,"","");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ),
                                        gapHC(5),
                                        adminReportController.choosedevice.value? gapHC(0):gapHC(0),
                                        Obx(() => adminReportController.choosedevice.value ? wChooseDeviceField()
                                            : const SizedBox()),
                                        gapHC(5),
                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Date", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),

                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
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
                                                value: adminReportController.dropdownvalue.value.toString(),
                                                // Down Arrow Icon
                                                icon: const Icon(Icons.arrow_forward_ios_rounded,
                                                    size: 13),

                                                // Array list of items
                                                items: adminReportController.items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: tcnw(items, AppColors.fontcolor, 12,
                                                        TextAlign.center, FontWeight.w300),
                                                  );
                                                }).toList(),
                                                onChanged: (dynamic value) {
                                                  adminReportController.fnOnChnagedDay(value,"report","");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ),

                                        Obx(() => adminReportController.fromto.value  ? wFromTo()
                                            : const SizedBox()),
                                        gapHC(10),


                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Card No", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),
                                        wChooseCardNOField()

                                      ],
                                    ),
                                  ),
                                ),
                              ):
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        tcnw("Filter", AppColors.fontcolor, 15,TextAlign.center,FontWeight.w600),
                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Device", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),
                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
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
                                                value: adminReportController.dropdownDeviceItemsValue.value.toString(),
                                                // Down Arrow Icon
                                                icon: const Icon(Icons.arrow_forward_ios_rounded,
                                                    size: 13),

                                                // Array list of items
                                                items: adminReportController.deviceItems.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: tcnw(items, AppColors.fontcolor, 12,
                                                        TextAlign.center, FontWeight.w300),
                                                  );
                                                }).toList(),
                                                onChanged: (dynamic value) {
                                                  adminReportController.fnOnChnageDeviceItems(value,"","");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ),
                                        gapHC(5),
                                        adminReportController.choosedevice.value? gapHC(0):gapHC(0),
                                        Obx(() => adminReportController.choosedevice.value ? wChooseDeviceField()
                                            : const SizedBox()),
                                        gapHC(5),
                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Date", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),

                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
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
                                                value: adminReportController.dropdownvalue.value.toString(),
                                                // Down Arrow Icon
                                                icon: const Icon(Icons.arrow_forward_ios_rounded,
                                                    size: 13),

                                                // Array list of items
                                                items: adminReportController.items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: tcnw(items, AppColors.fontcolor, 12,
                                                        TextAlign.center, FontWeight.w300),
                                                  );
                                                }).toList(),
                                                onChanged: (dynamic value) {
                                                  adminReportController.fnOnChnagedDay(value,"report","");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ),

                                        Obx(() => adminReportController.fromto.value  ? wFromTo()
                                            : const SizedBox()),
                                        gapHC(10),

                                        const Divider(thickness: 0.6),
                                        tcnw("Choose User", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),
                                        wChooseUserField(),
                                        gapHC(5),
                                        const Divider(thickness: 0.6),
                                        tcnw("Choose Card No", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
                                        gapHC(5),
                                        wChooseCardNOField()

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(thickness: 0.6),
                              gapHC(5),
                              Column(
                                children: [
                                  Bounce(
                                    onPressed: (){
                                      adminReportController.fnClear();
                                    },
                                    duration:const Duration(milliseconds: 110),
                                    child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: boxOutlineCustom(Colors.white, 50, Colors.black),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            tcnw("Clear", Colors.black, 14,TextAlign.center,FontWeight.w400),
                                            const Icon(Icons.close,color: Colors.black,size: 15,)
                                          ],
                                        )
                                    ),
                                  ),
                                  gapHC(5),
                                  Bounce(
                                    onPressed: (){
                                      adminReportController.fnApply();
                                    },
                                    duration:const Duration(milliseconds: 110),
                                    child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: boxDecoration(AppColors.primarycolor, 50),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            tcnw("Apply", AppColors.white, 14,TextAlign.center,FontWeight.w400),
                                            const Icon(Icons.check,color: AppColors.white,size: 15,)
                                          ],
                                        )
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 40),
              //   child: CommonButton(
              //     buttoncolor: AppColors.primarycolor,
              //     buttonText: "Print",
              //     onpressed: () async {
              //       // fnPrint();
              //     },
              //     icon: Icons.print,
              //     icon_need: true,
              //   ),
              // ),
              // gapHC(10)
            ],
          ),
        ),
      ),
    );
  }

  //=================================WIDEGT

  Widget wFromTo() {
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapHC(5),
        tcnw("Date From", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
        gapHC(3),
        Bounce(
          onPressed: () {
            adminReportController.wSelectDate(context, DateMode.from,"report","");
          },
          duration: const Duration(milliseconds: 110),
          child: Container(
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.primarycolor,
                  )
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tc(
                      DateFormat('dd-MM-yyyy')
                          .format(adminReportController.fromcurrentDate.value),
                      AppColors.fontcolor,
                      11),
                  gapWC(15),
                  Icon(Icons.calendar_month,color: AppColors.primarycolor.withOpacity(0.7),)
                ],
              )),
        ),
        gapHC(10),
        tcnw("Date To", AppColors.fontcolor, 13, TextAlign.center, FontWeight.w500),
        gapHC(3),
        Bounce(
          onPressed: () {
            adminReportController.wSelectDate(context, DateMode.to,"report","");
          },
          duration: const Duration(milliseconds: 110),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.primarycolor,
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tc(
                      DateFormat('dd-MM-yyyy')
                          .format(adminReportController.tocurrentDate.value),
                      AppColors.fontcolor,
                      11),
                  gapWC(15),
                  Icon(Icons.calendar_month,color: AppColors.primarycolor.withOpacity(0.7),)
                ],
              )),
        ),

      ],
    ));
  }

  Widget wChooseDeviceField() {
    return SizedBox(
      height: 35,
      child: TextFormField(
        showCursor:false,
        onTap: (){
          dprint("choooosw");
          adminReportController.fnDeviceLookup();
        },
        autofocus: false,
        keyboardType: TextInputType.none,
        controller: adminReportController.txtdeviceName,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration:  InputDecoration(
            hintText: "Choose Device",
            fillColor: Colors.white,
            hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.primarycolor,
              ),
            ),

            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child:  Icon(Icons.search,color: AppColors.primarycolor.withOpacity(0.7)),
            )

        ),


      ),
    );
  }
  Widget wChooseUserField() {
    return SizedBox(
      height: 35,
      child: TextFormField(
        onTap: (){

          adminReportController.fnUserLookup();
        },
        showCursor:false,
        autofocus: false,
        keyboardType: TextInputType.none,
        controller: adminReportController.txtUser,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration:  InputDecoration(
            hintText: "Choose User",
            fillColor: Colors.white,
            hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,

            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.primarycolor,
              ),
            ),

            suffixIcon:  Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.search,color: AppColors.primarycolor.withOpacity(0.7),),
            )

        ),


      ),
    );
  }
  Widget wChooseCardNOField() {
    return SizedBox(
      height: 35,
      child: TextFormField(
        showCursor:false,
        onTap: (){
          adminReportController.fnCardNumbLookup();
        },
        autofocus: false,
        keyboardType: TextInputType.none,
        controller: adminReportController.txtcardno,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration:  InputDecoration(
            hintText: "Choose Card No",
            fillColor: Colors.white,
            hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.primarycolor,
              ),
            ),

            suffixIcon:  Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.search,color: AppColors.primarycolor.withOpacity(0.7),),
            )

        ),


      ),
    );
  }


  List<Widget> wCollectionList(){
    List<Widget> rtnList = [];
    var total = 0.0;
    for(var e in adminReportController.collection){
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


  Widget wRowHead(flex,head,align){
    return Flexible(
        flex: flex,
        child: Column(
          crossAxisAlignment:align == "L"? CrossAxisAlignment.start:align == "R"? CrossAxisAlignment.end:CrossAxisAlignment.center,
          children: [
            Row(),
            th(head, Colors.white, 12)
          ],
        )
    );
  }
  Widget wRowDet(flex,head,align){
    return Flexible(
        flex: flex,
        child: Column(
          crossAxisAlignment:align == "L"? CrossAxisAlignment.start:align == "R"? CrossAxisAlignment.end:CrossAxisAlignment.center,
          children: [
            Row(),
            tc(head, Colors.black, 12)
          ],
        )
    );
  }


  Widget wRechargeReport(){
    return Column(
      children: [
        Row(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Recharge Report', Colors.white, 15),
              Bounce(
                onPressed: (){
                  adminReportController.fnExportRecharge();
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              )
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),
              wRowHead(1, "Doc #","L"),
              wRowHead(1, "Date","L"),
              wRowHead(1, "Card Number","L"),
              wRowHead(1, "Party Name","L"),
              wRowHead(1, "Device Name","L"),
              wRowHead(1, "Create User","L"),
              wRowHead(1, "Amount","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_rechargeList.length,
            itemBuilder: (context,index){
              var datas = adminReportController.ad_rechargeList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["DOCDATE"]));
              }catch(e){
                dprint(e);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),
                    wRowDet(1,  datas["DOCNO"].toString(),"L"),
                    wRowDet(1, date.toString(),"L"),
                    wRowDet(1, datas["CARDNO"].toString().toUpperCase(),"L"),
                    Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, datas["DEVICE_NAME"].toString(),"L"),
                    wRowDet(1, datas["CREATE_USER"].toString().toUpperCase(),"L"),
                    wRowDet(1, mfnDbl(datas["AMT"]).toStringAsFixed(2),"R"),
                  ],
                ),
              );
            })
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(Colors.white, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('TOTAL',AppColors.primarycolor , 15),
              tc(adminReportController.totalAmount.value.toStringAsFixed(2),AppColors.primarycolor , 20),
            ],
          ),
        ),
      ],
    );
  }
  Widget wRefundReport(){
    return Column(
      children: [
        Row(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Refund Report', Colors.white, 15),
              Bounce(
                onPressed: (){
                  adminReportController.fnExportRefund();
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              ),
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),
              wRowHead(1, "Doc #","L"),
              wRowHead(1, "Date","L"),
              wRowHead(1, "Card Number","L"),
              wRowHead(2, "Party Name","L"),
              wRowHead(1, "Device Name","L"),
              wRowHead(1, "Create User","L"),
              wRowHead(1, "Amount","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_refundList.length,
            itemBuilder: (context,index){
              var datas = adminReportController.ad_refundList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["DOCDATE"]));
              }catch(e){
                dprint(e);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),
                    wRowDet(1,  datas["DOCNO"].toString(),"L"),
                    wRowDet(1, date.toString(),"L"),
                    wRowDet(1, datas["CARDNO"].toString().toUpperCase(),"L"),
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, datas["DEVICE_NAME"].toString(),"L"),
                    wRowDet(1, (datas["CREATE_USER"]??"").toString().toUpperCase(),"L"),
                    wRowDet(1, mfnDbl(datas["AMT"]).toStringAsFixed(2),"R"),
                  ],
                ),
              );
            })

        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(Colors.white, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('TOTAL',AppColors.primarycolor , 15),
              tc(adminReportController.totalAmount.value.toStringAsFixed(2),AppColors.primarycolor , 20),
            ],
          ),
        ),
      ],
    );
  }
  Widget wSalesReport(){
    return Column(
      children: [
        Row(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Sales Report', Colors.white, 15),
              Bounce(
                onPressed: (){
                  adminReportController.fnExportSales();
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              ),
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),
              wRowHead(1, "Doc #","L"),
              wRowHead(1, "Date","L"),
              wRowHead(1, "Card Number","L"),
              wRowHead(2, "Party Name","L"),
              wRowHead(1, "Device Name","L"),
              wRowHead(1, "User","L"),
              wRowHead(1, "Amount","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_saleList.length,
            itemBuilder: (context,index){
              var datas = adminReportController.ad_saleList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["DOCDATE"]));
              }catch(e){
                dprint(e);
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),
                    wRowDet(1, datas["DOCNO"].toString(),"L"),
                    wRowDet(1, date.toString(),"L"),
                    wRowDet(1, datas["CARDNO"].toString().toUpperCase(),"L"),
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, datas["DEVICE_NAME"].toString(),"L"),
                    wRowDet(1,(datas["CREATE_USER"]).toString().toUpperCase(),"L"),
                    wRowDet(1, mfnDbl(datas["NETAMT"]).toStringAsFixed(2),"R"),
                  ],
                ),
              );
            })

        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(Colors.white, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('TOTAL',AppColors.primarycolor , 15),
              tc(adminReportController.totalAmount.value.toStringAsFixed(2),AppColors.primarycolor , 20),
            ],
          ),
        ),
      ],
    );
  }
  Widget wRegReport(){
    return Column(
      children: [
        Row(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Registration Report', Colors.white, 15),

              Bounce(
                onPressed: (){
                  adminReportController.fnExportRegister();
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              ),
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),
              wRowHead(1, "Date","L"),
              wRowHead(2, "Party Name","L"),
              wRowHead(1, "Card Number","L"),
              wRowHead(1, "Device Name","L"),
              wRowHead(1, "Create User","L"),
              wRowHead(1, "Amount","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_regiterList.length,
            itemBuilder: (context,index){

              var datas = adminReportController.ad_regiterList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["ISSUE_DATE"]));
              }catch(e){
                dprint(e);
              }




              return  Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),
                    wRowDet(1, date.toString(),"L"),
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, datas["CARDNO"].toString().toUpperCase(),"L"),
                    wRowDet(1, datas["DEVICE_NAME"].toString(),"L"),
                    wRowDet(1, datas["CREATE_USER"].toString().toUpperCase(),"L"),
                    wRowDet(1, mfnDbl(datas["REG_CHARGE"]).toStringAsFixed(2),"R"),
                  ],
                ),
              );
            })),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(Colors.white, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('TOTAL',AppColors.primarycolor , 15),
              tc(adminReportController.totalAmount.value.toStringAsFixed(2),AppColors.primarycolor , 20),
            ],
          ),
        ),
      ],
    );
  }
  Widget wExpReport(){
    return Column(
      children: [
        Row(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Expire Card Report', Colors.white, 15),
              Bounce(
                onPressed: (){
                  adminReportController.fnExportExp();
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              ),
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),

              wRowHead(2, "Card Number","L"),
              wRowHead(2, "Party Name","L"),
              wRowHead(1, "Exp Date","L"),
              wRowHead(1, "Balance","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_expList.length,
            itemBuilder: (context,index){
              var datas = adminReportController.ad_expList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["EXP_DATE"]));
              }catch(e){
                dprint(e);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),

                    wRowDet(2, datas["CARDNO"].toString().toUpperCase(),"L"),
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, date.toString(),"L"),
                    wRowDet(1, mfnDbl(datas["BALANCE"]).toStringAsFixed(2),"R"),
                  ],
                ),
              );
            })

        ),

      ],
    );
  }
  Widget wCardUsage(){
    return Column(
      children: [
        Row(),
        Container(

          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Card Usage Report', Colors.white, 15),
              Bounce(
                onPressed: (){
                  adminReportController.fnExportUsage() ;
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              ),
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),

              wRowHead(2, "Card Number","L"),
              wRowHead(2, "Party Name","L"),
              wRowHead(1, "Exp Date","L"),
              wRowHead(1, "Balance","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_cardusageList.length,
            itemBuilder: (context,index){
              var datas = adminReportController.ad_cardusageList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["EXP_DATE"]));
              }catch(e){
                dprint(e);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),

                    wRowDet(2, datas["CARDNO"].toString().toUpperCase(),"L"),
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, date.toString(),"L"),
                    wRowDet(1,mfnDbl(datas["BALANCE"]).toStringAsFixed(2),"R"),
                  ],
                ),
              );
            })

        ),

      ],
    );
  }
  Widget wHistory(){
    return Column(
      children: [
        Row(),
        Container(

          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('History Report', Colors.white, 15),
              Bounce(
                onPressed: (){
                  adminReportController.fnExportHistory();
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: boxDecoration(AppColors.white, 30),
                  child: tc("Export",Colors.black,12),
                ),
              ),
            ],
          ),
        ),
        gapHC(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: boxDecoration(AppColors.primarycolor, 5),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    th('Sr.No', Colors.white, 12)
                  ],
                ),
              ),
              gapWC(10),

              wRowHead(1, "Head","L"),
              wRowHead(1, "Doc #","L"),
              wRowHead(1, "Date","L"),
              wRowHead(1, "Card Number","L"),
              wRowHead(1, "Party Name","L"),
              wRowHead(1, "Device Name","L"),
              wRowHead(1, "Amount","R"),
            ],
          ),
        ),
        gapHC(5),
        Expanded(child: ListView.builder(
            itemCount: adminReportController.ad_historyList.length,
            itemBuilder: (context,index){
              var datas = adminReportController.ad_historyList[index];
              var date ="";
              try{
                date = setDate(6, DateTime.parse(datas["DOCDATE"]));
              }catch(e){
                dprint(e);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          th((index+1).toString(), Colors.black, 12)
                        ],
                      ),
                    ),
                    gapWC(10),
                    wRowDet(1, datas["TITLE"].toString().toUpperCase(),"L"),
                    wRowDet(1, datas["DOCNO"].toString(),"L"),
                    wRowDet(1, date.toString(),"L"),
                    wRowDet(1, datas["CARDNO"].toString().toUpperCase(),"L"),
                    Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            tc((datas["SLDESCP"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["MOBILE"]??"").toString().toUpperCase(), Colors.black, 12),
                            tc((datas["EMAIL"]??"").toString().toUpperCase(), Colors.black, 12),
                          ],
                        )
                    ),
                    wRowDet(1, datas["DEVICE_NAME"].toString().toUpperCase(),"L"),
                    wRowDet(1, datas["AMT"].toString(),"R"),
                  ],
                ),
              );
            })

        ),

      ],
    );
  }











  //=================================PAGE FN
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
            value = (title + " " + 'transaction_id');
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
  fnBlutoothConnect() async {
    List<BtDevice> devices = await flutterbluetoothconnector.getDevices();
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
        await bluetoothPrint.connect(_device!);
        Future.delayed(
          const Duration(seconds: 2),
              () {
            if (commonController.printYn == "Y") {
              fnPrint();
            }
          },
        );
      }
    }
  }
}
