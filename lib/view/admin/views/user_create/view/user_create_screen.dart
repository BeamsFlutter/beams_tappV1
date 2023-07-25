import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/admin/views/bottom_navbar.dart';
import 'package:beams_tapp/view/admin/views/user_create/controller/usercreate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCreateScreen extends StatefulWidget {
  const UserCreateScreen({Key? key}) : super(key: key);

  @override
  State<UserCreateScreen> createState() => _UserCreateScreenState();
}

class _UserCreateScreenState extends State<UserCreateScreen> {
  final UserCreateController userCreateController = Get.put(UserCreateController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // dprint(adminCounterController.wstrPageMode);
    return Scaffold(
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(

          elevation: 0,
          title: tsw("User Create",AppColors.white,20,FontWeight.w500),
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
                  child: Obx(() => Form(
                    key: userCreateController.userFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextfield(
                          enable: userCreateController.wstrPageMode.value == "ADD"?true:false,
                          controller: userCreateController.txtUserCode,
                          textFormFieldType: TextFormFieldType.userCode,
                          opacityamount: 0.17,shadow: 30.0,
                          label: "User Code",

                          hintText: 'User Code',),
                        gapHC(10),
                        CommonTextfield(
                          enable:userCreateController.wstrPageMode.value == "VIEW"?false:true,
                          controller: userCreateController.txtUserName,
                          textFormFieldType: TextFormFieldType.username,
                          opacityamount: 0.17,
                          shadow: 30.0,
                          label:"User Name" ,
                          hintText: 'User Name',
                        ),
                        gapHC(10),
                        CommonTextfield(
                          enable:userCreateController.wstrPageMode.value == "VIEW"?false:true,
                          controller: userCreateController.txtUserPasscode,
                          textFormFieldType: TextFormFieldType.userPasscode,
                          opacityamount: 0.17,
                          shadow: 30.0,
                          label:"User Passcode" ,
                          hintText: 'User Passcode',
                        ),





                      ],
                    ),
                  ),)
              ),
            )),


        bottomNavigationBar: Obx(() => BottomNavigationItem(
          mode: userCreateController.wstrPageMode.value,
          fnPage: userCreateController.fnPage,
          fnSave:  userCreateController.fnSave,
          fnEdit:  userCreateController.fnEdit,
          fnAdd:  userCreateController.fnAdd,
          fnCancel:  userCreateController.fnCancel,
          fnDelete:  userCreateController.fnDelete,
        ),)
    );
  }
}
