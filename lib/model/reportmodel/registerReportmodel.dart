class RgsterReportModel {
  List<DATA>? dATA;

  RgsterReportModel({this.dATA});

  RgsterReportModel.fromJson(Map<String, dynamic> json) {
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
  String? iSSUEDOCNO;
  String? iSSUEDOCTYPE;
  String? iSSUEDATE;
  num? rEGCHARGE;
  String? cARDNO;
  String? sLCODE;
  String? sLDESCP;
  String? cREATEUSER;
  String? mOBILE;
  String? eMAIL;
  String? dID;
  String? dNAME;

  DATA(
      {this.iSSUEDOCNO,
        this.iSSUEDOCTYPE,
        this.iSSUEDATE,
        this.rEGCHARGE,
        this.cARDNO,
        this.sLCODE,
        this.sLDESCP,
        this.cREATEUSER,
        this.mOBILE,
        this.eMAIL,
        this.dID,
        this.dNAME

      });

  DATA.fromJson(Map<String, dynamic> json) {
    iSSUEDOCNO = json['ISSUE_DOCNO'];
    iSSUEDOCTYPE = json['ISSUE_DOCTYPE'];
    iSSUEDATE = json['ISSUE_DATE'];
    rEGCHARGE = json['REG_CHARGE'];
    cARDNO = json['CARDNO'];
    sLCODE = json['SLCODE'];
    sLDESCP = json['SLDESCP'];
    cREATEUSER = json['CREATE_USER'];
    mOBILE = json['MOBILE'];
    eMAIL = json['EMAIL'];
    dID = json['CREATE_DEVICE'];
    dNAME = json['DEVICE_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISSUE_DOCNO'] = this.iSSUEDOCNO;
    data['ISSUE_DOCTYPE'] = this.iSSUEDOCTYPE;
    data['ISSUE_DATE'] = this.iSSUEDATE;
    data['REG_CHARGE'] = this.rEGCHARGE;
    data['CARDNO'] = this.cARDNO;
    data['SLCODE'] = this.sLCODE;
    data['SLDESCP'] = this.sLDESCP;
    data['CREATE_USER'] = this.cREATEUSER;
    data['MOBILE'] = this.mOBILE;
    data['EMAIL'] = this.eMAIL;
    data['CREATE_DEVICE'] = this.dID;
    data['DEVICE_NAME'] = this.dNAME;
    return data;
  }
}