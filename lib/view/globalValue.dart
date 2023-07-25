

import 'dart:convert';

import 'package:intl/intl.dart';

class Global {

  static final Global _instance = Global._internal();

  // passes the instantiation to the _instance object
  factory Global() => _instance;

  //initialize variables in here
  Global._internal() {
    var company = '';
    var yearcode = '';

  }
  get wstrToken => wstrToken;

  set wstrToken(value) {
    wstrToken = value;
  }

}