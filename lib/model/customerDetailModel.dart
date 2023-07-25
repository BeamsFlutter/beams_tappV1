class CustomerDetailsModel {
  String? sLCODE;
  String? sLDESCP;
  String? mOBILE;
  String? aDDRESS1;
  String? cITY;
  String? eMAIL;
  String? dOB;

  CustomerDetailsModel(
      {this.sLCODE,
        this.sLDESCP,
        this.mOBILE,
        this.aDDRESS1,
        this.cITY,
        this.eMAIL,
        this.dOB});

  CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    sLCODE = json['SLCODE'];
    sLDESCP = json['SLDESCP'];
    mOBILE = json['MOBILE'];
    aDDRESS1 = json['ADDRESS1'];
    cITY = json['CITY'];
    eMAIL = json['EMAIL'];
    dOB = json['DOB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SLCODE'] = this.sLCODE;
    data['SLDESCP'] = this.sLDESCP;
    data['MOBILE'] = this.mOBILE;
    data['ADDRESS1'] = this.aDDRESS1;
    data['CITY'] = this.cITY;
    data['EMAIL'] = this.eMAIL;
    data['DOB'] = this.dOB;
    return data;
  }
}