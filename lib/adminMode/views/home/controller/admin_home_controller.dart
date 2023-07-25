
import 'package:get/get.dart';

import '../../../../constants/common_functn.dart';

class AdminHomeController extends GetxController{
  RxString pageMode ='user'.obs;
  RxBool selectedPage =false.obs;

  changePage(val){
    pageMode.value = val;
    dprint("TapedPage::>> ${pageMode.value.toString()}");

  }



}