import 'package:beams_tapp/common_widgets/CommonAlertDialog.dart';
import 'package:beams_tapp/common_widgets/commonToast.dart';
 
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/constants/common_functn.dart';
  
import 'package:beams_tapp/constants/enums/intialmode.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
  
     
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterItemController extends GetxController{


  ApiRepository apiRepository = ApiRepository();

  late Future<dynamic> futureFrom;

  //======================================Page Variables
  var wstrPageMode = "VIEW".obs;
  RxBool getcounterdesc = false.obs;
  final itemFormKey = GlobalKey<FormState>();



  //======================================Controller
  final TextEditingController txtItemCode = TextEditingController();
  final TextEditingController txtItemDescp = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtCounterDesc = TextEditingController();
  final TextEditingController txtCounterCode = TextEditingController();


  //======================================Page Function

  fnGetPageData()async{
   // await apiView("","LAST");
    //Page Load initstate


  }

  //======================================Lookup

  fnLookup(mode){
    if(mode == "COUNTER"){
      Get.to(() => LookupSearch(
        callbackfn: (data) {
          dprint(data);
          if(data!=null){
            getcounterdesc.value=true;
            txtCounterDesc.text = data["DESCP"].toString();
            txtCounterCode.text = data["CODE"].toString();
            Get.back();
          }

        },
        table_name: "COUNTER_MAST",
        column_names: const [
          {"COLUMN": "CODE", 'DISPLAY': "Code: "},
          {"COLUMN": "DESCP", 'DISPLAY': "Name: "},

        ],
        filter: [],
      )
      );
    }
  }

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
    dprint("pageeeModee:::  ${mode}");
    if(mode=="FIRST"){
      // apiView("", mode);
    }else  if(mode=="LAST"){
      // apiView("", mode);
    }
    else  if(mode=="NEXT"){
      // apiView(txtItemCode.text, mode);
    }else  if(mode=="PREVIOUS"){
      // apiView(txtItemCode.text, mode);
    }
  }
  fnSave(){

    if (txtCounterCode.text.isEmpty){
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Please Add Counter Code',
          duration: Duration(seconds: 2),
        ),
      );
    }
    else if (itemFormKey.currentState!.validate()) {
      dprint("Saaved");
      // apiSave(txtItemCode.text,wstrPageMode.value,txtItemDescp.text);

    }else{
      dprint("not validate");
    }


  }

  fnClear(){
    txtItemDescp.clear();
    txtItemCode.clear();
    txtCounterCode.clear();
    txtCounterDesc.clear();
    txtPrice.clear();
  }
  fnFill(data){
    fnClear();

    dprint("1111111111  ${data}");
    var dataList = data["DATA"];
    // if(mfnCheckValue(dataList)){
    //   txtCode.text = (dataList[0]["CODE"]??"").toString();
    //   txtDescp.text = (dataList[0]["DESCP"]??"").toString();
    // }

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




