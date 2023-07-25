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

class ReportDetailScreen extends StatefulWidget {
  final String reportMode;
  final String title;
  const ReportDetailScreen({Key? key, required this.reportMode, required this.title}) : super(key: key);

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {

  final ReportController reportController = Get.put(ReportController());

  Widget wFromTo() {
    return   Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Bounce(
          onPressed: (){
            reportController.wSelectDate(context,DateMode.from,"rdetail",widget.reportMode);
          },
          duration: const Duration(milliseconds: 110),
          child: Material(
            elevation: 9,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
            borderRadius:BorderRadius.circular(5.0) ,

            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                child: tc(DateFormat('dd-MM-yyyy').format(reportController.fromcurrentDate.value), AppColors.fontcolor, 11)
            ),
          ),
        ),
        tc("to", AppColors.fontcolor, 11),
        Bounce(
          onPressed: (){
            reportController.wSelectDate(context,DateMode.to,"rdetail",widget.reportMode);
          },
          duration: const Duration(milliseconds: 110),
          child: Material(
            elevation: 9,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.30),
            borderRadius:BorderRadius.circular(5.0) ,

            // shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
            child: Container(

                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                child: tc(DateFormat('dd-MM-yyyy').format(reportController.tocurrentDate.value), AppColors.fontcolor, 11)
            ),
          ),
        ),
      ],
    ));
  }

  @override
  void initState() {

  reportController.fnGetreportDetails(reportController.dropdownvalue.value,widget.reportMode);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build Running  ${reportController.fromto.value}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw(widget.title,AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () async{
            Get.back();
            return  await reportController.fnGetreport(reportController.dropdownvalue.value.toString());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () =>reportController.fnPrintSetupDet(widget.reportMode.toString()),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {

          dprint("willlpoooppp   ${reportController.dropdownvalue.value.toString()}");
          Get.back();
           return  await reportController.fnGetreport(reportController.dropdownvalue.value.toString());
                          },
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: size.height,
            width: size.width,
            decoration:  commonBoxDecoration(AppColors.appBgGreyshde),
            child: Padding(
              padding: const EdgeInsets.only(top: 17,right: 20,left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithUnderLine(title: widget.title,),
                  gapHC(20),
                  Obx(() =>     Align(
                    alignment: Alignment.centerRight,
                    child: Container(

                      height: 23,
                      padding: const EdgeInsets.only(right: 10,left: 10,),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.primarycolor,
                          )),
                      child:   DropdownButton(
                        underline: const SizedBox(),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        // Initial Value
                        value: reportController.dropdownvalue.value.toString(),
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_forward_ios_rounded,size: 13),

                        // Array list of items
                        items: reportController.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: tcnw(items, AppColors.fontcolor, 12,TextAlign.center,FontWeight.w300),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          reportController.fnOnChnagedDay(value,"rdetail",widget.reportMode);
                        },
                        // onChanged: (String? newValue) {
                        //   // setState(() {
                        //   //   dropdownvalue = newValue!;
                        //   // });
                        // },
                      ),
                    ),
                  ),),
                  gapHC(10),

                  Obx(() =>reportController.fromto.value==true ? wFromTo():const SizedBox()),

                  gapHC(8),


                  Obx(() => Expanded(
                    child: ListView.builder(

                        itemCount: widget.reportMode=="REC"?reportController.rechargeDetailList.value.length: widget.reportMode=="REF"?reportController.refundDetailList.value.length: widget.reportMode=="REG"?reportController.registerDetailList.value.length:reportController.saleDetailList.value.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          //   var historyList =reportController.historyList[index];
                          var docdate="";
                          var docnumb="";
                          var itemname="";
                          var cardnumb="";
                          var sldescp="";
                          var device="";
                          var mobile="";
                          var email="";
                          var amount=0.0;
                          var qty =0.0;

                          try{
                            docdate =setDate(15, DateTime.parse(
                                widget.reportMode=="REC"? reportController.rechargeDetailList[index].dOCDATE.toString():
                                widget.reportMode=="REF"? reportController.refundDetailList[index].dOCDATE.toString():
                                widget.reportMode=="REG"? reportController.registerDetailList[index].iSSUEDATE.toString():
                                reportController.saleDetailList[index].dOCDATE.toString())
                            );
                            docnumb =  widget.reportMode=="REC"? reportController.rechargeDetailList[index].dOCNO.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].dOCNO.toString():
                            widget.reportMode=="REG"? reportController.registerDetailList[index].iSSUEDOCNO.toString():
                            reportController.saleDetailList[index].dOCNO.toString();
                            itemname =  widget.reportMode=="REC"? reportController.rechargeDetailList[index].sLDESCP.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].sLDESCP.toString():
                            widget.reportMode=="REG"? reportController.registerDetailList[index].sLDESCP.toString():
                            reportController.saleDetailList[index].sLDESCP??"";
                            amount =  widget.reportMode=="REC"? mfnDbl(reportController.rechargeDetailList[index].aMT):
                            widget.reportMode=="REF"? mfnDbl(reportController.refundDetailList[index].aMT):
                            widget.reportMode=="REG"?mfnDbl(reportController.registerDetailList[index].rEGCHARGE):
                            mfnDbl( reportController.saleDetailList[index].nETAMT.toString());
                            cardnumb =  widget.reportMode=="REC"? reportController.rechargeDetailList[index].cARDNO.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].cARDNO.toString():
                            widget.reportMode=="REG"?reportController.registerDetailList[index].cARDNO.toString():
                            reportController.saleDetailList[index].cARDNO.toString();

                            sldescp = widget.reportMode=="REC"? reportController.rechargeDetailList[index].sLDESCP.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].sLDESCP.toString(): "";

                            device = widget.reportMode=="REC"? reportController.rechargeDetailList[index].dNAME.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].dNAME.toString():
                            widget.reportMode=="SAL"? reportController.saleDetailList[index].dNAME.toString():
                            widget.reportMode=="REG"? reportController.registerDetailList[index].dNAME.toString(): "";

                            mobile = widget.reportMode=="REC"? reportController.rechargeDetailList[index].mOBILE.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].mOBILE.toString():
                            widget.reportMode=="SAL"? (reportController.saleDetailList[index].mOBILE??"").toString():
                            widget.reportMode=="REG"? (reportController.registerDetailList[index].mOBILE??"").toString():
                            "";
                            email = widget.reportMode=="REC"? reportController.rechargeDetailList[index].eMAIL.toString():
                            widget.reportMode=="REF"? reportController.refundDetailList[index].eMAIL.toString():
                            widget.reportMode=="SAL"? reportController.saleDetailList[index].eMAIL.toString():
                            widget.reportMode=="REG"? reportController.registerDetailList[index].eMAIL.toString():
                            "";

                            qty = mfnDbl(reportController.saleDetailList[index].qTY.toString());



                          }catch(e){
                            print(e);
                          }

                          return   Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.lightfontcolor.withOpacity(0.30),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          tsw(widget.title, AppColors.fontcolor, 12,FontWeight.w600),
                                          gapHC(3),

                                          Row(
                                            children: [
                                              Icon(Icons.devices_sharp,color: Colors.black,size: 10,),
                                              gapWC(5),
                                              ts(device, AppColors.fontcolor, 12),
                                            ],
                                          ),
                                          gapHC(3),
                                          //widget.reportMode=="SAL"? ts(qty.toString(), AppColors.fontcolor, 12):const SizedBox(),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_sharp,color: Colors.black,size: 10,),
                                              gapWC(5),
                                              ts(docdate, AppColors.fontcolor, 12),
                                            ],
                                          ),

                                          gapHC(3),
                                          Row(
                                            children: [
                                              Icon(Icons.numbers,color: Colors.black,size: 10,),
                                              gapWC(5),
                                              ts(docnumb, AppColors.fontcolor, 12),
                                            ],
                                          ),

                                          gapHC(3),
                                          Row(
                                            children: [
                                              Icon(Icons.credit_card,color: Colors.black,size: 10,),
                                              gapWC(5),
                                              ts(cardnumb.toUpperCase(), AppColors.fontcolor, 12),
                                            ],
                                          ),
                                          gapHC(3),
                                          Row(
                                            children: [
                                              Icon(Icons.person,color: Colors.black,size: 10,),
                                              gapWC(5),
                                              ts(itemname.toUpperCase(), AppColors.fontcolor, 12),
                                            ],
                                          ),
                                          gapHC(3),
                                          Row(
                                            children: [
                                              Icon(Icons.call,color: Colors.black,size: 10,),
                                              gapWC(5),
                                              ts(mobile.toUpperCase(), AppColors.fontcolor, 12),
                                            ],
                                          ),



                                        ],

                                      ),
                                      tc(amount.toString(), AppColors.fontcolor, 16)

                                    ],
                                  ),
                                )
                            ),
                          );
                        }),
                  ))





                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


