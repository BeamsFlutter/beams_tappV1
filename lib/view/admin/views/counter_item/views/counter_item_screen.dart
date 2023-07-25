import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
  
import 'package:beams_tapp/constants/enums/txt_field_type.dart';

import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/admin/views/bottom_navbar.dart';
import 'package:beams_tapp/view/admin/views/counter_item/controller/counter_item_controller.dart';


import 'package:beams_tapp/view/admin/views/counters/controller/adminCounterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterItemScreen extends StatefulWidget {
  const CounterItemScreen({Key? key}) : super(key: key);

  @override
  State<CounterItemScreen> createState() => _CounterItemScreenState();
}

class _CounterItemScreenState extends State<CounterItemScreen> {
  final CounterItemController counterItemController = Get.put(CounterItemController());

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 1), () {
    //   // counterItemController.fnGetPageData();
    // });
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
          title: tsw("Counter Items", AppColors.white, 20, FontWeight.w500),
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
              decoration: commonBoxDecoration(AppColors.white),
              child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 20, left: 20),

                  //obx
                  child:SingleChildScrollView(
                    child:Obx(() =>  Form(
                      key: counterItemController.itemFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextfield(
                            enable:counterItemController.wstrPageMode.value == "VIEW"?false:true,
                            controller: counterItemController.txtItemCode,
                            textFormFieldType: TextFormFieldType.itemCode,
                            opacityamount: 0.17,
                            shadow: 30.0,
                            label: "Item Code",
                            hintText: 'Item Code',
                          ),
                          gapHC(10),
                          CommonTextfield(
                            enable:counterItemController.wstrPageMode.value == "VIEW"?false:true,
                            controller: counterItemController.txtItemDescp,
                            textFormFieldType: TextFormFieldType.itemDescrptn,
                            opacityamount: 0.17,
                            shadow: 30.0,
                            label: "Item Description",
                            hintText: 'Item Description',
                          ),
                          gapHC(10),
                          wCounterField(),
                          gapHC(10),
                          counterItemController.getcounterdesc.value?     CommonTextfield(
                            enable:false,
                            controller: counterItemController.txtCounterDesc,
                            textFormFieldType: TextFormFieldType.itemDescrptn,
                            opacityamount: 0.17,
                            shadow: 30.0,
                            label: "Counter Description",
                            hintText: 'Counter Description',
                          ):const SizedBox(),
                          counterItemController.getcounterdesc.value?   gapHC(10):const SizedBox(),
                          CommonTextfield(
                            enable:counterItemController.wstrPageMode.value == "VIEW"?false:true,
                            controller: counterItemController.txtPrice,
                            textFormFieldType: TextFormFieldType.itemPrice,
                            opacityamount: 0.17,
                            shadow: 30.0,
                            label: "Price",
                            hintText:'Price',
                          ),
                        ],
                      ),
                    ),

                    )
                  ),
              ),
            )),
        bottomNavigationBar: Obx(
          () => BottomNavigationItem(
            mode: counterItemController.wstrPageMode.value,
            fnPage: counterItemController.fnPage,
            fnSave: counterItemController.fnSave,
            fnEdit: counterItemController.fnEdit,
            fnAdd: counterItemController.fnAdd,
            fnCancel: counterItemController.fnCancel,
            fnDelete: counterItemController.fnDelete,
          ),
        )

    );
  }

  /////WIDGET==========================================================
  wCounterField() {
    return  GestureDetector(
      onTap: (){
        if(counterItemController.wstrPageMode=="VIEW"){
          return;
        }
        counterItemController.fnLookup("COUNTER");
      },
      child: Material(
        elevation: 30,
        borderRadius: BorderRadius.circular(8) ,
        shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
        child: TextFormField(
          controller:counterItemController.txtCounterCode ,
          keyboardType: TextInputType.none,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration:  const InputDecoration(
            enabled:false,
            hintText: "Counter Code",
            suffixIcon: Icon(Icons.search,size: 20),
            fillColor: Colors.white,
            hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            label: Text("Counter Code") ,
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.emptyCountercode;
            }
            return null;


          },


        ),
      ),
    );
  }

}
