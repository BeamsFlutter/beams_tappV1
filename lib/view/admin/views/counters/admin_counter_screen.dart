
import 'package:beams_tapp/common_widgets/common_textfield.dart';
  
import 'package:beams_tapp/constants/enums/txt_field_type.dart';

import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/admin/views/bottom_navbar.dart';


import 'package:beams_tapp/view/admin/views/counters/controller/adminCounterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCounters extends StatefulWidget {
  const AdminCounters({Key? key}) : super(key: key);

  @override
  State<AdminCounters> createState() => _AdminCountersState();
}

class _AdminCountersState extends State<AdminCounters> {
  final AdminCounterController adminCounterController = Get.put(AdminCounterController());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      adminCounterController.fnGetPageData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // dprint(adminCounterController.wstrPageMode);
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw("Admin Counter",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body:  Padding(
      padding: const EdgeInsets.only(top: 5),
          child: Container(
       height: size.height,
       width: size.width,
       decoration: commonBoxDecoration(AppColors.white),
       child: Padding(
         padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
         child: Obx(() => Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             CommonTextfield(
               enable: adminCounterController.wstrPageMode.value == "ADD"?true:false,
               controller: adminCounterController.txtCode,
               textFormFieldType: TextFormFieldType.counterCode,
               opacityamount: 0.17,shadow: 30.0,
               label: "Counter Code",

               hintText: 'Counter Code',),
             gapHC(10),
             CommonTextfield(
               enable:adminCounterController.wstrPageMode.value == "VIEW"?false:true,
               controller: adminCounterController.txtDescp,
               textFormFieldType: TextFormFieldType.counterDescrptn,
               opacityamount: 0.17,
               shadow: 30.0,
               label:"Counter Description" ,
               hintText: 'Counter Description',
             ),




           ],
         ),)
       ),
       )),


       bottomNavigationBar: Obx(() => BottomNavigationItem(
           mode: adminCounterController.wstrPageMode.value,
           fnPage: adminCounterController.fnPage,
           fnSave:  adminCounterController.fnSave,
           fnEdit:  adminCounterController.fnEdit,
           fnAdd:  adminCounterController.fnAdd,
           fnCancel:  adminCounterController.fnCancel,
           fnDelete:  adminCounterController.fnDelete,
       ),)
    );
  }
}
