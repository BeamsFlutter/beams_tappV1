import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common_widgets/common_textfield.dart';
import '../../common_widgets/commonbutton.dart';
import '../../common_widgets/countryTextfield.dart';
import '../../common_widgets/lookup_search.dart';
import '../../constants/color_code.dart';
import '../../constants/common_functn.dart';
import '../../constants/enums/txt_field_type.dart';
import '../../constants/styles.dart';
import '../controller/tktRegisterController.dart';

class TicketRegisterScreen extends StatefulWidget {
  const TicketRegisterScreen({super.key});

  @override
  State<TicketRegisterScreen> createState() => _TicketRegisterScreenState();
}

class _TicketRegisterScreenState extends State<TicketRegisterScreen> {
  final TicketRegisterController ticketRegisterController = Get.put(TicketRegisterController());

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: MediaQuery.of(context).padding,
        decoration: boxGradientCLBR(
            AppColors.appReaderBgRed, AppColors.appReaderBgBlue, 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tHead("Beams", AppColors.white,),
                          tcnH(
                              "VERSION V1.0",
                              AppColors.appBgGreyshde.withOpacity(0.5),
                              10,
                              TextAlign.center,
                              0.11),
                        ],
                      ),
                      tcS("   Fungate ", AppColors.white, 30),
                    ],
                  ),
                  Container(
                    decoration: boxBaseDecoration(
                        AppColors.appReaderDarkBlck.withOpacity(0.36), 23),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20,
                        ),
                        gapWC(6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc("D0001", AppColors.white, 10),
                            tcnH("DEIRA CITY CENTER", AppColors.white, 10,
                                TextAlign.start, 0.95),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.wifi, color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("192.168.0.100", Colors.white, 12, TextAlign.center)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone_android_outlined,
                          color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("9787826367", Colors.white, 12, TextAlign.center)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance,
                          color: Colors.white, size: 20),
                      gapWC(5),
                      tcn("SPLASH AND PARTY LLC.", Colors.white, 12,
                          TextAlign.start)
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                        flex: 4,
                        child:Container(
                          decoration: boxBaseDecoration(Colors.white, 30),
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tSubHead("Search User", Colors.grey, TextAlign.center),
                              gapHC(5),
                              SizedBox(
                                height: 55,
                                child: TextField(
                                  cursorColor:Colors.black,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.search,color: Colors.grey,size: 35),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide:  BorderSide(color: Colors.black.withOpacity(0.5), width: 1.0),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.black.withOpacity(0.5), width: 1.0),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),



                                  ),
                                ),
                              )

                            ],
                          ),

                        )),
                    gapWC(20),
                    Flexible(
                      flex: 6,
                      child: Container(
                        width: double.maxFinite,

                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key:ticketRegisterController.regformKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tHead2("Full Name",AppColors.white),
                                    gapHC(4),
                                    TcketCommonTextfield(controller: ticketRegisterController.f_name_controller,textFormFieldType: TextFormFieldType.fullName, opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Name',),
                                    gapHC(20),
                                    tHead2("Email",AppColors.white),
                                    gapHC(4),
                                    TcketCommonTextfield(controller:  ticketRegisterController.mail_controller,textFormFieldType: TextFormFieldType.email, opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Email',),
                                    gapHC(20),
                                    tHead2("Mobile Number",AppColors.white),
                                    gapHC(4),
                                    CountrySelectorTextInput(textFieldcontroller: ticketRegisterController.phone_controller,textFormFieldType: TextFormFieldType.mobileNumber,mode: "ticket"),
                                    gapHC(20),
                                    tHead2("Dob",AppColors.white),

                                    gapHC(4),
                                    wDateField(),
                                    gapHC(20),
                                    tHead2("Gender",AppColors.white),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        addRadioButton(0, 'Male',size),
                                        addRadioButton(1, 'Female',size),
                                        addRadioButton(2, 'Others',size),
                                      ],
                                    ),
                                    gapHC(10),
                                    tHead2("Address",AppColors.white),
                                    gapHC(4),
                                    TcketCommonTextfield(controller: ticketRegisterController.address_controller, textFormFieldType: TextFormFieldType.address,opacityamount: 0.17,shadow: 30.0, hintText: 'Guest Address',maxline: 6),
                                    gapHC(20),
                                    tHead2("City",AppColors.white),
                                    gapHC(4),

                                    wCityTextfield(),

                                    //  CommonTextfield(controller: registerController.city_controller,  textFormFieldType: TextFormFieldType.city,opacityamount: 0.17,shadow: 30.0, hintText: 'Guest City',),




                                  ],
                                ),
                                gapHC(40),
                                Row(
                                  children: [
                                    TcketCommonButton(
                                      buttoncolor: Colors.white,
                                      buttonText: "close",
                                      border: Border.all(color: Colors.black,),
                                      icon_need: false,
                                      radius: 40,buttonTextSize: 15,


                                      onpressed: (){
                                        dprint("close");
                                        Get.back();

                                      },         buttonTextColor: Colors.black.withOpacity(0.5),


                                    ),
                                    gapWC(20),
                                    Expanded(
                                      child: TcketCommonButton(
                                        buttoncolor: AppColors.appTicketColor1,
                                        buttonText: "Completed",
                                        icon_need: false,
                                        border: Border.all(color:AppColors.appTicketColor1,),
                                        radius: 40,buttonTextSize: 18,
                                        buttonTextColor: Colors.white,
                                        onpressed: (){
                                          setState(() {
                                           ticketRegisterController.isRechargeCompleted.value=true;
                                          });

                                          //
                                          // ticketRechargeController.wSelectPaymentModeBottomsheet();
                                        },


                                      ),
                                    ),
                                  ],
                                ),
                                gapHC(10),
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            gapHC(20)
          ],
        ),
      ),
    );
  }

  addRadioButton(int btnValue, String title,Size size) {
    return Obx(() =>  Flexible(

      child: RadioListTile(
        activeColor: AppColors.white,
        tileColor: Colors.red,
        fillColor: MaterialStateColor.resolveWith((states) => Colors.white),

        contentPadding: EdgeInsets.zero,
        value: ticketRegisterController.gender[btnValue],
        groupValue: ticketRegisterController.gender_select.value,
        dense: true,
        onChanged: (value){
          print(value);
          ticketRegisterController.gender_select.value = value;
          print("Gender value>>>> ${ticketRegisterController.gender_select.value}");
        },

        title: Text(title,style: TextStyle(color: Colors.white)),
      ),
    ));
  }
  wDateField(){
    return Material(
      elevation: 30,
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: AppColors.lightfontcolor.withOpacity(0.3),
      child: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc(DateFormat('dd-MM-yyyy').format(dob.value), Colors.black, 11),
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
    return TextFormField(
      showCursor:false,
      controller: ticketRegisterController.city_controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:  InputDecoration(
        hintText: "Guest City",
        fillColor: Colors.white,
        hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
        filled: true,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),


      ),
      // onTap: (){
      //   print("object");
      //   Get.to(() => LookupSearch(
      //     callbackfn: (data) {
      //       if(data!=null){
      //         dprint("CODE:>>>  ${data["CODE"]}");
      //         dprint("DESCP:>>>  ${data["DESCP"]}");
      //         ticketRegisterController.city_controller.text = data["CODE"].toString();
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

    );
  }
}
