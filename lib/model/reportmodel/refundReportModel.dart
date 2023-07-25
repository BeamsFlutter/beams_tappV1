class RefundReportModel {
  List<DATA>? dATA;

  RefundReportModel({this.dATA});

  RefundReportModel.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      dATA = <DATA>[];
      json['DATA'].forEach((v) {
        dATA!.add(new DATA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dATA != null) {
      data['DATA'] = this.dATA!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DATA {
  String? cOMPANY;
  String? dOCNO;
  String? dOCTYPE;
  String? dOCDATE;
  String? cARDNO;
  String? sLCODE;
  String? sLDESCP;
  String? mOBILE;
  String? eMAIL;
  String? dID;
  String? dNAME;
  num? aMT;
  String? cREATEUSER;

  DATA(
      {this.cOMPANY,
        this.dOCNO,
        this.dOCTYPE,
        this.dOCDATE,
        this.cARDNO,
        this.sLCODE,
        this.sLDESCP,
        this.mOBILE,
        this.eMAIL,
        this.dID,
        this.dNAME,
        this.aMT,
        this.cREATEUSER});

  DATA.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    dOCNO = json['DOCNO'];
    dOCTYPE = json['DOCTYPE'];
    dOCDATE = json['DOCDATE'];
    cARDNO = json['CARDNO'];
    sLCODE = json['SLCODE'];
    sLDESCP = json['SLDESCP'];
    mOBILE = json['MOBILE'];
    eMAIL = json['EMAIL'];
    dID = json['CREATE_DEVICE'];
    dNAME = json['DEVICE_NAME'];
    aMT = json['AMT'];
    cREATEUSER = json['CREATE_USER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['DOCNO'] = this.dOCNO;
    data['DOCTYPE'] = this.dOCTYPE;
    data['DOCDATE'] = this.dOCDATE;
    data['CARDNO'] = this.cARDNO;
    data['SLCODE'] = this.sLCODE;
    data['SLDESCP'] = this.sLDESCP;
    data['MOBILE'] = this.mOBILE;
    data['EMAIL'] = this.eMAIL;
    data['CREATE_DEVICE'] = this.dID;
    data['DEVICE_NAME'] = this.dNAME;
    data['AMT'] = this.aMT;
    data['CREATE_USER'] = this.cREATEUSER;
    return data;
  }
}