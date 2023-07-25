class CardIssuePendingModel {
  String? cOMPANY;
  String? sLCODE;
  int? sRNO;
  String? bRNCODE;
  String? cARDNO;
  String? sLDESCP;
  String? cARDPIN;
  String? sECUREYN;
  String? iSSUEDATE;
  String? eXPDATE;
  String? cARDTYPE;
  int? rEGCHARGE;
  String? sTATUS;
  String? cREATEUSER;
  String? cREATEDATE;
  String? cREATEDEVICE;
  String? iSSUEDOCNO;
  String? iSSUEDOCTYPE;
  Null? oLDCARDNO;
  int? oLDBALANCE;
  Null? sALEYN;
  Null? sALECOMPANY;
  Null? sALEDOCNO;
  Null? sALEDOCTYPE;

  CardIssuePendingModel(
      {this.cOMPANY,
        this.sLCODE,
        this.sRNO,
        this.bRNCODE,
        this.cARDNO,
        this.sLDESCP,
        this.cARDPIN,
        this.sECUREYN,
        this.iSSUEDATE,
        this.eXPDATE,
        this.cARDTYPE,
        this.rEGCHARGE,
        this.sTATUS,
        this.cREATEUSER,
        this.cREATEDATE,
        this.cREATEDEVICE,
        this.iSSUEDOCNO,
        this.iSSUEDOCTYPE,
        this.oLDCARDNO,
        this.oLDBALANCE,
        this.sALEYN,
        this.sALECOMPANY,
        this.sALEDOCNO,
        this.sALEDOCTYPE});

  CardIssuePendingModel.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY'];
    sLCODE = json['SLCODE'];
    sRNO = json['SRNO'];
    bRNCODE = json['BRNCODE'];
    cARDNO = json['CARDNO'];
    sLDESCP = json['SLDESCP'];
    cARDPIN = json['CARD_PIN'];
    sECUREYN = json['SECURE_YN'];
    iSSUEDATE = json['ISSUE_DATE'];
    eXPDATE = json['EXP_DATE'];
    cARDTYPE = json['CARD_TYPE'];
    rEGCHARGE = json['REG_CHARGE'];
    sTATUS = json['STATUS'];
    cREATEUSER = json['CREATE_USER'];
    cREATEDATE = json['CREATE_DATE'];
    cREATEDEVICE = json['CREATE_DEVICE'];
    iSSUEDOCNO = json['ISSUE_DOCNO'];
    iSSUEDOCTYPE = json['ISSUE_DOCTYPE'];
    oLDCARDNO = json['OLD_CARDNO'];
    oLDBALANCE = json['OLD_BALANCE'];
    sALEYN = json['SALE_YN'];
    sALECOMPANY = json['SALE_COMPANY'];
    sALEDOCNO = json['SALE_DOCNO'];
    sALEDOCTYPE = json['SALE_DOCTYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['SLCODE'] = this.sLCODE;
    data['SRNO'] = this.sRNO;
    data['BRNCODE'] = this.bRNCODE;
    data['CARDNO'] = this.cARDNO;
    data['SLDESCP'] = this.sLDESCP;
    data['CARD_PIN'] = this.cARDPIN;
    data['SECURE_YN'] = this.sECUREYN;
    data['ISSUE_DATE'] = this.iSSUEDATE;
    data['EXP_DATE'] = this.eXPDATE;
    data['CARD_TYPE'] = this.cARDTYPE;
    data['REG_CHARGE'] = this.rEGCHARGE;
    data['STATUS'] = this.sTATUS;
    data['CREATE_USER'] = this.cREATEUSER;
    data['CREATE_DATE'] = this.cREATEDATE;
    data['CREATE_DEVICE'] = this.cREATEDEVICE;
    data['ISSUE_DOCNO'] = this.iSSUEDOCNO;
    data['ISSUE_DOCTYPE'] = this.iSSUEDOCTYPE;
    data['OLD_CARDNO'] = this.oLDCARDNO;
    data['OLD_BALANCE'] = this.oLDBALANCE;
    data['SALE_YN'] = this.sALEYN;
    data['SALE_COMPANY'] = this.sALECOMPANY;
    data['SALE_DOCNO'] = this.sALEDOCNO;
    data['SALE_DOCTYPE'] = this.sALEDOCTYPE;
    return data;
  }
}