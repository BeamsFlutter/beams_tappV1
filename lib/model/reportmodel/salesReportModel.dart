class SaleReportModel {
  List<DATA>? dATA;

  SaleReportModel({this.dATA});

  SaleReportModel.fromJson(Map<String, dynamic> json) {
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
  num? nETAMT;
  String? cREATEUSER;
  String? iTEMCODE;
  String? iTEMDESCP;
  String? mOBILE;
  String? eMAIL;
  String? dID;
  String? dNAME;
  num? pRICE;
  num? qTY;

  DATA(
      {this.cOMPANY,
        this.dOCNO,
        this.dOCTYPE,
        this.dOCDATE,
        this.cARDNO,
        this.sLCODE,
        this.sLDESCP,
        this.nETAMT,
        this.cREATEUSER,
        this.iTEMCODE,
        this.iTEMDESCP,
        this.mOBILE,
        this.eMAIL,
        this.dID,
        this.dNAME,
        this.pRICE,
        this.qTY});

  DATA.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    dOCNO = json['DOCNO'];
    dOCTYPE = json['DOCTYPE'];
    dOCDATE = json['DOCDATE'];
    cARDNO = json['CARDNO'];
    sLCODE = json['SLCODE'];
    sLDESCP = json['SLDESCP'];
    nETAMT = json['NETAMT'];
    cREATEUSER = json['CREATE_USER'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMDESCP = json['ITEM_DESCP'];
    mOBILE = json['MOBILE'];
    eMAIL = json['EMAIL'];
    dID = json['CREATE_DEVICE'];
    dNAME = json['DEVICE_NAME'];
    pRICE = json['PRICE'];
    qTY = json['QTY'];
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
    data['NETAMT'] = this.nETAMT;
    data['CREATE_USER'] = this.cREATEUSER;
    data['ITEM_CODE'] = this.iTEMCODE;
    data['ITEM_DESCP'] = this.iTEMDESCP;
    data['PRICE'] = this.pRICE;
    data['MOBILE'] = this.mOBILE;
    data['EMAIL'] = this.eMAIL;
    data['CREATE_DEVICE'] = this.dID;
    data['DEVICE_NAME'] = this.dNAME;
    data['QTY'] = this.qTY;
    return data;
  }
}