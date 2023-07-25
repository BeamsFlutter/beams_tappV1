import 'dart:io';

import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';

import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/filterMode.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';

import 'package:beams_tapp/constants/styles.dart';import 'package:beams_tapp/view/history/controller/history_controller.dart';
import 'package:beams_tapp/view/reports/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:beams_tapp/constants/common_functn.dart';

import '../../../../constants/inputFormattor.dart';
import '../controller/adminReport_controller.dart';

class AdminReportDetailScreen extends StatefulWidget {
  final String reportMode;
  final String title;
  const AdminReportDetailScreen({Key? key, required this.reportMode, required this.title}) : super(key: key);

  @override
  State<AdminReportDetailScreen> createState() => _AdminReportDetailScreenState();
}

class _AdminReportDetailScreenState extends State<AdminReportDetailScreen> {

  final AdminReportController adminReportController = Get.put(AdminReportController());



  @override
  void initState() {

    adminReportController.fnGetreportDetails(adminReportController.dropdownvalue.value,widget.reportMode);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build Running  ${adminReportController.fromto.value}");
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
                  child: Row(
                    children: [
                      gapWC(20),
                      Expanded(
                          child:
                          Column(
                            children: [
                              Row(),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: boxDecoration(AppColors.primarycolor, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    tc(widget.title.toString(), Colors.white, 15),
                                    Bounce(
                                      onPressed: (){
                                              adminReportController.fnExportDetails(widget.reportMode,widget.title.toString());
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
                                padding: EdgeInsets.all(10),
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
                                    wRowHead(1, "Doc#","L"),
                                    wRowHead(2, "Party","L"),
                                    wRowHead(1, "Card Number","L"),
                                    wRowHead(1, "Device Name","L"),
                                    wRowHead(1, "Create User","L"),
                                    wRowHead(1, "Amount","R"),
                                  ],
                                ),
                              ),
                              gapHC(5),
                              Expanded(child: ListView.builder(
                                  itemCount: widget.reportMode=="REC"?adminReportController.rechargeDetailList.value.length: widget.reportMode=="REF"?adminReportController.refundDetailList.value.length: widget.reportMode=="REG"?adminReportController.registerDetailList.value.length:adminReportController.saleDetailList.value.length,
                                  itemBuilder: (context,index){


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
                                          widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].dOCDATE.toString():
                                          widget.reportMode=="REF"? adminReportController.refundDetailList[index].dOCDATE.toString():
                                          widget.reportMode=="REG"? adminReportController.registerDetailList[index].iSSUEDATE.toString():
                                          adminReportController.saleDetailList[index].dOCDATE.toString())

                                      )??"").toString();
                                    }catch(e){
                                      dprint(e);
                                    }

                                    dName  =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].sLDESCP:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].sLDESCP:
                                    widget.reportMode=="REG"? adminReportController.registerDetailList[index].sLDESCP:
                                    adminReportController.saleDetailList[index].iTEMDESCP)??"").toString().toUpperCase();


                                    dDoc  =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].dOCNO:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].dOCNO:
                                    widget.reportMode=="REG"? adminReportController.registerDetailList[index].iSSUEDOCNO:
                                    adminReportController.saleDetailList[index].dOCNO)??"").toString().toUpperCase();


                                    dCard  =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].cARDNO:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].cARDNO:
                                    widget.reportMode=="REG"?adminReportController.registerDetailList[index].cARDNO:
                                    adminReportController.saleDetailList[index].cARDNO)??"").toString().toUpperCase();

                                    dUser  =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].cREATEUSER:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].cREATEUSER:
                                    widget.reportMode=="REG"?adminReportController.registerDetailList[index].cREATEUSER:
                                    adminReportController.saleDetailList[index].cREATEUSER)??"").toString().toUpperCase();

                                    dDeviceName  =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].dNAME:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].dNAME:
                                    widget.reportMode=="REG"?adminReportController.registerDetailList[index].dNAME:
                                    adminReportController.saleDetailList[index].dNAME)??"").toString().toUpperCase();


                                    dMobile  =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].mOBILE:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].mOBILE:
                                    widget.reportMode=="REG"?adminReportController.registerDetailList[index].mOBILE:
                                    adminReportController.saleDetailList[index].mOBILE)??"").toString().toUpperCase();

                                    dEmail    =  ((widget.reportMode=="REC"? adminReportController.rechargeDetailList[index].eMAIL:
                                    widget.reportMode=="REF"? adminReportController.refundDetailList[index].eMAIL:
                                    widget.reportMode=="REG"?adminReportController.registerDetailList[index].eMAIL:
                                    adminReportController.saleDetailList[index].eMAIL)??"").toString();

                                    dAmount  =  ((widget.reportMode=="REC"? mfnDbl(adminReportController.rechargeDetailList[index].aMT):
                                    widget.reportMode=="REF"? mfnDbl(adminReportController.refundDetailList[index].aMT):
                                    widget.reportMode=="REG"?mfnDbl(adminReportController.registerDetailList[index].rEGCHARGE):
                                    mfnDbl(adminReportController.saleDetailList[index].nETAMT))??0.00).toStringAsFixed(2);



                                    return Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      padding: EdgeInsets.all(10),
                                      decoration: boxDecoration(Colors.white, 5),
                                      child: Row(
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

                                          wRowDet(1, dDate,"L"),
                                          wRowDet(1,dDoc,"L"),
                                          Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(),
                                                  tc(dName, Colors.black, 12),
                                                  tc(dMobile, Colors.black, 12),
                                                  tc(dEmail, Colors.black, 12),
                                                ],
                                              )
                                          ),
                                          wRowDet(1,dCard,"L"),
                                          wRowDet(1,dDeviceName,"L"),
                                          wRowDet(1,dUser,"L"),
                                          wRowDet(1, dAmount,"R"),
                                        ],
                                      ),
                                    );
                                  })

                              ),

                            ],
                          )
                      ),
                      gapWC(20),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: boxBaseDecoration(AppColors.lightfontcolor.withOpacity(0.05) , 10),
                        width: 250,
                        child: Column(
                          children: [

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
                                    adminReportController.fnDataDetailsClear();
                                    // Get.back();
                                  },
                                  duration:const Duration(milliseconds: 110),
                                  child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: boxOutlineCustom(Colors.white, 50, Colors.black),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          tcnw("Close", Colors.black, 14,TextAlign.center,FontWeight.w400),
                                          const Icon(Icons.close,color: Colors.black,size: 15,)
                                        ],
                                      )
                                  ),
                                ),
                                gapHC(5),
                                Bounce(
                                  onPressed: (){
                                    adminReportController.fnGetreportDetails(adminReportController.dropdownvalue.value.toString(),widget.reportMode);
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



}
