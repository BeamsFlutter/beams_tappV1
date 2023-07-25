class CardDetailsModel {
  String? sTATUS;
  String? mSG;
  List<DATA>? dATA;
  List<HISTORY>? hISTORY;

  CardDetailsModel({this.sTATUS, this.mSG, this.dATA, this.hISTORY});

  CardDetailsModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    mSG = json['MSG'];
    if (json['DATA'] != null) {
      dATA = <DATA>[];
      json['DATA'].forEach((v) {
        dATA!.add(new DATA.fromJson(v));
      });
    }
    if (json['HISTORY'] != null) {
      hISTORY = <HISTORY>[];
      json['HISTORY'].forEach((v) {
        hISTORY!.add(new HISTORY.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['MSG'] = this.mSG;
    if (this.dATA != null) {
      data['DATA'] = this.dATA!.map((v) => v.toJson()).toList();
    }
    if (this.hISTORY != null) {
      data['HISTORY'] = this.hISTORY!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DATA {
  String? cARDNO;
  String? sLCODE;
  String? sLDESCP;
  String? mOBILE;
  String? tEL2;
  String? eMAIL;
  num? aMOUNT;
  String ? expDate;

  DATA(
      {this.cARDNO,
        this.sLCODE,
        this.sLDESCP,
        this.mOBILE,
        this.tEL2,
        this.eMAIL,
        this.aMOUNT,
        this.expDate});

  DATA.fromJson(Map<String, dynamic> json) {
    cARDNO = json['CARDNO'];
    sLCODE = json['SLCODE'];
    sLDESCP = json['SLDESCP'];
    mOBILE = json['MOBILE'];
    tEL2 = json['TEL2'];
    eMAIL = json['EMAIL'];
    aMOUNT = json['AMOUNT'];
    expDate = json['EXP_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CARDNO'] = this.cARDNO;
    data['SLCODE'] = this.sLCODE;
    data['SLDESCP'] = this.sLDESCP;
    data['MOBILE'] = this.mOBILE;
    data['TEL2'] = this.tEL2;
    data['EMAIL'] = this.eMAIL;
    data['AMOUNT'] = this.aMOUNT;
    data['EXP_DATE'] = this.expDate;
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
  String? dID;
  String? dNAME;
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
        this.dID,
        this.dNAME,
        this.cREATEUSER,
        this.tITLE});

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
    dID = json['CREATE_DEVICE'];
    dNAME = json['DEVICE_NAME'];
    cREATEUSER = json['CREATE_USER'];
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
    data['CREATE_USER'] = this.cREATEUSER;
    data['DEVICE_NAME'] = this.dNAME;
    data['CREATE_DEVICE'] = this.dID;
    return data;
  }
}