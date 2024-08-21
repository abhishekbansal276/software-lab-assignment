import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://sowlab.com/assignment/';

  Future<void> registerUserThroughMail({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String businessName,
    required String informalName,
    required String address,
    required String city,
    required String state,
    required int zipCode,
    required String registrationProofFileName,
    required Map<String, List<String>> businessHours,
    required String deviceToken,
    required String socialId,
  }) async {
    var uri = Uri.parse('$baseUrl/user/register');

    var request = http.Request('POST', uri)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'password': password,
        'role': 'farmer',
        'business_name': businessName,
        'informal_name': informalName,
        'address': address,
        'city': city,
        'state': state,
        'zip_code': zipCode,
        'registration_proof_file_name': registrationProofFileName,
        'business_hours': businessHours,
        'device_token': deviceToken,
        'type': 'email',
        'social_id': socialId,
      });

    try {
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // print('social id: $socialId');
      print('Response: $responseBody');

      if (response.statusCode == 200) {
        print('User registered successfully');
      } else {
        print('Failed to register user');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
    required String role,
    required String deviceToken,
    required String type,
    required String socialId,
  }) async {
    var uri = Uri.parse('$baseUrl/user/login');

    var requestBody = {
      'email': email,
      'password': password,
      'role': role,
      'device_token': deviceToken,
      'type': type,
      'social_id': socialId,
    };

    try {
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return 'Error during login: $e';
    }
  }

  Future<void> forgotPassword({
    required String mobile,
  }) async {
    var uri = Uri.parse('$baseUrl/user/forgot-password');

    var requestBody = {
      'mobile': mobile,
    };

    try {
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        print('Password reset link sent successfully');
      } else {
        print('Failed to send password reset link');
      }
    } catch (e) {
      print('Error during password reset request: $e');
    }
  }

  Future<void> verifyOtp({
    required String otp,
  }) async {
    var uri = Uri.parse('$baseUrl/user/verify-otp');

    var requestBody = {
      'otp': otp,
    };

    try {
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        print('OTP verified successfully');
      } else {
        print('Failed to verify OTP');
      }
    } catch (e) {
      print('Error during OTP verification: $e');
    }
  }

  Future<void> resetPassword({
    required String token,
    required String password,
    required String cpassword,
  }) async {
    var uri = Uri.parse('$baseUrl/user/reset-password');

    var requestBody = {
      'token': token,
      'password': password,
      'cpassword': cpassword,
    };

    try {
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        print('Password reset successfully');
      } else {
        print('Failed to reset password');
      }
    } catch (e) {
      print('Error during password reset: $e');
    }
  }
}
