import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

setDate(mode,DateTime date){
  var dateRtn  = "";
  var formatDate1 = DateFormat('yyyy-MM-dd hh:mm:ss');
  var formatDate2 = DateFormat('yyyy-MM-dd');
  var formatDate3 = DateFormat('yyyy-MM-dd hh:mm');
  var formatDate4 = DateFormat('yyyy-MM-dd hh:mm:ss a');
  var formatDate5 = DateFormat('hh:mm:ss a');
  var formatDate6 = DateFormat('dd-MM-yyyy');
  var formatDate7 = DateFormat('dd-MM-yyyy hh:mm:ss a');
  var formatDate8 = DateFormat('dd-MM-yyyy hh:mm:ss');
  var formatDate9 = DateFormat('dd-MM-yyyy hh:mm');
  var formatDate10 = DateFormat('hh:mm:ss');
  var formatDate11 = DateFormat('hh:mm a');
  var formatDate12 = DateFormat('yyyy-MM-dd');
  var formatDate13 = DateFormat('dd-MMM-yyyy');
  var formatDate14 = DateFormat('MMMM');
  var formatDate15 = DateFormat('dd MMM yyyy hh:mm a');
  var formatDate16 = DateFormat('MMMM dd,yyyy hh:mm a');

  try{
    switch(mode){
      case 1:{
        dateRtn =  formatDate1.format(date);
      }
      break;
      case 2:{
        dateRtn =  formatDate2.format(date);
      }
      break;
      case 3:{
        dateRtn =  formatDate3.format(date);
      }
      break;
      case 4:{
        dateRtn =  formatDate4.format(date);
      }
      break;
      case 5:{
        dateRtn =  formatDate5.format(date);
      }
      break;
      case 6:{
        dateRtn =  formatDate6.format(date);
      }
      break;
      case 7:{
        dateRtn =  formatDate7.format(date);
      }
      break;
      case 8:{
        dateRtn =  formatDate8.format(date);
      }
      break;
      case 9:{
        dateRtn =  formatDate9.format(date);
      }
      break;
      case 10:{
        dateRtn =  formatDate10.format(date);
      }
      break;
      case 11:{
        dateRtn =  formatDate11.format(date);
      }
      break;
      case 12:{
        dateRtn =  formatDate12.format(date);
      }
      break;
      case 13:{
        dateRtn =  formatDate13.format(date);
      }
      break;
      case 14:{
        dateRtn =  formatDate14.format(date);
      }
      break;
      case 15:{
        dateRtn =  formatDate15.format(date);
      }
      break;
      case 16:{
        dateRtn =  formatDate16.format(date);
      }
      break;
      default: {
        //statements;
      }
      break;

    }



  }catch(e){
    if (kDebugMode) {
      print(e);
    }
  }

  return dateRtn;

}