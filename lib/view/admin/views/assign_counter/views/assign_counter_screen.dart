import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
  
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/admin/views/assign_counter/counter/assign_counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class AssignCounterScreen extends StatefulWidget {
  const AssignCounterScreen({Key? key}) : super(key: key);

  @override
  State<AssignCounterScreen> createState() => _AssignCounterScreenState();
}

class _AssignCounterScreenState extends State<AssignCounterScreen> {
  final AssignCounterController assignCounterController = Get.put(AssignCounterController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // dprint(adminCounterController.wstrPageMode);
    return Scaffold(
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(
          elevation: 0,
          title: tsw("Assign Counter",AppColors.white,20,FontWeight.w500),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wUserField(),
                      assignCounterController.getusername.value?     CommonTextfield(
                        enable:false,
                        controller: assignCounterController.txtUsercode,
                        textFormFieldType: TextFormFieldType.userCode,
                        opacityamount: 0.17,
                        shadow: 30.0,
                        label: "User Name",
                        hintText: "User Name",
                      ):const SizedBox(),
                      gapHC(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tcnw("Choose Counter", AppColors.fontcolor, 16,TextAlign.center, FontWeight.w600),
                          Bounce(
                             duration: const Duration(milliseconds: 110),
                               onPressed: () {
                               assignCounterController.fnAddCounterLookup();
                               },
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: AppColors.primarycolor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                                child: Icon(Icons.add,color: AppColors.white,)),
                          )

                        ],
                      ),
                      gapHC(10),
                      Expanded( child:AnimatedList(
                        key: assignCounterController.listkey,
                        initialItemCount: assignCounterController.counterList.length,
                        itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                          return wBuildItem(assignCounterController.counterList[index],animation,index);
                        },

                      )

                      )









                    ],
                  ),
              ),
            )),


        // bottomNavigationBar: Obx(() => BottomNavigationItem(
        //   mode: userCreateController.wstrPageMode.value,
        //   fnPage: userCreateController.fnPage,
        //   fnSave:  userCreateController.fnSave,
        //   fnEdit:  userCreateController.fnEdit,
        //   fnAdd:  userCreateController.fnAdd,
        //   fnCancel:  userCreateController.fnCancel,
        //   fnDelete:  userCreateController.fnDelete,
        // ),)
    );
  }
  /////WIDGET=====================================================================
  wUserField() {
    return  GestureDetector(
      onTap: (){
        assignCounterController.fnUserLookup();
      },
      child: Material(
        elevation: 30,
        borderRadius: BorderRadius.circular(8) ,
        shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
        child: TextFormField(
          controller:assignCounterController.txtUsercode ,
          keyboardType: TextInputType.none,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration:  const InputDecoration(
            enabled:false,
            hintText: "User Code",
            suffixIcon: Icon(Icons.search,size: 20),
            fillColor: Colors.white,
            hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            label: Text("User Code") ,
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return AppStrings.emptyCountercode;
          //   }
          //   return null;
          //
          // },


        ),
      ),
    );
  }
  Widget wBuildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: AppColors.primarycolor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tc(item.toString(),AppColors.white, 16),
                Bounce(
                  duration: const Duration(milliseconds: 110),
                  onPressed: () {
                    dprint("Remove.....");
                    removeSingleItem(index);


                  },
                  child: Icon(Icons.close,color: AppColors.white,),
                )

              ],
            ),
          ),
        ));




  }



  ////Functon
  removeSingleItem(int removeat){
    int removeIndex = removeat;
    String removeItem = assignCounterController.counterList.removeAt(removeIndex);

    builder(context,animation){
      return wBuildItem(removeItem, animation, removeat);
    }
    assignCounterController.listkey.currentState!.removeItem(removeIndex, builder);

  }

}



