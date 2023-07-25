
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/CommonAlertDialog.dart';
import '../../../../common_widgets/commonToast.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/intialmode.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../servieces/api_repository.dart';

class AdminUserController extends GetxController{



  ApiRepository apiRepository = ApiRepository();

  late Future<dynamic> futureFrom;

  //======================================Page Variables
  var wstrPageMode = "VIEW".obs;
  final userFormKey = GlobalKey<FormState>();
  //======================================Controller
  final TextEditingController txtUserCode = TextEditingController();
  final TextEditingController txtUserName = TextEditingController();
  final TextEditingController txtUserPasscode = TextEditingController();
  final TextEditingController txtUserPassword = TextEditingController();
  final TextEditingController txtSearch = TextEditingController();
  RxString roleCode=''.obs;
  RxList userList = [].obs;
  RxBool adminchecked = false.obs;

fncheckedAdmin(val){
  adminchecked.value =val;
  dprint("Checkkked ${adminchecked}");
}

  fnSearchUser(){
    futureFrom = apiRepository.apiUserSearch(txtSearch.text);
    futureFrom.then((value) =>apiUserSearchRes(value));
  }
  apiUserSearchRes(val){
    dprint("-------------apiUserSearchRes---");
    dprint(val);
    userList.value =val;

  }


  //======================================Page Function

  fnGetUserViewDatas()async{
    wstrPageMode.value = "VIEW";
    await apiView("","LAST");
    //Page Load initstate


  }












  //======================================Lookup
  ////SEARCH USER...



  //======================================Menu Function

  fnAdd(){
   wstrPageMode.value = "ADD";
    dprint("fnctnaddd/////");
    fnClear();


  }
  fnEdit(){
    dprint("fnctnEdittt/////");

    if(txtUserCode.text.isEmpty){
      dprint("xtUserCode.text");
      return;
    }
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
      apiView(txtUserCode.text, mode);
    }else  if(mode=="NEXT"){
           dprint(mode);
      apiView(txtUserCode.text, mode);
    }
  }
  fnSave(){
    if (userFormKey.currentState!.validate()) {
      dprint("fn...save");
      apiSave();
    }


  }
  fnUpdate(){
    if (userFormKey.currentState!.validate()) {
      dprint("fn...save");
      apiEdit();
    }
  }

  fnClear(){
    txtUserCode.clear();
    txtUserName.clear();
    txtUserPasscode.clear();
    txtUserPassword.clear();
    adminchecked.value=false;
    roleCode.value="";
  }
  fnFill(data){
    fnClear();

    dprint("userviewdataaaaaaaaas  ${data}");
    dprint("datassssssssss  ${data["USER_CD"]}");
    // var dataList = data["DATA"];
    if(mfnCheckValue(data)){
      txtUserCode.text = (data["USER_CD"]??"").toString();
      txtUserName.text = (data["USERNAME"]??"").toString();
      txtUserPasscode.text = (data["PASSCODE"]??"").toString();
      txtUserPassword.text = (data["PASSWORD"]??"").toString();
      roleCode.value = (data["ROLE_CODE"]??"").toString();
      dprint( roleCode.value);
    }

  }

  //======================================Api call
  apiView(code,mode){
    futureFrom = apiRepository.apiAdminViewUser(code, mode);
    futureFrom.then((value) =>apiViewRes(value));
  }
  apiViewRes(value){
    fnFill(value);
  }




  apiSave(){
    var rlecode = "",rleDESCP = "";
    dprint("txtusername.... ${txtUserName.text}");
    dprint("txtusercode.... ${txtUserCode.text}");
    dprint("txtuserpasscode.... ${txtUserPasscode.text}");
    dprint("txtuserpassword.... ${txtUserPassword.text}");
    if(adminchecked.value==true){
       rlecode ="ADMIN";
       rleDESCP ="ADMIN";
    }
    futureFrom = apiRepository.apiUserCreate(txtUserName.text, txtUserCode.text, txtUserPasscode.text,txtUserPassword.text,rlecode,rleDESCP);
    futureFrom.then((value) =>apiUserSaveRes(value));

  }
  apiUserSaveRes(value){
    dprint("!!!!!!!! save:: ${value["STATUS"]}");
    try{
      if(mfnCheckValue(value)){
        var sts = value["STATUS"].toString();
        if(sts=="1"){
          dprint("succedfullllyy //toptop");
          CustomToast.showToast(
              "Successfully Saved", ToastType.success, ToastPositionType.end);
          fnCancel();
          fnClear();
          fnSearchUser();
        }else{
          dprint("tryagain");
          CustomToast.showToast(
              value["MSG"].toString(), ToastType.success, ToastPositionType.end);
        }

      }else{
        dprint("tryagain");
        CustomToast.showToast(
            "Please try again", ToastType.success, ToastPositionType.end);
      }
    }catch(e){
      CustomToast.showToast(
          "Please try again", ToastType.success, ToastPositionType.end);
      dprint(e);
    }

  }


  apiEdit(){
   var rlecode,rleDESCP;
    dprint("txtusername.edit... ${txtUserName.text}");
    dprint("txtusercode...edit. ${txtUserCode.text}");
    dprint("txtuserpasscode...edit. ${txtUserPasscode.text}");
    dprint("txtuserpassword..edit.. ${txtUserPassword.text}");

    if(adminchecked.value==true){
      rlecode ="ADMIN";
      rleDESCP ="ADMIN";
    }
    futureFrom = apiRepository.apiAdminEditUser(txtUserCode.text, txtUserName.text, txtUserPasscode.text, txtUserPassword.text,rlecode??"",rleDESCP??"");
    futureFrom.then((value) =>apiEditRes(value));
  }
  apiEditRes(value){
    dprint("apiEditRes....");
    dprint(value);
    if(value["STATUS"]=="1"){
      CustomToast.showToast(
          "Successfully Edited", ToastType.success, ToastPositionType.end);
      wstrPageMode.value = "VIEW";
      apiView(txtUserPasscode.text, "");
    }else{
      CustomToast.showToast(
          value["MSG"].toString(), ToastType.success, ToastPositionType.end);
    }
    // fnFill(value);
  }









  apiDelete(){

  }
  apiUpdate(){

  }



}