import 'package:beams_tapp/constants/common_functn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/commonbutton.dart';
import '../../../constants/color_code.dart';
import '../../../constants/styles.dart';

class PackageController extends GetxController {

  var wstrPageMode = 'VIEW'.obs;
  Rx<TextEditingController> txtCode =TextEditingController().obs;
  Rx<TextEditingController> txtName =TextEditingController().obs;
  Rx<TextEditingController> txtPrice =TextEditingController().obs;
  Rx<TextEditingController> txtDescription =TextEditingController().obs;
  Rx<TextEditingController> txtTerms1 =TextEditingController().obs;
  Rx<TextEditingController> txtTerms2 =TextEditingController().obs;
  Rx<TextEditingController> txtTerms3 =TextEditingController().obs;

  Rx<TextEditingController> txtADDCode =TextEditingController().obs;
  Rx<TextEditingController> txtADDName =TextEditingController().obs;
  Rx<TextEditingController> txtADDPrice =TextEditingController().obs;
  Rx<TextEditingController> txtADDDuration =TextEditingController().obs;
  Rx<TextEditingController> txtADDMaxGuest =TextEditingController().obs;
  late PageController pageController;
  var selectedPage = 0.obs;
  var selectAll = false.obs;
  var singleselect = false.obs;
  var lstrSelectedPage = "D".obs;
  var pageIndex = 0.obs;
  var lstrPlayAreaList = [
  {
   "name":"playAre",
   "price":"34",
   "duration":"22:3",
   "Max.Guest":"33",
    "code":"1"
  },
    {
      "name":"AFASD",
      "price":"233",
      "duration":"11:3",
      "Max.Guest":"13",    "code":"2"
    },  {
      "name":"dfsf",
      "price":"11",
      "duration":"43:3",
      "Max.Guest":"55",
      "code":"3"
    },  {
      "name":"ghhgfh",
      "price":"86",
      "duration":"02:3",
      "Max.Guest":"66",
      "code":"4"
    },



  ].obs;
  RxList lstrSiteDetailList = [
  {
   "code":"SD2323",
   "desc":"Sdhsdf sdfqwqwe cvddddddddffd",
   "check":false,
  },
    {
      "code":"SD55323",
      "desc":"Sdhsdf sdf feerrrt dddddddffd",
      "check":true,
    },
    {
      "code":"SD223",
      "desc":"Sdhsdf sdf fghgfh ddddffd",
      "check":false,
    },
    {
      "code":"S8763",
      "desc":"Sdhsdf sdf fg hss fdddddddddffd",
      "check":true,
    },
    {
      "code":"SDDF323",
      "desc":"Sdhsdf sd ddddddddffd",
      "check":false,
    },
  ].obs;

  fnChangeCheckBox(code,mode){
  if(mode=="S"){
    var item = lstrSiteDetailList.where((element) => element["code"] == code).toList();

    item[0]["check"] = (item[0]["check"]) == true ? false : true;
    dprint("#################  ${item[0]["check"]}");
    update();
  }


    // var item = lstrSiteDetailList.map((element) => null);


  }

  fnEditPlayAreas(code,context){
    var item = lstrPlayAreaList.where((element) => element["code"] == code).toList();
    dprint("IIIIII ${item}");
    var playArea = item[0]["name"];
    var price = item[0]["price"];
    var duration = item[0]["duration"];
    var maxGuest = item[0]["Max.Guest"];
    var Code = code;
    txtADDName.value.text = playArea.toString();
    txtADDPrice.value.text = price.toString();
    txtADDDuration.value.text = duration.toString();
    txtADDMaxGuest.value.text = maxGuest.toString();
    txtADDCode.value.text = Code.toString();
    wAddPlayAreaBottomSheet(context,"Edit");
  update();

  }

  fnDeletePlayArea(code){
    var item = lstrPlayAreaList.where((element) => element["code"] == code).toList();
    dprint("OOO ${item}");
    dprint("COOODD ${code}");

    lstrPlayAreaList.value.removeWhere((e) => e["code"] == code);
    dprint("LLLL  ${lstrPlayAreaList}");
  update();

  }

  wAddPlayAreaBottomSheet(context,mode) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                              suffixIcon: Icon(Icons.search,
                                  color: Colors.black, size: 20),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.appAdminBgLightBlue),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor: AppColors.appAdminBgLightBlue,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.appAdminBgLightBlue),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        gapHC(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tBody("Name", AppColors.appAdminColor2, TextAlign.start),
                            wCommonTextFieldAdminV1(
                              txtADDName.value,
                            )
                          ],
                        ),
                        gapHC(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tBody("Price", AppColors.appAdminColor2, TextAlign.start),
                            wCommonTextFieldAdminV1(
                              txtADDPrice.value,
                            )
                          ],
                        ),
                        gapHC(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tBody("Duration", AppColors.appAdminColor2,
                                TextAlign.start),
                            wCommonTextFieldAdminV1(
                              txtADDDuration.value,
                            )
                          ],
                        ),
                        gapHC(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tBody("MaX.Guest", AppColors.appAdminColor2,
                                TextAlign.start),
                            wCommonTextFieldAdminV1(
                              txtADDMaxGuest.value,
                            )
                          ],
                        ),
                        gapHC(20),
                        AdminV1CommonButton(
                          buttoncolor: AppColors.appAdminColor1,
                          buttonText: "Done",
                          onpressed: () {
                            Get.back();
                            if(mode=="Edit"){
                              dprint("EDit.........");
                              txtADDName.value.text=txtADDName.value.text;
                              txtADDPrice.value.text= txtADDPrice.value.text;
                              txtADDDuration.value.text= txtADDDuration.value.text;
                              txtADDMaxGuest.value.text=txtADDMaxGuest.value.text;

                            }else if(mode=="ADD"){

                              var datas = Map<String, String>.from({
                                "name":txtADDName.value.text,
                                "price":txtADDPrice.value.text,
                                "duration":txtADDDuration.value.text,
                                "Max.Guest":txtADDMaxGuest.value.text,

                              });
                              lstrPlayAreaList.add(datas);



                              dprint("addd.........  ${lstrPlayAreaList}" );
                            }




                          },
                          icon_need: false,
                          buttonTextColor: Colors.white,
                          border: Border.all(
                            color: AppColors.appAdminColor1,
                          ),
                        ),
                        gapHC(10),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

}