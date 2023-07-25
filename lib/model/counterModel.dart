
import 'dart:convert';

List<GetCounterModel>getCounterModelFromJson(String str)=>
    List<GetCounterModel>.from(json.decode(str).map((x)=>GetCounterModel.fromJson(x)));

// String getCounterModelToJson(List<GetCounterModel> data)=>
//     json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class GetCounterModel {
  String? cOMPANY;
  String? uSERCD;
  String? sRNO;
  String? bRNCODE;
  String? cOUNTERCODE;
  String? dESCP;
  List<ITEMS>? iTEMS;

  GetCounterModel(
      {this.cOMPANY,
        this.uSERCD,
        this.sRNO,
        this.bRNCODE,
        this.cOUNTERCODE,
        this.dESCP,
        this.iTEMS});

  GetCounterModel.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    uSERCD = json['USERCD'];
    sRNO = json['SRNO'];
    bRNCODE = json['BRNCODE'];
    cOUNTERCODE = json['COUNTER_CODE'];
    dESCP = json['DESCP'];
    if (json['ITEMS'] != null) {
      iTEMS = <ITEMS>[];
      json['ITEMS'].forEach((v) {
        iTEMS!.add(new ITEMS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['USERCD'] = this.uSERCD;
    data['SRNO'] = this.sRNO;
    data['BRNCODE'] = this.bRNCODE;
    data['COUNTER_CODE'] = this.cOUNTERCODE;
    data['DESCP'] = this.dESCP;
    if (this.iTEMS != null) {
      data['ITEMS'] = this.iTEMS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ITEMS {
  String? cOMPANY;
  String? cOUNTERCODE;
  int? sRNO;
  String? iTEMCODE;
  String? cOUNTERDESCP;
  String? iTEMDESCP;
  double? pRICE;

  ITEMS(
      {this.cOMPANY,
        this.cOUNTERCODE,
        this.sRNO,
        this.iTEMCODE,
        this.cOUNTERDESCP,
        this.iTEMDESCP,
        this.pRICE});

  ITEMS.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    cOUNTERCODE = json['COUNTER_CODE'];
    sRNO = json['SRNO'];
    iTEMCODE = json['ITEM_CODE'];
    cOUNTERDESCP = json['COUNTER_DESCP'];
    iTEMDESCP = json['ITEM_DESCP'];
    pRICE = json['PRICE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['COUNTER_CODE'] = this.cOUNTERCODE;
    data['SRNO'] = this.sRNO;
    data['ITEM_CODE'] = this.iTEMCODE;
    data['COUNTER_DESCP'] = this.cOUNTERDESCP;
    data['ITEM_DESCP'] = this.iTEMDESCP;
    data['PRICE'] = this.pRICE;
    return data;
  }
}