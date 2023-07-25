import '../../../../common_widgets/CommonAlertDialog.dart';
import '../../../../common_widgets/commonToast.dart';
import '../../../../common_widgets/common_textfield.dart';
import '../../../../common_widgets/countryTextfield.dart';
import '../../../../common_widgets/title_withUnderline.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/common_functn.dart';
import '../../../../constants/enums/intialmode.dart';
import '../../../../constants/enums/toast_type.dart';
import '../../../../constants/enums/txt_field_type.dart';
import '../../../../constants/string_constant.dart';
import '../../../../constants/styles.dart';
import '../../../../model/commonModel.dart';
import '../../../../servieces/api_repository.dart';
import '../../../../view/commonController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/adminRegister_controller.dart';

class AdminRegisterScreen extends StatefulWidget {
  const AdminRegisterScreen({Key? key}) : super(key: key);

  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  final AdminRegisterController adminRegisterController = Get.put(AdminRegisterController());
  Rx<DateTime> dob = DateTime.now().obs;
@override
  void dispose() {
  // adminRegisterController.fnCancel();
  // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      adminRegisterController.fnGetRegisterViewDatas();
      adminRegisterController.fnSearchRegisterUser();
    });
    // TODO: implement initState
    super.initState();
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
              title: AppStrings.registration,
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
                          controller: adminRegisterController.txtSearch,
                          decoration: const InputDecoration(
                              label: Text('Search Registered User'),
                              prefixIcon: Icon(Icons.search)
                          ),
                          onChanged: (value){
                            adminRegisterController.fnSearchRegisterUser();
                          },

                          //  onTap: adminUserController.fnUserLookup
                        ),
                        gapHC(10),
                        Obx(() => Expanded(
                          child: ListView.builder(
                            itemCount: adminRegisterController.registerList.length,
                            itemBuilder: (context,index){
                              var data = adminRegisterController.registerList[index];
                              return  Bounce(
                                duration: const Duration(milliseconds: 110),
                                onPressed: (){
                                  if(adminRegisterController.wstrPageMode.value=="VIEW"){
                                    adminRegisterController.apiView(data["SLCODE"].toString(), "") ;
                                  }
                                },
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
                                          tc(data["SLCODE"].toString().toUpperCase(),Colors.black,12),
                                          Text(data["SLDESCP"].toString().toUpperCase()),
                                          Text(data["MOBILE"].toString().toUpperCase()),
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
                        padding: const EdgeInsets.only(left: 20,top: 10,right: 20) ,
                        child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [

                            adminRegisterController.wstrPageMode.value=="VIEW" ? Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Bounce(
                                        duration: const Duration(milliseconds: 110),
                                        onPressed: (){

                                          adminRegisterController.fnPage("FIRST");

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
                                          adminRegisterController.fnPage("PREVIOUS");
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

                                          adminRegisterController.fnPage("NEXT");
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

                                          adminRegisterController.fnPage("LAST");
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
                                          adminRegisterController.fnAdd();

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
                                          adminRegisterController.fnEdit();


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
                                          adminRegisterController.wstrPageMode.value = "VIEW";
                                          adminRegisterController.fnDelete(context);
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
                            ):SizedBox(),

                           Expanded(
                             flex: 2,
                             child: SingleChildScrollView(
                               child: Form(
                                 key: adminRegisterController.registerformKey,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 tsw("Full Name",AppColors.fontcolor,14,FontWeight.w500),
                                 gapHC(4),
                                 SizedBox(
                                     width: 500,
                                     child: CommonTextfield(controller: adminRegisterController.f_name_controller,
                                       textFormFieldType: TextFormFieldType.fullName, enable:adminRegisterController.wstrPageMode.value == "VIEW"?false:true,
                                       opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Name',)),
                                 gapHC(20),
                                 tsw("Email",AppColors.fontcolor,14,FontWeight.w500),
                                 gapHC(4),
                                 SizedBox(          width: 500,
                                     child: CommonTextfield(controller:  adminRegisterController.mail_controller,textFormFieldType: TextFormFieldType.email,
                                       enable:adminRegisterController.wstrPageMode.value == "VIEW"?false:true, opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Email',)),
                                 gapHC(20),
                                 tsw("Mobile Number",AppColors.fontcolor,14,FontWeight.w500),
                                 gapHC(4),
                                 AbsorbPointer(
                                   absorbing: adminRegisterController.wstrPageMode.value != "VIEW"?false:true ,
                                   child: SizedBox(          width: 500,
                                       child: CountrySelectorTextInput(textFieldcontroller: adminRegisterController.phone_controller,
                                           textFormFieldType: TextFormFieldType.mobileNumber)),
                                 ),
                                 gapHC(20),
                                 tsw("Dob",AppColors.fontcolor,14,FontWeight.w500),
                                 gapHC(4),
                                 wDateField(),
                                 gapHC(20),
                                 tsw("Gender",AppColors.fontcolor,14,FontWeight.w500),
                                 AbsorbPointer(
                                   absorbing: adminRegisterController.wstrPageMode.value != "VIEW"?false:true,
                                   child: SizedBox(          width: 500,
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: <Widget>[
                                         addRadioButton(0, 'Male',size),
                                         addRadioButton(1, 'Female',size),
                                         addRadioButton(2, 'Others',size),
                                       ],
                                     ),
                                   ),
                                 ),
                                 gapHC(10),
                                 tsw("Address",AppColors.fontcolor,14,FontWeight.w500),
                                 gapHC(4),
                                 SizedBox(           width: 500,
                                     child: CommonTextfield(controller: adminRegisterController.address_controller,
                                         enable:adminRegisterController.wstrPageMode.value == "VIEW"?false:true,textFormFieldType: TextFormFieldType.address,opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Address',maxline: 6)),
                                 gapHC(20),
                                 tsw("City",AppColors.fontcolor,14,FontWeight.w500),
                                 gapHC(4),

                                 wCityTextfield(),

                                 gapHC(90),
                               ],
                                 ),
                               ),
                             ),
                           ),
                            adminRegisterController.wstrPageMode.value != "VIEW"?  Column(

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
                                          adminRegisterController.fnCancel();
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

                                          adminRegisterController.apiRegister(adminRegisterController.gender_select.value,dob.value);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                                            decoration: BoxDecoration(
                                              color: AppColors.primarycolor,
                                              borderRadius: BorderRadius.circular(5) ,
                                            ),

                                            child: tc(adminRegisterController.wstrPageMode.value=="EDIT"?"Update": "Register", AppColors.white, 15)),

                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ):SizedBox()


                          ],
                        ))
                    ),
                  ),
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }

  /////WIDGET======================================
  addRadioButton(int btnValue, String title,Size size) {
    return Obx(() =>  Flexible(

      child: RadioListTile(
        activeColor: AppColors.primarycolor,
        contentPadding: EdgeInsets.zero,
        value: adminRegisterController.gender[btnValue],
        groupValue: adminRegisterController.gender_select.value,
        dense: true,
        onChanged: (value){
          print(value);
          adminRegisterController.gender_select.value = value;
          print("Gender value>>>> ${adminRegisterController.gender_select.value}");
        },

        title: Text(title),
      ),
    ));
  }


  wDateField(){
    return AbsorbPointer(
      absorbing: adminRegisterController.wstrPageMode.value != "VIEW"?false:true,
      child: SizedBox(          width: 500,
        child: Material(
          elevation: 30,
          borderRadius: BorderRadius.circular(1.0),
          shadowColor: AppColors.lightfontcolor.withOpacity(0.3),
          child: Padding(
              padding: const EdgeInsets.only(right: 10,left: 10),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tc(DateFormat('dd-MM-yyyy').format(dob.value), AppColors.fontcolor, 11),
                  IconButton(onPressed: (){
                    wSelectDate(context);
                  },
                      icon: const Icon(Icons.calendar_month_rounded))
                ],
              ),)
          ),
        ),
      ),
    );
  }

  wCityTextfield(){
    return SizedBox(
      width: 500,
      child: Material(
        elevation: 30,
        borderRadius: BorderRadius.circular(8) ,
        shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
        child: TextFormField(
          showCursor:false,
          autofocus: false,
          enabled:adminRegisterController.wstrPageMode.value == "VIEW"?false:true,
          keyboardType: TextInputType.none,
          controller: adminRegisterController.city_controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: "Guest City",
            fillColor: Colors.white,
            hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),


          ),
          // onTap: (){
          //   print("object");
          //   Get.to(() => LookupSearch(
          //     callbackfn: (data) {
          //       if(data!=null){
          //         dprint("CODE:>>>  ${data["CODE"]}");
          //         dprint("DESCP:>>>  ${data["DESCP"]}");
          //         adminRegisterController.city_controller.text = data["CODE"].toString();
          //         Get.back();
          //       }
          //
          //     },
          //     table_name: "CITYMASTER",
          //     column_names: const [
          //       {"COLUMN": "CODE", 'DISPLAY': "CODE: "},
          //       {"COLUMN": "DESCP", 'DISPLAY': "NAME: "},
          //
          //     ],
          //     filter: [],
          //   )
          //   );
          // },

        ),
      ),
    );
  }


  Future<void> wSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1800, 8),
        lastDate:DateTime.now(),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != dob){
      dob.value = pickedDate ;
      dprint(dob.value);
      dprint("DOB DATE:  ${DateFormat('dd-MM-yyyy').format(dob.value)}");
    }

  }


}
