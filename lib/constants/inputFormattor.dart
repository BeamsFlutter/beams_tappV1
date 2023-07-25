import 'package:flutter/services.dart';

class InputFormattor{

  static List<TextInputFormatter> mfnInputFormatters(){
    List<TextInputFormatter> inputFormatters = [];
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);

    return inputFormatters;
  }
  static List<TextInputFormatter> mfnInputDecFormatters(){
    List<TextInputFormatter> inputFormatters = [];
    inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')));

    return inputFormatters;
  }
}

