class OtpModel {
  String? sId;
  int? countryCode;
  int? phone;
  int? otp;

  OtpModel({this.sId, this.countryCode, this.phone, this.otp});

  OtpModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    countryCode = json['country_code'];
    phone = json['phone'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['otp'] = otp;
    return data;
  }
}
