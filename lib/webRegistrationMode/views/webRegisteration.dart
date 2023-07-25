import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common_widgets/common_textfield.dart';
import '../../common_widgets/countryTextfield.dart';
import '../../common_widgets/title_withUnderline.dart';
import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/enums/txt_field_type.dart';
import '../../constants/string_constant.dart';
import '../../constants/styles.dart';
import '../controller/webregistrtion_controller.dart';



class WebRegisatrtionScreen extends StatefulWidget {
  const WebRegisatrtionScreen({Key? key}) : super(key: key);

  @override
  State<WebRegisatrtionScreen> createState() => _WebRegisatrtionScreenState();
}



class _WebRegisatrtionScreenState extends State<WebRegisatrtionScreen> {
  final WebRegistrtionController webRegistrtionController = Get.put(WebRegistrtionController());
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
      // webRegistrtionController.fnPhoneDetails();
     webRegistrtionController.fnGettoken();

    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,


      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration:  commonBoxDecoration(AppColors.white),

        padding:const  EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      height: size.height,
                      decoration:  commonBoxDecoration(AppColors.white),
                      padding: const EdgeInsets.only(left: 20,top: 10,right: 20) ,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [

                          Padding(
                            padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
                            child: Form(
                              key: webRegistrtionController.registerformKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  tsw("Full Name",AppColors.fontcolor,14,FontWeight.w500),
                                  gapHC(4),
                                  SizedBox(
                                      width: 500,
                                      child: CommonTextfield(controller: webRegistrtionController.f_name_controller,
                                        textFormFieldType: TextFormFieldType.fullName, enable:true,
                                        opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Name',)),
                                  gapHC(20),
                                  tsw("Email",AppColors.fontcolor,14,FontWeight.w500),
                                  gapHC(4),
                                  SizedBox(          width: 500,
                                      child: CommonTextfield(controller:  webRegistrtionController.mail_controller,textFormFieldType: TextFormFieldType.email,
                                        enable:true, opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Email',)),
                                  gapHC(20),
                                  tsw("Mobile Number",AppColors.fontcolor,14,FontWeight.w500),
                                  gapHC(4),
                                  SizedBox(          width: 500,
                                      child: CountrySelectorTextInput(textFieldcontroller: webRegistrtionController.phone_controller,
                                          textFormFieldType: TextFormFieldType.mobileNumber)),
                                  gapHC(20),
                                  tsw("Dob",AppColors.fontcolor,14,FontWeight.w500),
                                  gapHC(4),
                                  wDateField(),
                                  gapHC(20),
                                  tsw("Gender",AppColors.fontcolor,14,FontWeight.w500),
                                  SizedBox(        width: 500,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        addRadioButton(0, 'Male',size),
                                        addRadioButton(1, 'Female',size),
                                        addRadioButton(2, 'Others',size),
                                      ],
                                    ),
                                  ),
                                  gapHC(10),
                                  tsw("Address",AppColors.fontcolor,14,FontWeight.w500),
                                  gapHC(4),
                                  SizedBox(           width: 500,
                                      child: CommonTextfield(controller: webRegistrtionController.address_controller,
                                          enable:true,textFormFieldType: TextFormFieldType.address,opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Address',maxline: 6)),
                                  gapHC(20),



                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(

                              children: [
                                SizedBox(
                                  width:500,
                                  child: Bounce(
                                    onPressed: (){
                                      webRegistrtionController.apiRegister(webRegistrtionController.gender_select.value,dob.value);
                                    },
                                    duration:const Duration(milliseconds: 110),
                                    child: Container(

                                        padding: const EdgeInsets.all(10),
                                        decoration: boxDecoration(AppColors.primarycolor, 50),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            tcnw("Register", AppColors.white, 14,TextAlign.center,FontWeight.w400),      gapWC(2),

                                            const Icon(Icons.check,color: AppColors.white,size: 15,)
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                                gapHC(5),
                                SizedBox(
                                  width: 500,
                                  child: Bounce(
                                    onPressed: (){
                                      webRegistrtionController.fnClear();
                                    },
                                    duration:const Duration(milliseconds: 110),
                                    child: Container(

                                        padding: const EdgeInsets.all(10),
                                        decoration: boxOutlineCustom(Colors.white, 50, Colors.black),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            tcnw("Cancel", Colors.black, 14,TextAlign.center,FontWeight.w400),
                                            gapWC(2),
                                            const Icon(Icons.close,color: Colors.black,size: 15,)
                                          ],
                                        )
                                    ),
                                  ),
                                ),



                              ],
                            ),
                          ),


                        ],
                      )
                  ),
                ),
              ),
            )
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
        value: webRegistrtionController.gender[btnValue],
        groupValue: webRegistrtionController.gender_select.value,
        dense: true,
        onChanged: (value){
          print(value);
          webRegistrtionController.gender_select.value = value;
          print("Gender value>>>> ${webRegistrtionController.gender_select.value}");
        },

        title: Text(title),
      ),
    ));
  }


  wDateField(){
    return SizedBox(          width: 500,
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
          enabled:true,
          keyboardType: TextInputType.none,
          controller: webRegistrtionController.city_controller,
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
