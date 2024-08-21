class SignUpModel {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String repassword;

  SignUpModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.repassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'repassword': repassword,
    };
  }
}
