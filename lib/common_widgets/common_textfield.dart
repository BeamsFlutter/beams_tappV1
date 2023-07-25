import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/inputFormattor.dart';
import 'package:beams_tapp/utils/textfieldValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextfield extends StatelessWidget {

 // final RegisterController registerController = Get.put(RegisterController());
  final TextEditingController controller;
  final double shadow;
  final int maxline;
  final double opacityamount;
  final String hintText;
  final TextFormFieldType textFormFieldType;
  Function ? onChangeCallback;
  final bool? paymentEnable;
  final bool? enable;
  final String ? label;

  CommonTextfield({Key? key,required this.controller,required this.textFormFieldType,required this.shadow,required this.opacityamount,required this.hintText,this.maxline=1,
  this.onChangeCallback,this.paymentEnable, this.enable, this.label}) : super(key: key);

  typeKeyboard(txtformtype){
    if(txtformtype ==  TextFormFieldType.amount ||txtformtype ==  TextFormFieldType.card_exp_days||txtformtype ==  TextFormFieldType.register_amount||txtformtype ==  TextFormFieldType.renew_charge||
        txtformtype ==  TextFormFieldType.duplicate_charge||  txtformtype ==  TextFormFieldType.itemPrice){
      return  TextInputType.number;
    }else if(txtformtype==TextFormFieldType.city){
      return TextInputType.none;
    }

    else{
      return TextInputType.emailAddress;
    }

  }
  iconOnsuffix(txtformtype,context){
    if(txtformtype==TextFormFieldType.city){
      return const Icon(Icons.keyboard_arrow_down,color: AppColors.lightfontcolor,);
    }else if(txtformtype==TextFormFieldType.search){
      return const Icon(Icons.search,color: AppColors.lightfontcolor,);
    }
  }
  inputFormator(textformtype){
    if(textformtype==TextFormFieldType.mobileNumber||textformtype==TextFormFieldType.card_exp_days){
      return InputFormattor.mfnInputFormatters();
    }
    else if(textformtype==TextFormFieldType.amount||textformtype==TextFormFieldType.register_amount||textformtype==TextFormFieldType.renew_charge||textformtype==TextFormFieldType.duplicate_charge
    || textformtype==TextFormFieldType.itemPrice){
      return InputFormattor.mfnInputDecFormatters();
    }

  }
  labelText(textformtype){
    if(textformtype==TextFormFieldType.counterCode ||textformtype==TextFormFieldType.counterDescrptn||textformtype==TextFormFieldType.userPasscode||textformtype==TextFormFieldType.username||
        textformtype==TextFormFieldType.userCode||
        textformtype==TextFormFieldType.itemCode ||textformtype==TextFormFieldType.itemDescrptn||textformtype==TextFormFieldType.itemPrice){
      return Text(label!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: shadow,
      borderRadius: BorderRadius.circular(20) ,
      shadowColor: AppColors.lightfontcolor.withOpacity(opacityamount),
      child: TextFormField(
        keyboardType: typeKeyboard(textFormFieldType),
        inputFormatters: inputFormator(textFormFieldType),
        showCursor: textFormFieldType==TextFormFieldType.city?false:true,
        enabled: enable??true,
        autofocus: false,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines:maxline ,
        onChanged: (content){
          if(onChangeCallback==null){
            return;
          }
          onChangeCallback!(content);
        },

        decoration: InputDecoration(
            label: labelText(textFormFieldType),
            hintText: hintText,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
            filled: true,
            border: textFormFieldType==TextFormFieldType.search?  const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ): InputBorder.none,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            suffixIcon:iconOnsuffix(textFormFieldType,context),
          // enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0),
          //     borderSide: const BorderSide(color: Colors.white, width: 3.0)),
          //
          // errorBorder:  const OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5)),
          //     borderSide: BorderSide(color: AppColors.subcolor)),
          // focusedErrorBorder:  const OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5)),
          //     borderSide: BorderSide(color: AppColors.subcolor)),
          errorStyle: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.red),

        ),
        validator: (String? value) {
         return FormValidator.isValid(textFormFieldType, value ?? "",paymentEnable);

        },
      ),
    );
  }
}

onChangedtextfield(TextFormFieldType textFormFieldType,String content) {
  if(textFormFieldType==TextFormFieldType.search){
    dprint(content);
  }
}





