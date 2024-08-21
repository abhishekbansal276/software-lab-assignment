class FarmInfoModel {
  final String businessName;
  final String informalName;
  final String streetAddress;
  final String city;
  final String state;
  final int zipCode;

  FarmInfoModel({
    required this.businessName,
    required this.informalName,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'informal_name': informalName,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'zip_code': zipCode,
    };
  }
}
