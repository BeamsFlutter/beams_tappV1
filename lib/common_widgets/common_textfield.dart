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
  final double ? radius;
  final TextStyle ? textStyle;
  final TextAlign  align;

  CommonTextfield({Key? key,required this.controller,required this.textFormFieldType,required this.shadow,required this.opacityamount,required this.hintText,this.maxline=1,
  this.onChangeCallback,this.paymentEnable, this.enable, this.label,this.radius,this.textStyle,this.align=TextAlign.start}) : super(key: key);

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
        textAlign: align,
        keyboardType: typeKeyboard(textFormFieldType),
        inputFormatters: inputFormator(textFormFieldType),
        showCursor: textFormFieldType==TextFormFieldType.city?false:true,
        enabled: enable??true,
        style: textStyle,
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
            ): OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(mfnDbl(radius)),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
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


class TcketCommonTextfield extends StatelessWidget {

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
  final double ? radius;
  final TextStyle ? textStyle;
  final TextAlign  align;

  TcketCommonTextfield({Key? key,required this.controller,required this.textFormFieldType,required this.shadow,required this.opacityamount,required this.hintText,this.maxline=1,
    this.onChangeCallback,this.paymentEnable, this.enable, this.label,this.radius,this.textStyle,this.align=TextAlign.start}) : super(key: key);

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
    return  TextFormField(
      textAlign: align,
      keyboardType: typeKeyboard(textFormFieldType),
      inputFormatters: inputFormator(textFormFieldType),
      showCursor: textFormFieldType==TextFormFieldType.city?false:true,
      enabled: enable??true,
      style: textStyle,
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
        filled: true,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        label: labelText(textFormFieldType),
        hintText: hintText,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
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
      // decoration: InputDecoration(
      //   label: labelText(textFormFieldType),
      //   hintText: hintText,
      //   fillColor: Colors.white,
      //   hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
      //   filled: true,
      //   border: textFormFieldType==TextFormFieldType.search?  const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(40.0),
      //     ),
      //     borderSide: BorderSide(
      //       width: 0,
      //       style: BorderStyle.none,
      //     ),
      //   ): OutlineInputBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(mfnDbl(radius)),
      //     ),
      //     borderSide: BorderSide(
      //       width: 0,
      //       style: BorderStyle.none,
      //     ),
      //   ),
      //   contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //   suffixIcon:iconOnsuffix(textFormFieldType,context),
      //   // enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0),
      //   //     borderSide: const BorderSide(color: Colors.white, width: 3.0)),
      //   //
      //   // errorBorder:  const OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(5)),
      //   //     borderSide: BorderSide(color: AppColors.subcolor)),
      //   // focusedErrorBorder:  const OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(5)),
      //   //     borderSide: BorderSide(color: AppColors.subcolor)),
      //   errorStyle: const TextStyle(
      //       fontSize: 9,
      //       fontWeight: FontWeight.w500,
      //       color: Colors.red),
      //
      // ),
      // validator: (String? value) {
      //   return FormValidator.isValid(textFormFieldType, value ?? "",paymentEnable);
      // },
    );
  }
}

class Adminv1CommonTextfield extends StatelessWidget {

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
  final bool  isObscure;
  final String ? label;
  final double ? radius;
  final TextStyle ? textStyle;
  final TextAlign  align;
  final Widget  ?suffixIcon;
  final Widget  ?prefixIcon;

