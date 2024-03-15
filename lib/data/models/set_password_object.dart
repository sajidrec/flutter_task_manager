class SetPasswordObject {
  String? email;
  String? otp;
  String? password;

  SetPasswordObject(
      {required this.email, required this.otp, required this.password});

  SetPasswordObject.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['OTP'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['OTP'] = otp;
    data['password'] = password;
    return data;
  }
}
