
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common_widgets/CommonAlertDialog.dart';
import '../../../../common_widgets/commonToast.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/intialmode.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../model/commonModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../view/commonController.dart';

class AdminRegisterController extends GetxController{

  late Future <dynamic> futureform;
  ApiRepository apiRepository= ApiRepository();
  final registerformKey = GlobalKey<FormState>();
  List gender = ["Male", "Female", "Other"];
  RxString gender_select = ''.obs;
  RxBool isAvailbleSlcode = false.obs;
  RxString slcode ="".obs;
  var wstrPageMode = "VIEW".obs;
  final CommonController commonController = Get.put(CommonController());
  RxList registerList = [].obs;

  /////////////CONTROLLER===========================

  final TextEditingController f_name_controller = TextEditingController();
  final TextEditingController mail_controller = TextEditingController();
  final TextEditingController phone_controller = TextEditingController();
  final TextEditingController address_controller = TextEditingController();
  final TextEditingController city_controller = TextEditingController();
  final TextEditingController txtSearch = TextEditingController();




  fnSearchRegisterUser(){
    futureform = apiRepository.apiUserSearchRegister(txtSearch.text);
    futureform.then((value) =>apiUserSearchRes(value));
  }
  apiUserSearchRes(val){
    dprint("apiUserSearchRes..................");
    dprint(val);

    registerList.value =val;

  }








  //======================================Menu Function

  fnAdd(){
    wstrPageMode.value = "ADD";
    dprint("fnctnaddd/////");
    fnClear();

  }
  fnEdit(){
    wstrPageMode.value = "EDIT";

  }
  fnDelete(BuildContext context){
    showDialog(
        context: context,
        builder: (context) =>
            CommonAlertDialog(onpressed: () {
              dprint("Call  delete apiii");
              Get.back();
            }, alertmode: Alertmode.delete,
            )
    );




  }
  fnCancel(){
    wstrPageMode.value = "VIEW";
    apiView("", "LAST");
  }
  fnPage(mode){
    dprint("pageee:::  ${mode}");
    if(mode=="FIRST"){
      dprint(mode);
      apiView("", mode);
    }else  if(mode=="LAST"){
      dprint(mode);
      apiView("", mode);
    }
    else  if(mode=="PREVIOUS"){
      dprint(mode);
       apiView(slcode.value, mode);
    }else  if(mode=="NEXT"){
      dprint(mode);
      apiView(slcode.value, mode);
    }
  }


  fnClear(){
    f_name_controller.clear();
    mail_controller.clear();
    phone_controller.clear();
    address_controller.clear();
    city_controller.clear();
    isAvailbleSlcode.value=false;
    commonController.selectcountry.value="+971";
    gender_select.value="";
    slcode.value='';
  }
  fnFill(data){
    dprint("1111111111erwer  ${data}");
    var dataList = data["DATA"];
    if(mfnCheckValue(dataList)){
      f_name_controller.text = (dataList[0]["SLDESCP"]??"").toString();
      mail_controller.text = (dataList[0]["EMAIL"]??"").toString();
      phone_controller.text = (dataList[0]["MOBILE"]??"").toString();
      address_controller.text = (dataList[0]["ADDRESS1"]??"").toString();
      city_controller.text = (dataList[0]["CITY"]??"").toString();
      commonController.selectcountry.value=(dataList[0]["TEL2"]??"").toString();
      var gen =(dataList[0]["GENDER"]??"").toString();
      gender_select.value= gen=="M"? gender[0]: gen=="F"? gender[1]: gen=="O"? gender[2]:"";
      slcode.value=(dataList[0]["SLCODE"]??"").toString();



    }

  }



  //======================================Page Function

  fnGetRegisterViewDatas()async{
    wstrPageMode.value = "VIEW";
    await apiView("","LAST");
    //Page Load initstate


  }


/////////////API_CALL======================
  apiView(code,mode){
    futureform = apiRepository.apiAdminViewRegistertion(code, mode);
    futureform.then((value) =>apiViewRes(value));
  }
  apiViewRes(value){
    fnFill(value);
  }





  apiRegister(String ? genderval,DateTime dob) async {
    dprint("Modeeeeee::;   ${wstrPageMode.value}");
    if (registerformKey.currentState!.validate()) {
      var gend, dateofbirth;
      try {
        dateofbirth = DateFormat('yyyy-MM-dd').format(dob);
        dprint("DOOOBB ${dateofbirth}");
        if (genderval == "Male") {
          gend = "M";
        } else if (genderval == "Female") {
          gend = "F";
        } else if (genderval == "Other") {
          gend = "O";
        }
        if(wstrPageMode.value=="EDIT" && slcode.value.isEmpty) {
          dprint("edittttttttttttt............");
          return;
        }
        final responseJson = await apiRepository.apiRegistration(
            slcode.value,
            f_name_controller.text,
            mail_controller.text,
            phone_controller.text,
            dateofbirth,
            gend,
            address_controller.text,
            city_controller.text="",
            commonController.selectcountry.value);
        dprint("regisretionnn ${responseJson[0]}");
        CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
        if (commonModel.sTATUS == "1") {
          CustomToast.showToast(
              "Successfully registered", ToastType.success,
              ToastPositionType.end);
          fnCancel();
          fnClear();
          fnSearchRegisterUser();

        } else {
          CustomToast.showToast(commonModel.mSG.toString(), ToastType.error, ToastPositionType.end);
        }
      } catch (e) {
        dprint("!!!!!!!!!!!!!  >>  " + e.toString());
        CustomToast.showToast(e.toString(), ToastType.error, ToastPositionType.end);
      }
    }
    else{
      dprint("Not vlidateee");
    }
  }








}