  Adminv1CommonTextfield({Key? key,required this.controller,required this.textFormFieldType,required this.shadow,required this.opacityamount,required this.hintText,this.maxline=1,
    this.onChangeCallback,this.paymentEnable, this.enable, this.label,this.radius,this.textStyle,this.align=TextAlign.start,  this.suffixIcon,this.prefixIcon, this.isObscure=false}) : super(key: key);

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
    return  TextFormField(
      textAlign: align,
      keyboardType: typeKeyboard(textFormFieldType),
      inputFormatters: inputFormator(textFormFieldType),
      enabled: enable??true,
      obscureText: isObscure,
      obscuringCharacter: '*',
      style: textStyle,
      autofocus: false,cursorColor: Colors.white,
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
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.white,width: 2,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.white,width: 2,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.white,width: 2,),
        ),



        label: labelText(textFormFieldType),
        hintText: hintText,
        fillColor: Colors.transparent,
        hintStyle:  TextStyle(color:  AppColors.white.withOpacity(0.7), fontSize: 13),

        suffixIcon:suffixIcon,
        prefixIcon: prefixIcon,
        errorStyle: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.red),

      ),

      validator: (String? value) {
        return FormValidator.isValid(textFormFieldType, value ?? "",paymentEnable);

      },
      // decoration: InputDecoration(
      //   label: labelText(textFormFieldType),
      //   hintText: hintText,
      //   fillColor: Colors.white,
      //   hintStyle: const TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
      //   filled: true,
      //   border: textFormFieldType==TextFormFieldType.search?  const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(40.0),
      //     ),
      //     borderSide: BorderSide(
      //       width: 0,
      //       style: BorderStyle.none,
      //     ),
      //   ): OutlineInputBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(mfnDbl(radius)),
      //     ),
      //     borderSide: BorderSide(
      //       width: 0,
      //       style: BorderStyle.none,
      //     ),
      //   ),
      //   contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //   suffixIcon:iconOnsuffix(textFormFieldType,context),
      //   // enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0),
      //   //     borderSide: const BorderSide(color: Colors.white, width: 3.0)),
      //   //
      //   // errorBorder:  const OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(5)),
      //   //     borderSide: BorderSide(color: AppColors.subcolor)),
      //   // focusedErrorBorder:  const OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(5)),
      //   //     borderSide: BorderSide(color: AppColors.subcolor)),
      //   errorStyle: const TextStyle(
      //       fontSize: 9,
      //       fontWeight: FontWeight.w500,
      //       color: Colors.red),
      //
      // ),
      // validator: (String? value) {
      //   return FormValidator.isValid(textFormFieldType, value ?? "",paymentEnable);
      // },
    );
  }
}


wCommonTextFieldAdminV1(TextEditingController controller,[width,maxline=1,inputFormattor]){
  return SizedBox(
    height: maxline>1?80:35,
    width: width,
    child: TextField(
      controller: controller,
      cursorColor: Colors.black,maxLines: maxline,
      inputFormatters: inputFormattor,
      style: TextStyle(fontSize: 13),
      decoration: InputDecoration(

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(15.0),
          borderSide: BorderSide(
              color: AppColors.appAdminColor2),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: AppColors.white),
        //   borderRadius:
        //   BorderRadius.circular(30.0),
        // ),
        // fillColor: AppColors.white,
        contentPadding:const EdgeInsets.only(
            bottom: 5, left: 8,top: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.appAdminColor2),
          borderRadius:
          BorderRadius.circular(20.0),
        ),
      ),

    ),
  );

}
// wCommonTextFieldAdminV1(controller,[height,width,maxline]){
//   return SizedBox(
//     height: height,
//     width: width,
//
//     child: Material(
//       elevation: 2.0,
//       shadowColor: Colors.grey.shade100,
//       shape: RoundedRectangleBorder(
//           borderRadius:
//           BorderRadius.circular(20)),
//       child: TextField(
//         controller: controller,
//         cursorColor: Colors.black,maxLines: maxline,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius:
//             BorderRadius.circular(30.0),
//             borderSide: BorderSide(
//                 color: AppColors.appAdminColor2),
//           ),
//           // enabledBorder: OutlineInputBorder(
//           //   borderSide: BorderSide(
//           //       color: AppColors.white),
//           //   borderRadius:
//           //   BorderRadius.circular(30.0),
//           // ),
//           fillColor: AppColors.white,
//           contentPadding: EdgeInsets.only(
//               bottom: 5, left: 8),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: Colors.black),
//             borderRadius:
//             BorderRadius.circular(30.0),
//           ),
//         ),
//
//       ),
//     ),
//   );
//
// }