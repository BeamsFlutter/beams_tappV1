
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../../constants/color_code.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/txt_field_type.dart';
import '../../../../constants/styles.dart';
import '../../../../utils/textfieldValidator.dart';
import '../controller/adminUser_controller.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {

  final AdminUserController adminUserController = Get.put(AdminUserController());
@override
  void initState() {
  Future.delayed(const Duration(seconds: 1), () {
    adminUserController.fnGetUserViewDatas();
    adminUserController.fnSearchUser();

  });
  adminUserController.roleCode.value =="ADMIN"?adminUserController.adminchecked.value=true:false;
  // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    adminUserController.fnCancel;
  // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: boxDecoration(Colors.white, 10),
        margin: const EdgeInsets.all(10),
        padding:const  EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWithUnderLine(
              title: AppStrings.Usermast,
            ),
            Expanded(child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 310,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      children:  [
                        TextField(
                          controller: adminUserController.txtSearch,
                          decoration: const InputDecoration(
                              label: Text('Search User'),
                              prefixIcon: Icon(Icons.search)
                          ),
                          onChanged: (value){
                            adminUserController.fnSearchUser();
                          },
                        ),
                        gapHC(10),
                        Obx(() =>  Expanded(
                          child: ListView.builder(
                            itemCount: adminUserController.userList.length,
                            itemBuilder: (context,index){
                              var data = adminUserController.userList[index];
                              return Bounce(
                                onPressed: (){
                                  if(adminUserController.wstrPageMode.value =="VIEW"){
                                    adminUserController.apiView(data["USER_CD"].toString(), "") ;
                                  }
                                },
                                duration: const Duration(milliseconds: 110),
                                child: Container(
                                  decoration:  boxBaseDecoration(AppColors.lightfontcolor.withOpacity(0.1), 5),
                                  padding:const  EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.account_circle_sharp),
                                      gapWC(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          tc(data["USER_CD"].toString().toUpperCase(),Colors.black,12),
                                          Text(data["USERNAME"].toString().toUpperCase())
                                        ],
                                      )
                                    ],
                                  ),

                                ),
                              );

                            },

                          ),
                        ),)



                      ],
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                ),
                gapWC(5),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      padding: const EdgeInsets.only(left: 20,top: 10) ,
                      child: Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [

                          adminUserController.wstrPageMode.value=="VIEW" ?
                          Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("view");
                                        adminUserController.fnPage("FIRST");

                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.first_page_rounded,color: AppColors.white,))),

                                    ),
                                  ),
                                  gapWC(5),
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("view");
                                        adminUserController.fnPage("PREVIOUS");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.skip_previous,color: AppColors.white,))),

                                    ),
                                  ),
                                  gapWC(5),
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("view");

                                        adminUserController.fnPage("NEXT");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.skip_next,color: AppColors.white,))),

                                    ),
                                  ),
                                  gapWC(5),
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("view");
                                        adminUserController.fnPage("LAST");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.last_page,color: AppColors.white,))),

                                    ),
                                  ),

                                  gapWC(5),
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("addd");

                                        adminUserController.fnAdd();

                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.add,color: AppColors.white,))),

                                    ),
                                  ),
                                  gapWC(5),
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("edit");
                                        adminUserController.fnEdit();


                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.edit,color: AppColors.white,))),

                                    ),
                                  ),
                                  gapWC(5),
                                  Flexible(
                                    child: Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        dprint("delete");
                                        adminUserController.wstrPageMode.value = "VIEW";
                                        adminUserController.fnDelete(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 6),

                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: Center(child: const Icon(Icons.delete_forever,color: AppColors.white,))),

                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ):const SizedBox(),

                          Expanded(
                            flex: 2,
                            child: Form(
                              key: adminUserController.userFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  gapHC(10),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      controller: adminUserController.txtUserCode,
                                      decoration: InputDecoration(
                                        label: const Text("usercode"),
                                        filled: true,
                                        hintText: "usercode",
                                        enabled:adminUserController.wstrPageMode.value == "VIEW"||adminUserController.wstrPageMode.value == "EDIT"?false:true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                      validator: (String? value) {
                                        return FormValidator.isValid(TextFormFieldType.adminUserCode, value ?? "");

                                      },
                                    ),
                                  ),
                                  gapHC(13),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      controller: adminUserController.txtUserName,

                                      decoration: InputDecoration(
                                        filled: true,
                                        enabled:adminUserController.wstrPageMode.value == "VIEW"?false:true,
                                        label: const Text("username"),


                                        hintText: "username",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10)
                                        ),

                                      ),
                                      validator: (String? value) {
                                        return FormValidator.isValid(TextFormFieldType.adminUsername, value ?? "");

                                      },
                                    ),
                                  ),


                                  gapHC(13),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(obscureText: adminUserController.wstrPageMode.value=="EDIT"?false: true,
                                      controller: adminUserController.txtUserPassword,
                                      decoration: InputDecoration(
                                        label: const Text('password'),
                                        filled: true,
                                        hintText: "password",
                                        enabled: adminUserController.wstrPageMode.value == "ADD"||adminUserController.wstrPageMode.value == "EDIT"?true:false,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                      validator: (String? value) {
                                        return FormValidator.isValid(TextFormFieldType.adminUserPassword, value ?? "");

                                      },
                                    ),
                                  ),
                                  gapHC(13),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(obscureText: adminUserController.wstrPageMode.value=="EDIT"?false: true,
                                      controller: adminUserController.txtUserPasscode,
                                      maxLength: 4,
                                      decoration: InputDecoration(
                                        filled: true,
                                        label: const Text('passcode'),
                                        enabled: adminUserController.wstrPageMode.value == "ADD"||adminUserController.wstrPageMode.value == "EDIT"?true:false,
                                        hintText: "passcode",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                      validator: (String? value) {
                                        return FormValidator.isValid(TextFormFieldType.adminUserPasscode, value ?? "");

                                      },
                                    ),
                                  ),
                                  gapHC(10),
                                  AbsorbPointer(
                                    absorbing:    adminUserController.wstrPageMode.value == "VIEW"? true:false,
                                    child: Obx(() =>    Row(
                                        children: [
                                          Checkbox(
                                            checkColor: AppColors.primarycolor,
                                         activeColor: AppColors.white,
                                         value: adminUserController.roleCode.value=="ADMIN"? true:false,
                                        onChanged: (bool? value) {
                                          adminUserController.roleCode.value = (value! ?"ADMIN":"").toString();
                                          adminUserController.fncheckedAdmin(value);
                                        },

                                    ),
                                    gapWC(6),
                                    tcnw("Admin", AppColors.fontcolor, 14,TextAlign.center,FontWeight.w500)
                                ],
                              )),
                                  )


                                ],
                              ),
                            ),
                          ),
                          adminUserController.wstrPageMode.value != "VIEW"?  Column(

                            children: [
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        adminUserController.fnCancel();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: tc("Cancel", AppColors.white, 15)),

                                    ),
                                    gapWC(5),

                                    Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        adminUserController.wstrPageMode.value=="EDIT"?adminUserController.fnUpdate(): adminUserController.fnSave();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarycolor,
                                            borderRadius: BorderRadius.circular(5) ,
                                          ),

                                          child: tc(adminUserController.wstrPageMode.value=="EDIT"?"Update": "Save", AppColors.white, 15)),

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ):const SizedBox()


                        ],
                      )),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

//
// SizedBox(
// width: 300,
// child: TextField(
// decoration: InputDecoration(
// filled: true,
// hintText: "UserName",
// border: OutlineInputBorder(
// borderSide: BorderSide.none,
// borderRadius: BorderRadius.circular(10)
// ),
// ),
// ),
// ),
// gapHC(15),
// SizedBox(
// width: 300,
// child: TextField(
// decoration: InputDecoration(
// filled: true,
// hintText: "UserName",
// border: OutlineInputBorder(
// borderSide: BorderSide.none,
// borderRadius: BorderRadius.circular(10)
// ),
// ),
// ),
// ),
// gapHC(15),
// SizedBox(
// width: 300,
// child: TextField(
// decoration: InputDecoration(
// filled: true,
// hintText: "UserName",
// border: OutlineInputBorder(
// borderSide: BorderSide.none,
// borderRadius: BorderRadius.circular(10)
// ),
// ),
// ),
// ),
// gapHC(15),
// SizedBox(
// width: 300,
// child: TextField(
// decoration: InputDecoration(
// filled: true,
// hintText: "UserName",
// border: OutlineInputBorder(
// borderSide: BorderSide.none,
// borderRadius: BorderRadius.circular(10)
// ),
// ),
// ),
// ),