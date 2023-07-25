import 'package:beams_tapp/constants/dateformates.dart';
import 'package:flutter/foundation.dart';

dprint(val){
  if(kDebugMode){
    print(val);
  }
}

mfnDbl(dbl){
  var lstrDbl = 0.0;

  try {
    lstrDbl =  double.parse((dbl??'0.0').toString());
  }
  catch(e){
    lstrDbl= 0.00;
  }
  return lstrDbl;
}
mfnInt(dbl){
  var lstrInt = 0;
  try {
    lstrInt =  int.parse((dbl??'0.0').toString());
  }
  catch(e){
    lstrInt= 0;
  }
  return lstrInt;
}
mfnDate(date,numb){
  var lstrDate = "";

  try {
    lstrDate =  setDate(numb,DateTime.parse(date.toString()));
  }
  catch(e){
    lstrDate= "";
  }
  return lstrDate;
}

mfnCheckValue(value){
  var sts = false;
  try{
    if(value.isNotEmpty){
      sts = true;
    }
  }catch(e){
    sts = false;
  }
  return sts;
}