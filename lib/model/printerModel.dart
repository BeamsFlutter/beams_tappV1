
import 'dart:convert';

// List<PrinterModel>getPrinterModel(String str)=>
//     List<PrinterModel>.from(json.decode(str).map((x)=>PrinterModel.fromJson(x)));


class PrinterModel {
  String? cODE;
  String? nAME;
  String? pATH;

  PrinterModel({this.cODE, this.nAME, this.pATH});

  PrinterModel.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    nAME = json['NAME'];
    pATH = json['PATH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODE'] = this.cODE;
    data['NAME'] = this.nAME;
    data['PATH'] = this.pATH;
    return data;
  }
}