import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/common_widgets/countryTextfield.dart';
import 'package:beams_tapp/common_widgets/dob_textfield.dart';
import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/numbers.dart';

import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/card_issue/views/cardissue_screen.dart';
import 'package:beams_tapp/view/login/controller/login_controller.dart';
import 'package:beams_tapp/view/recharge/controller/recharge_controller.dart';
import 'package:beams_tapp/view/register/controller/registerController.dart';
import 'package:beams_tapp/view/card_issue/views/qrsceen.dart';
import 'package:beams_tapp/view/success/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:beams_tapp/constants/common_functn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());




  Rx<DateTime> dob = DateTime.now().obs;

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

  @override
  void dispose() {
    registerController.fnClearRegData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()  {
       return registerController.fnBack(context);
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primarycolor,
        appBar: AppBar(
          elevation: 0,
          title: tsw(AppStrings.registration,AppColors.white,20,FontWeight.w500),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
               registerController.fnBack(context);
            }
          ),
          actions: [
            IconButton(onPressed: (){
              dprint("Edittt");
              Get.to(() => LookupSearch(
                callbackfn: (data) {
                  if(data!=null && data["SLCODE"]!=''){
                    registerController.isAvailbleSlcode.value = true;
                    registerController.slcode.value = data["SLCODE"];
                    dprint("name:>>>  ${data["SLDESCP"]}");
                    dprint("email:>>>  ${data["EMAIL"]}");
                    dprint("dob:>>>  ${data["DOB"]}");
                    dprint("Slcodeeee:>>>  ${data["SLCODE"]}");
                    dprint("  registerController.isAvailbleSlcode>>>> ${  registerController.isAvailbleSlcode.value}");
                    dprint(data);
                    registerController.f_name_controller.text = data["SLDESCP"];
                    registerController.mail_controller.text = data["EMAIL"];
                    registerController.phone_controller.text = data["MOBILE"]??"";
                    registerController.address_controller.text = data["ADDRESS1"]??"";
                    registerController.city_controller.text = data["CITY"]??"";
                    if(data["GENDER"]=="M"){
                      registerController.gender_select.value ="Male";
                    }else if( data["GENDER"]=="F"){
                      registerController.gender_select.value ="Female";
                    }else if( data["GENDER"]=="O"){
                      registerController.gender_select.value ="Other";
                    }else{
                      registerController.gender_select.value ="";
                    }


                   try{
                     dob.value = DateTime.parse(data["DOB"].toString());
                   }catch(e){
                      dprint(e.toString());
                   }



                    Get.back();
                  }


                },
                table_name: "SLMAST",
                column_names: const [
                  {"COLUMN": "SLCODE", 'DISPLAY': "Code#: "},
                  {"COLUMN": "SLDESCP", 'DISPLAY': "Name: "},
                  {"COLUMN": "MOBILE", 'DISPLAY': "Mobile No: "},
                  {"COLUMN": "EMAIL", 'DISPLAY': "Email: "},
                  {"COLUMN": "ADDRESS1", 'DISPLAY': "N"},
                  {"COLUMN": "GENDER", 'DISPLAY': "N"},
                  {"COLUMN": "DOB", 'DISPLAY': "N"},
                  {"COLUMN": "CITY", 'DISPLAY': "N"},
                ],
                filter: [],
              ));
            },
                icon: const Icon(Icons.edit,color: AppColors.white,size: 25,)),

          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: size.height,
            width: size.width,
            decoration:  commonBoxDecoration(AppColors.white),
            padding: const EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
                child: Form(
                  key:registerController.regformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWithUnderLine(title: AppStrings.registration,),
                      gapHC(20),
                      tsw("Full Name",AppColors.fontcolor,14,FontWeight.w500),
                      gapHC(4),
                      CommonTextfield(controller: registerController.f_name_controller,textFormFieldType: TextFormFieldType.fullName, opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Name',),
                      gapHC(20),
                      tsw("Email",AppColors.fontcolor,14,FontWeight.w500),
                      gapHC(4),
                      CommonTextfield(controller:  registerController.mail_controller,textFormFieldType: TextFormFieldType.email, opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Email',),
                      gapHC(20),
                      tsw("Mobile Number",AppColors.fontcolor,14,FontWeight.w500),
                      gapHC(4),
                      CountrySelectorTextInput(textFieldcontroller: registerController.phone_controller,textFormFieldType: TextFormFieldType.mobileNumber),
                      gapHC(20),
                      tsw("Dob",AppColors.fontcolor,14,FontWeight.w500),
                      gapHC(4),
                      wDateField(),
                      gapHC(20),
                      tsw("Gender",AppColors.fontcolor,14,FontWeight.w500),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          addRadioButton(0, 'Male',size),
                          addRadioButton(1, 'Female',size),
                          addRadioButton(2, 'Others',size),
                        ],
                      ),
                      gapHC(10),
                      tsw("Address",AppColors.fontcolor,14,FontWeight.w500),
                      gapHC(4),
                      CommonTextfield(controller: registerController.address_controller, textFormFieldType: TextFormFieldType.address,opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Address',maxline: 6),
                      gapHC(20),
                      tsw("City",AppColors.fontcolor,14,FontWeight.w500),
                      gapHC(4),

                      wCityTextfield(),

                    //  CommonTextfield(controller: registerController.city_controller,  textFormFieldType: TextFormFieldType.city,opacityamount: 0.17,shadow: 30.0, hintText: 'Guest City',),

                      gapHC(90),

                      Obx(() => registerController.isAvailbleSlcode.value?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(

                            flex: 3,

                            child: CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Update", onpressed: (){
                              dprint("edittttt");
                              dob.value= DateTime.now();

                              registerController.fnRegisteration(registerController.gender_select.value,dob.value);

                              //  registerController.fnRegisteration(registerController.gender_select.value,dob.value);
                              //   Get.to( CardIssueScreen(cardIssueFrom: CardIssueFro m.register));
                            }, ),
                          ),
                          gapWC(8),
                          Flexible(
                            flex: 1,
                            child: CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Close", onpressed: (){
                              dprint("clooooseeeee");
                              dob.value= DateTime.now();


                              registerController.fnClearRegData();
                              //   registerController.fnRegisteration(registerController.gender_select.value,dob.value);
                              //   Get.to( CardIssueScreen(cardIssueFrom: CardIssueFro m.register));
                            }, ),
                          ),

                        ],
                      )  : CommonButton(buttoncolor: AppColors.primarycolor, icon_need: false,buttonText: "Register", onpressed: (){
                        registerController.fnRegisteration(registerController.gender_select.value,dob.value);
                        //   Get.to( CardIssueScreen(cardIssueFrom: CardIssueFro m.register));
                      }, ),),
                      gapHC(10),



                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addRadioButton(int btnValue, String title,Size size) {
    return Obx(() =>  Flexible(

      child: RadioListTile(
        activeColor: AppColors.primarycolor,
        contentPadding: EdgeInsets.zero,
        value: registerController.gender[btnValue],
        groupValue: registerController.gender_select.value,
        dense: true,
        onChanged: (value){
          print(value);
          registerController.gender_select.value = value;
          print("Gender value>>>> ${registerController.gender_select.value}");
        },

        title: Text(title),
      ),
    ));
  }
  wDateField(){
    return Material(
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
    );
  }
  wCityTextfield(){
    return Material(
      elevation: 30,
      borderRadius: BorderRadius.circular(8) ,
      shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
      child: TextFormField(
        showCursor:false,
        autofocus: false,
        keyboardType: TextInputType.none,
        controller: registerController.city_controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          hintText: "Guest City",
          fillColor: Colors.white,
          hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
          filled: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),


        ),
        onTap: (){
          print("object");
          Get.to(() => LookupSearch(
            callbackfn: (data) {
              if(data!=null){
                dprint("CODE:>>>  ${data["CODE"]}");
                dprint("DESCP:>>>  ${data["DESCP"]}");
                registerController.city_controller.text = data["CODE"].toString();
                Get.back();
              }

            },
            table_name: "CITYMASTER",
            column_names: const [
              {"COLUMN": "CODE", 'DISPLAY': "CODE: "},
              {"COLUMN": "DESCP", 'DISPLAY': "NAME: "},

            ],
            filter: [],
          )
          );
        },

      ),
    );
  }
}
