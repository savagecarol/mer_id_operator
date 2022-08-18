import 'dart:convert';

import 'package:http/http.dart';
import 'package:meri_id_operator/services/PreferenceService.dart';
import 'package:meri_id_operator/utils/global.dart';

class AuthService {
  AuthService._();
  factory AuthService.getInstance() => _instance;
  static final AuthService _instance = AuthService._();

  final String baseUrl = "https://meriid.herokuapp.com/api";
  final String role = 'operator';
  final String token = 'Token';

  Future<bool> getOtp(String phoneNumber) async {
    final String url = "$baseUrl/auth/otp-send";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
          <String, String>{'phone_number': phoneNumber, 'role': role}),
    );
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> login(String phoneNumber, String otp) async {
    final String url = "$baseUrl/auth/login";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body:
          jsonEncode(<String, String>{'phone_number': phoneNumber, 'otp': otp}),
    );

    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      await preferenceService.setUID(body["data"]["token"]);
      return true;
    }
    return false;
  }

  Future<bool> currentStatus(String phoneNumber, String otp) async {
    String authId = await PreferenceService.uid;
    final String url = "$baseUrl/auth/current-status";
    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> getProfile() async {
    String authId = await PreferenceService.uid;
    final String url = "$baseUrl/auth/profile";
    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> logOut() async {
    await preferenceService.removeUID();
    return true;
  }
}
