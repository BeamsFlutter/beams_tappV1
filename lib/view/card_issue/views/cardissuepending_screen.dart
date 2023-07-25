import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/card_issue/controller/cardissue_controller.dart';
import 'package:beams_tapp/view/card_issue/controller/cardissuepending_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class CardIssuePendingScreen extends StatefulWidget {
  const CardIssuePendingScreen({Key? key}) : super(key: key);

  @override
  State<CardIssuePendingScreen> createState() => _CardIssuePendingScreenState();
}

class _CardIssuePendingScreenState extends State<CardIssuePendingScreen> {

  final CardIssuePendingController cardIssuePendingController = Get.put(CardIssuePendingController());
  final CardIssueController cardIssueController = Get.put(CardIssueController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      cardIssuePendingController.fnCardissuePending();
    });

    // TODO: implement initState
    super.initState();
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
        title: tsw("Card Issue Pending",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          child:  Obx(() => cardIssuePendingController.cardissuependingList.isNotEmpty? Padding(
            padding: const EdgeInsets.only(right: 10,left: 10),
            child: ListView.builder(
              physics:  const BouncingScrollPhysics(),
                itemCount: cardIssuePendingController.cardissuependingList.length,
                itemBuilder: (context,index){
                  var datas = cardIssuePendingController.cardissuependingList[index];
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
                                  tsw(datas["ISSUE_DOCNO"].toString(), AppColors.fontcolor, 12,FontWeight.w600),
                                  gapHC(3),
                                  ts(mfnDbl(datas["REG_CHARGE"]).toString(), AppColors.fontcolor, 15),
                                  gapHC(3),

                                ],

                              ),
                              Bounce(
                                duration: const Duration(milliseconds: 110),
                                onPressed: (){

                                  cardIssueController.issueDocNumb.value = datas["ISSUE_DOCNO"];
                                  cardIssueController.issueDocType.value = datas["ISSUE_DOCTYPE"];
                                  cardIssueController.fnGetbistro(mfnDbl(datas["REG_CHARGE"]),datas["BALANCE"]??"");


                                },

                                child: Container(
                                  width: 80,
                                  padding: const EdgeInsets.only(left: 13,right: 13,top: 6,bottom: 6),
                                  decoration: BoxDecoration(
                                      color: AppColors.secondarycolor,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(child: tsw("Retry", AppColors.white, 13,FontWeight.w700)),
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  );
                }),
          ): Center(
            child: tc("No Data Found", AppColors.lightfontcolor, 14),
          ),)
        ),
      ),
    );
  }
}
