
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/countrycode.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/inputFormattor.dart';
import 'package:beams_tapp/utils/textfieldValidator.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class CountrySelectorTextInput extends StatefulWidget {
  final TextEditingController textFieldcontroller;
  final TextFormFieldType textFormFieldType;
  final bool?enable;

  CountrySelectorTextInput({required this.textFieldcontroller,required this.textFormFieldType,this.enable});

  @override
  State<CountrySelectorTextInput> createState() => _CountrySelectorTextInputState();
}

class _CountrySelectorTextInputState extends State<CountrySelectorTextInput> {


  final CommonController commonController = Get.put(CommonController());



  onCountryChange(CountryCode countryCode) async{
    commonController.selectcountry.value =  countryCode.toString();
    // await SharedPreference.savecountrycode(countrycode: _selectcountry.toString());
    print("New Country selected: " + commonController.selectcountry.toString());
  }

  Widget getPrefixIcon(){
    return CountryCodePicker(
      hideMainText: true,
      dialogTextStyle:const TextStyle(
          color: Colors.black,
          // fontFamily: AppFont.defaultAppFont,
          fontSize: 14,
          fontWeight: FontWeight.w300
      ),
      boxDecoration:  const BoxDecoration(
        // color: const Color(0xFF171527).withOpacity(1),
          color: Colors.white

      ),
      dialogSize: Size(MediaQuery.of(context).size.width/1.3, MediaQuery.of(context).size.height*0.8),
      enabled: widget.enable??true,
      alignLeft: false,
      showOnlyCountryWhenClosed: false,
      showFlag: true,
      flagWidth: 20.3,
      padding: EdgeInsets.all(5) ,
      countryList: countryCodeList,
      onChanged: onCountryChange,
      initialSelection: commonController.selectcountry.value,
      favorite: ['+971','AE'],
      // showCountryOnly: false,
      // showFlagDialog: true,
      searchStyle:  const TextStyle(
          color: Colors.black,
          // fontFamily: AppFont.defaultAppFont,
          fontSize: 14,
          fontWeight: FontWeight.w300
      ),
      showFlagMain: true,
      searchDecoration:  const InputDecoration(
        prefixIconColor: Colors.black,
        suffixIconColor:  Colors.black,
        fillColor:  Colors.black,
        hoverColor:  Colors.black,
        iconColor:  Colors.black,focusColor:  Colors.black,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.primarycolor)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primarycolor,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primarycolor),
        ),
      ),

      // optional. Shows only country name and flag when popup is closed.

      // optional. aligns the flag and the Text left
      showDropDownButton: true,
      //
      // textStyle: const TextStyle(
      //     color: Colors.black,
      //     // fontFamily: AppFont.defaultAppFont,
      //     fontSize: 14,
      //     fontWeight: FontWeight.w300
      // ),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 30,
      borderRadius: BorderRadius.circular(20) ,
        shadowColor: AppColors.lightfontcolor.withOpacity(0.3),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.textFieldcontroller,
        inputFormatters: InputFormattor.mfnInputFormatters(),

        decoration: InputDecoration(
            hintText: '526912222',
            fillColor: Colors.white,
            hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            prefixIcon: getPrefixIcon(),
            border: InputBorder.none,
            errorStyle: const TextStyle(
               fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.red),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

            // suffixIcon:iconOnsuffix(textFormFieldType)
        ),
        validator: (String? value) {
          return FormValidator.isMobileNumValid(value??"",commonController.selectcountry.value);

        },
          ),
    );
  }
}
