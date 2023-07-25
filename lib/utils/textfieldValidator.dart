
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/reg_exp.dart';
import 'package:beams_tapp/constants/string_constant.dart';

class FormValidator {

  static isValid(TextFormFieldType type, String value, [bool ? paymentEnable]) {
    RegExp emailRegex =  RegExp(Regex.emailRegex);
    RegExp phnRegex =  RegExp(Regex.phoneRegex);
    RegExp nameRegx = RegExp(Regex.nameRegex);
    switch (type) {
      case TextFormFieldType.email:
        if (value.isEmpty) {
          return AppStrings.emptyEmail;
        } else if (!emailRegex.hasMatch(value)) {
          return AppStrings.invalidUserInput;
        } else {
          return null;
        }
        break;
      case TextFormFieldType.mobileNumber:
        if (value.isEmpty) {
          return AppStrings.emptyMobileeNumber;
        } else if(!phnRegex.hasMatch(value)){
          return AppStrings.invalidPhoneNumber;
        }
        else {
          return null;
        }
        break;
      case TextFormFieldType.fullName:
        if (value.isEmpty) {
          dprint("empty nameeee");
          return AppStrings.emptyFulltName;
        } else if(!nameRegx.hasMatch(value)) {
          return AppStrings.invalidName;
        } else {
          return null;
        }
        break;
      case TextFormFieldType.amount:
        if (value.isEmpty) {
          dprint(" emptyTopupamount");
          return paymentEnable==true? AppStrings.emptyTopupamount:null;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.card_exp_days:
        if (value.isEmpty) {
          return AppStrings.emptyExpdate;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.register_amount:
        if (value.isEmpty) {

          return  AppStrings.emptyRegAmount;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.renew_charge:
        if (value.isEmpty) {

          return AppStrings.emptyRenewCharge;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.duplicate_charge:
        if (value.isEmpty) {

          return AppStrings.emptyDuplicateCharge;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.itemCode:
        if (value.isEmpty) {
          return AppStrings.emptyItemcode;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.itemDescrptn:
        if (value.isEmpty) {
          return AppStrings.emptyItemDescr;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.userCode:
        if (value.isEmpty) {
          return AppStrings.emptyUserCode;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.username:
        if (value.isEmpty) {
          return AppStrings.emptyUsername;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.userPasscode:
        if (value.isEmpty) {
          return AppStrings.emptyUserpasscode;
        }  else {
          return null;
        }
        break;

      case TextFormFieldType.adminUsername:
        if (value.isEmpty) {
          return AppStrings.emptyUsername;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.adminUserCode:
        if (value.isEmpty) {
          return AppStrings.emptyUserCode;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.adminUserPasscode:
        if (value.isEmpty) {
          return AppStrings.emptyUserpasscode;
        }  else {
          return null;
        }
        break;
      case TextFormFieldType.adminUserPassword:
        if (value.isEmpty) {
          return AppStrings.emptyPassword;
        }  else {
          return null;
        }
        break;



    }
  }

  static isMobileNumValid(String mobnumb,String country_code){
    dprint("mobnumb  ${mobnumb}   countrycode ${country_code}");
    var mobnumblength = mobnumb.length.toString();
    var countrylength = country_code.length.toString();
    dprint("mobnumbLength  ${mobnumblength} ");
    dprint("countrylength  ${countrylength} ");

    var totallength = int.parse(mobnumblength)+int.parse(countrylength);
    dprint("totallle ${totallength}");
    if (mobnumb.isEmpty) {
      return AppStrings.emptyMobileeNumber;
    }else if(totallength==13){
      return null;
    } else {
      return AppStrings.invalidPhoneNumber;
    }

  }
}