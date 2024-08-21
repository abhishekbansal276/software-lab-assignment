class VerificationModel {
  String? fileName;

  VerificationModel({this.fileName});

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
    };
  }

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      fileName: json['file_name'] as String?,
    );
  }
}
