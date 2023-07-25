import 'package:beams_tapp/constants/common_functn.dart';

class CollectnReportModel {
  List<REGISTRATION>? rEGISTRATION;
  List<RECHARGE>? rECHARGE;
  List<SALES>? sALES;
  List<COLLECTION>? cOLLECTION;
  List<REFUND>? reFund;

  CollectnReportModel(
      {this.rEGISTRATION, this.rECHARGE, this.sALES, this.cOLLECTION,this.reFund});

  CollectnReportModel.fromJson(Map<String, dynamic> json) {
    if (json['REGISTRATION'] != null) {
      rEGISTRATION = <REGISTRATION>[];
      json['REGISTRATION'].forEach((v) {
        rEGISTRATION!.add(new REGISTRATION.fromJson(v));
      });
    }
    if (json['RECHARGE'] != null) {
      rECHARGE = <RECHARGE>[];
      json['RECHARGE'].forEach((v) {
        rECHARGE!.add(new RECHARGE.fromJson(v));
      });
    }
    if (json['SALES'] != null) {
      sALES = <SALES>[];
      json['SALES'].forEach((v) {
        sALES!.add(new SALES.fromJson(v));
      });
    }
    if (json['COLLECTION'] != null) {
      cOLLECTION = <COLLECTION>[];
      json['COLLECTION'].forEach((v) {
        cOLLECTION!.add(new COLLECTION.fromJson(v));
      });
    }
    if (json['REFUND'] != null) {
      reFund = <REFUND>[];
      json['REFUND'].forEach((v) {
        reFund!.add(new REFUND.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rEGISTRATION != null) {
      data['REGISTRATION'] = this.rEGISTRATION!.map((v) => v.toJson()).toList();
    }
    if (this.rECHARGE != null) {
      data['RECHARGE'] = this.rECHARGE!.map((v) => v.toJson()).toList();
    }
    if (this.sALES != null) {
      data['SALES'] = this.sALES!.map((v) => v.toJson()).toList();
    }
    if (this.cOLLECTION != null) {
      data['COLLECTION'] = this.cOLLECTION!.map((v) => v.toJson()).toList();
    }
    if (this.reFund != null) {
      data['REFUND'] = this.reFund!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class REGISTRATION {
  double? rEGAMOUNT;
  int? nOOFCARDS;

  REGISTRATION({this.rEGAMOUNT, this.nOOFCARDS});

  REGISTRATION.fromJson(Map<String, dynamic> json) {
    rEGAMOUNT = mfnDbl(json['REG_AMOUNT']);
    nOOFCARDS =mfnInt(json['NO_OF_CARDS']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REG_AMOUNT'] = this.rEGAMOUNT;
    data['NO_OF_CARDS'] = this.nOOFCARDS;
    return data;
  }
}

class RECHARGE {
  double? rECHARGEAMT;
  int? nOOFRECHARGE;

  RECHARGE({this.rECHARGEAMT, this.nOOFRECHARGE});

  RECHARGE.fromJson(Map<String, dynamic> json) {
    rECHARGEAMT = json['RECHARGE_AMT'];
    nOOFRECHARGE = json['NO_OF_RECHARGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RECHARGE_AMT'] = this.rECHARGEAMT;
    data['NO_OF_RECHARGE'] = this.nOOFRECHARGE;
    return data;
  }
}

class REFUND {
  double? reFundAMT;
  int? nOOFREFUND;

  REFUND({this.reFundAMT, this.nOOFREFUND});

  REFUND.fromJson(Map<String, dynamic> json) {
    reFundAMT = json['REFUND_AMT'];
    nOOFREFUND = json['NO_OF_REFUND'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REFUND_AMT'] = this.reFundAMT;
    data['NO_OF_REFUND'] = this.nOOFREFUND;
    return data;
  }
}

class SALES {
  double? nETAMT;
  int? nOOFBILL;

  SALES({this.nETAMT, this.nOOFBILL});

  SALES.fromJson(Map<String, dynamic> json) {
    nETAMT = json['NETAMT'];
    nOOFBILL = json['NO_OF_BILL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NETAMT'] = this.nETAMT;
    data['NO_OF_BILL'] = this.nOOFBILL;
    return data;
  }
}

class COLLECTION {
  String? pAYMODE;
  double? aMT;

  COLLECTION({this.pAYMODE, this.aMT});

  COLLECTION.fromJson(Map<String, dynamic> json) {
    pAYMODE = json['PAYMODE'];
    aMT = json['AMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PAYMODE'] = this.pAYMODE;
    data['AMT'] = this.aMT;
    return data;
  }
}