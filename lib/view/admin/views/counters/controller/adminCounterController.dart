import 'package:beams_tapp/common_widgets/CommonAlertDialog.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/intialmode.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdminCounterController extends GetxController{

  ApiRepository apiRepository = ApiRepository();

  late Future<dynamic> futureFrom;

  //======================================Page Variables
  var wstrPageMode = "VIEW".obs;


  //======================================Controller
  final TextEditingController txtCode = TextEditingController();
  final TextEditingController txtDescp = TextEditingController();


 //======================================Page Function

  fnGetPageData()async{
    await apiView("","LAST");
    //Page Load initstate


  }

  //======================================Lookup

  //======================================Menu Function

    fnAdd(){
      fnClear();
      wstrPageMode.value = "ADD";

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
        apiView("", mode);
      }else  if(mode=="LAST"){
        apiView("", mode);
      }
      else  if(mode=="NEXT"){
        apiView(txtCode.text, mode);
      }else  if(mode=="PREVIOUS"){
        apiView(txtCode.text, mode);
      }
    }
    fnSave(){
      apiSave(txtCode.text,wstrPageMode.value,txtDescp.text);

    }

    fnClear(){
        txtDescp.clear();
        txtCode.clear();
    }
    fnFill(data){
    fnClear();

    dprint("1111111111  ${data}");
    var dataList = data["DATA"];
      if(mfnCheckValue(dataList)){
        txtCode.text = (dataList[0]["CODE"]??"").toString();
        txtDescp.text = (dataList[0]["DESCP"]??"").toString();
      }

    }

  //======================================Api call

    apiView(code,mode){
      futureFrom = apiRepository.apiViewCounter(code, mode);
      futureFrom.then((value) =>apiViewRes(value));
    }
    apiViewRes(value){
      fnFill(value);
    }


    apiSave(code,mode,descrptn){
      dprint(code);
      dprint(mode);
      dprint(descrptn);
      futureFrom = apiRepository.apiSaveCounter(code,mode,descrptn);
      futureFrom.then((value) =>apiSaveRes(value));

    }
    apiSaveRes(value){
      dprint("!!!!!!!! save:: ${value}");
      try{
        if(mfnCheckValue(value)){
          var sts = value[0]["STATUS"].toString();
          if(sts=="1"){
            dprint("succedfullllyy //toptop");
            CustomToast.showToast(
                "Successfully Saved", ToastType.success, ToastPositionType.end);
            fnCancel();
          }else{
            dprint("tryagain");
            CustomToast.showToast(
                "Please try again", ToastType.success, ToastPositionType.end);
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

    apiDelete(){

     }
    apiUpdate(){

   }









}



