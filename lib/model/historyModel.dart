class HistoryModel {
  List<HISTORY>? hISTORY;

  HistoryModel({this.hISTORY});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['HISTORY'] != null) {
      hISTORY = <HISTORY>[];
      json['HISTORY'].forEach((v) {
        hISTORY!.add(new HISTORY.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hISTORY != null) {
      data['HISTORY'] = this.hISTORY!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HISTORY {
  String? cOMPANY;
  String? dOCNO;
  String? dOCTYPE;
  int? sRNO;
  String? bRNCODE;
  String? dOCDATE;
  String? dBCR;
  num? aMT;
  String? cARDNO;
  String? tITLE;
  String? sLDESC;
  String? mOBILE;
  String? eMAIL;
  String? deviceName;
  String? cREATEUSER;


  HISTORY(
      {this.cOMPANY,
        this.dOCNO,
        this.dOCTYPE,
        this.sRNO,
        this.bRNCODE,
        this.dOCDATE,
        this.dBCR,
        this.aMT,
        this.cARDNO,
        this.tITLE,
        this.sLDESC,
        this.mOBILE,
        this.eMAIL,
        this.deviceName,
        this.cREATEUSER



      });

  HISTORY.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    dOCNO = json['DOCNO'];
    dOCTYPE = json['DOCTYPE'];
    sRNO = json['SRNO'];
    bRNCODE = json['BRNCODE'];
    dOCDATE = json['DOCDATE'];
    dBCR = json['DB_CR'];
    aMT = json['AMT'];
    cARDNO = json['CARDNO'];
    tITLE = json['TITLE'];
    sLDESC = json['SLDESCP'];
    mOBILE = json['MOBILE'];
    eMAIL = json['EMAIL'];
    deviceName = json['DEVICE_NAME'];
    cREATEUSER = (json['CREATE_USER'])??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['DOCNO'] = this.dOCNO;
    data['DOCTYPE'] = this.dOCTYPE;
    data['SRNO'] = this.sRNO;
    data['BRNCODE'] = this.bRNCODE;
    data['DOCDATE'] = this.dOCDATE;
    data['DB_CR'] = this.dBCR;
    data['AMT'] = this.aMT;
    data['CARDNO'] = this.cARDNO;
    data['TITLE'] = this.tITLE;
    data['SLDESCP'] = this.sLDESC;
    data['MOBILE'] = this.mOBILE;
    data['EMAIL'] = this.eMAIL;
    data['DEVICE_NAME'] = this.deviceName;
    data['CREATE_USER'] = this.cREATEUSER;
    return data;
  }
}