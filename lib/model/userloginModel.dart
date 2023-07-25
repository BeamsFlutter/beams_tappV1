class UserLoginModel {
  String? sTATUS;
  String? mSG;
  DATA? dATA;
  List<COUNTER>? cOUNTER;

  UserLoginModel({this.sTATUS, this.mSG, this.dATA, this.cOUNTER});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    mSG = json['MSG'];
    dATA = json['DATA'] != null ? new DATA.fromJson(json['DATA']) : null;
    if (json['COUNTER'] != null) {
      cOUNTER = <COUNTER>[];
      json['COUNTER'].forEach((v) {
        cOUNTER!.add(new COUNTER.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['MSG'] = this.mSG;
    if (this.dATA != null) {
      data['DATA'] = this.dATA!.toJson();
    }
    if (this.cOUNTER != null) {
      data['COUNTER'] = this.cOUNTER!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DATA {
  String? uSERCD;
  String? uSERNAME;
  String? rOLECODE;
  String? rOLEDESCP;
  String? mOB1;
  String? mOB2;
  String? eMAIL;
  String? aDD1;
  String? aDD2;
  String? cOMPANY;
  String? cOMPANYDESCP;
  String? deviceName;

  DATA(
      {this.uSERCD,
        this.uSERNAME,
        this.rOLECODE,
        this.rOLEDESCP,
        this.mOB1,
        this.mOB2,
        this.eMAIL,
        this.aDD1,
        this.aDD2,
        this.cOMPANY,
        this.cOMPANYDESCP,
        this.deviceName
      });

  DATA.fromJson(Map<String, dynamic> json) {
    uSERCD = json['USER_CD'];
    uSERNAME = json['USERNAME'];
    rOLECODE = json['ROLE_CODE'];
    rOLEDESCP = json['ROLE_DESCP'];
    mOB1 = json['MOB1']??"";
    mOB2 = json['MOB2']??"";
    eMAIL = json['EMAIL']??"";
    aDD1 = json['ADD1']??"";
    aDD2 = json['ADD2']??"";
    cOMPANY = json['COMPANY'];
    cOMPANYDESCP = json['COMPANY_DESCP'];
    deviceName = json['DEVICE_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_CD'] = this.uSERCD;
    data['USERNAME'] = this.uSERNAME;
    data['ROLE_CODE'] = this.rOLECODE;
    data['ROLE_DESCP'] = this.rOLEDESCP;
    data['MOB1'] = this.mOB1;
    data['MOB2'] = this.mOB2;
    data['EMAIL'] = this.eMAIL;
    data['ADD1'] = this.aDD1;
    data['ADD2'] = this.aDD2;
    data['COMPANY'] = this.cOMPANY;
    data['COMPANY_DESCP'] = this.cOMPANYDESCP;
    data['DEVICE_NAME'] = this.deviceName;
    return data;
  }
}

class COUNTER {
  String? cOMPANY;
  String? uSERCD;
  String? sRNO;
  String? bRNCODE;
  String? cOUNTERCODE;

  COUNTER(
      {this.cOMPANY, this.uSERCD, this.sRNO, this.bRNCODE, this.cOUNTERCODE});

  COUNTER.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    uSERCD = json['USERCD'];
    sRNO = json['SRNO'];
    bRNCODE = json['BRNCODE']??"";
    cOUNTERCODE = json['COUNTER_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['USERCD'] = this.uSERCD;
    data['SRNO'] = this.sRNO;
    data['BRNCODE'] = this.bRNCODE;
    data['COUNTER_CODE'] = this.cOUNTERCODE;
    return data;
  }
}