
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/commonToast.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../servieces/api_repository.dart';

class AdminDeviceController extends GetxController{
RxBool activate = true.obs;
RxList deviceList = [].obs;

late Future <dynamic> futureform;
ApiRepository apiRepository= ApiRepository();

TextEditingController txtsearch = TextEditingController();

changeActivation(bool val){
  activate.value=val;
  dprint(activate.value);
  Get.back();
}

fnDeviceList(){
  futureform = apiRepository.apiDeviceslist(txtsearch.text);
  futureform.then((value) =>fnDeviceListRes(value));
}
fnDeviceListRes(val){
  dprint("apiDevicelist.................");
  dprint(val);
  deviceList.value =val;

}

fnUpdatedev(devid){

  dprint("deviceidd::${devid}");
  futureform = apiRepository.apiUpdateTapDevice(devid);
  futureform.then((value) =>fnUpdatedevRes(value));
}
fnUpdatedevRes(val){
  dprint("apfnUpdatedevReselist.................");
  dprint(val[0]["STATUS"]);
  if(val[0]["STATUS"]=="1"){
    CustomToast.showToast("Successfully updated", ToastType.success, ToastPositionType.end);
    fnDeviceList();
  }


}



}