class PendingPaymentModel {
  List<PENDING>? pENDING;

  PendingPaymentModel({this.pENDING});

  PendingPaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['PENDING'] != null) {
      pENDING = <PENDING>[];
      json['PENDING'].forEach((v) {
        pENDING!.add(new PENDING.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pENDING != null) {
      data['PENDING'] = this.pENDING!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PENDING {
  String? cOMPANY;
  String? bRNCODE;
  String? dOCNO;
  String? dOCTYPE;
  String? dOCDATE;
  String? eXPDATE;
  num? aMOUNT;
  num? pAIDAMOUNT;
  String? fROMDEVICEID;
  String? tODEVICEID;
  String? tODEVICENAME;
  String? fROMKEY;
  String? tOKEY;
  String? tRNDOCNO;
  String? tRNDOCTYPE;
  String? tRNDATE;
  String? tRNUSER;
  String? tRNCARDNO;
  String? rEF1;
  String? cREATEUSER;
  String? sTATUS;

  PENDING(
      {this.cOMPANY,
        this.bRNCODE,
        this.dOCNO,
        this.dOCTYPE,
        this.dOCDATE,
        this.eXPDATE,
        this.aMOUNT,
        this.pAIDAMOUNT,
        this.fROMDEVICEID,
        this.tODEVICEID,
        this.tODEVICENAME,
        this.fROMKEY,
        this.tOKEY,
        this.tRNDOCNO,
        this.tRNDOCTYPE,
        this.tRNDATE,
        this.tRNUSER,
        this.tRNCARDNO,
        this.rEF1,
        this.cREATEUSER,
        this.sTATUS});

  PENDING.fromJson(Map<String, dynamic> json) {
    cOMPANY = json['COMPANY']??"";
    bRNCODE = json['BRNCODE']??"";
    dOCNO = json['DOCNO']??"";
    dOCTYPE = json['DOCTYPE']??"";
    dOCDATE = json['DOCDATE']??"";
    eXPDATE = json['EXP_DATE']??"";
    aMOUNT = json['AMOUNT']??0.0;
    pAIDAMOUNT = json['PAID_AMOUNT']??0.0;
    fROMDEVICEID = json['FROM_DEVICE_ID']??"";
    tODEVICEID = json['TO_DEVICE_ID']??"";
    tODEVICENAME = json['TO_DEVICE_NAME']??"";
    fROMKEY = json['FROM_KEY']??"";
    tOKEY = json['TO_KEY']??"";
    tRNDOCNO = json['TRN_DOCNO']??"";
    tRNDOCTYPE = json['TRN_DOCTYPE']??"";
    tRNDATE = json['TRN_DATE']??"";
    tRNUSER = json['TRN_USER']??"";
    tRNCARDNO = json['TRN_CARDNO']??"";
    rEF1 = json['REF1']??"";
    cREATEUSER = json['CREATE_USER']??"";
    sTATUS = json['STATUS']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY'] = this.cOMPANY;
    data['BRNCODE'] = this.bRNCODE;
    data['DOCNO'] = this.dOCNO;
    data['DOCTYPE'] = this.dOCTYPE;
    data['DOCDATE'] = this.dOCDATE;
    data['EXP_DATE'] = this.eXPDATE;
    data['AMOUNT'] = this.aMOUNT;
    data['PAID_AMOUNT'] = this.pAIDAMOUNT;
    data['FROM_DEVICE_ID'] = this.fROMDEVICEID;
    data['TO_DEVICE_ID'] = this.tODEVICEID;
    data['TO_DEVICE_NAME'] = this.tODEVICENAME;
    data['FROM_KEY'] = this.fROMKEY;
    data['TO_KEY'] = this.tOKEY;
    data['TRN_DOCNO'] = this.tRNDOCNO;
    data['TRN_DOCTYPE'] = this.tRNDOCTYPE;
    data['TRN_DATE'] = this.tRNDATE;
    data['TRN_USER'] = this.tRNUSER;
    data['TRN_CARDNO'] = this.tRNCARDNO;
    data['REF1'] = this.rEF1;
    data['CREATE_USER'] = this.cREATEUSER;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}