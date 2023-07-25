class CommonModel {
  String? sTATUS;
  String? mSG;
  String? cODE;
  String? dOCTYPE;
  String? bALANCE;
  String? sLDESCP;

  CommonModel({this.sTATUS, this.mSG, this.cODE, this.dOCTYPE, this.bALANCE, this.sLDESCP});

  CommonModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    mSG = json['MSG'];
    cODE = json['CODE'];
    dOCTYPE = json['DOCTYPE'];
    bALANCE = (json['BALANCE']??"").toString();
    sLDESCP = (json['SLDESCP']??"").toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['MSG'] = this.mSG;
    data['CODE'] = this.cODE;
    data['DOCTYPE'] = this.dOCTYPE;
    data['BALANCE'] = this.bALANCE;
    data['SLDESCP'] = this.sLDESCP;
    return data;
  }
}