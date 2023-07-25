import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/recharge/controller/recharge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHistory extends StatefulWidget {

  final String cardserailnumb;
  const CustomerHistory({Key? key, required this.cardserailnumb}) : super(key: key);

  @override
  State<CustomerHistory> createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
  final RechargeController rechargeController = Get.put(RechargeController());
  final CommonController commonController = Get.put(CommonController());
  @override
  void initState() {
    // TODO: implement initState
  dprint("serialnumbbbb  :${widget.cardserailnumb}");

  if(widget.cardserailnumb.isNotEmpty){
    // rechargeController.gotDtas.value=true;
    Future.delayed(const Duration(seconds: 1), () {
      rechargeController.fnCardDetails(widget.cardserailnumb,"Y");

      // rechargeController.fnCustomerData(widget.cardserialnumber);
    });

    //Call detailApi with cardnumber
  }
  super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    commonController.Cardserial_number.value="";
    rechargeController.customer_name.value ="";
    rechargeController.isTaped.value=true;
    rechargeController.gotDtas.value=false;



    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw(AppStrings.customer_history,AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () =>rechargeController.historyList.isNotEmpty?rechargeController.fnPrintSetup():null,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Padding(
              padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      th(rechargeController.customer_name.value.toString().toUpperCase(), AppColors.fontcolor, 15),
                      th(commonController.Cardserial_number.value.toUpperCase(), AppColors.fontcolor, 13),
                    ],
                  ),
                  gapHC(4),
                  ts("Email: ${rechargeController.customer_email.value}", AppColors.fontcolor, 12),
                  gapHC(4),
                  ts("Mobile: ${rechargeController.customer_mobile.value}", AppColors.fontcolor, 12),
                  gapHC(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tcnw("Remaining Bal:", AppColors.fontcolor, 18,TextAlign.center,FontWeight.w600),
                      th(rechargeController.customer_remaingBalnce.value.toString(), AppColors.fontcolor, 18),
                    ],
                  ),
                  gapHC(8),
                  Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:rechargeController.historyList.length,
                          itemBuilder: (context,index){
                            dprint(rechargeController.historyList.length);
                            var datalist =rechargeController.historyList.value[index];
                            var docdate = "";
                            try{
                              docdate = setDate(6, DateTime.parse(datalist.dOCDATE.toString()));
                            }catch(e){
                              print(e);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.lightfontcolor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        tsw(datalist.tITLE.toString(), AppColors.fontcolor, 12,FontWeight.w600),
                                        gapHC(3),
                                        ts(datalist.dOCNO.toString(), AppColors.fontcolor, 12),
                                        gapHC(3),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time_rounded,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(docdate, AppColors.fontcolor, 12),
                                          ],
                                        ),

                                        gapHC(3),
                                        Row(
                                          children: [
                                            Icon(Icons.devices_sharp,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts((datalist.dNAME??"").toString(), AppColors.fontcolor, 12),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.verified_user,color: Colors.black,size: 10,),
                                            gapWC(5),
                                            ts(datalist.cREATEUSER.toString().toUpperCase(), AppColors.fontcolor, 12),
                                          ],
                                        ),

                                      ],
                                    ),
                                    th(datalist.aMT.toString(),datalist.tITLE.toString()=="SALE" ?AppColors.subcolor:AppColors.primarycolor, 18),

                                  ],
                                ),
                              ),
                            );
                          }))




                ],
              ),)
            ),
          ),
        ),
      ),
    );
  }
}
