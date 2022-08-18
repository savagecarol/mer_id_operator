import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meri_id_operator/services/AuthService.dart';
import 'package:meri_id_operator/utils/styles.dart';

import '../services/PreferenceService.dart';

var currentPage = 0;
var role = "user";

final PreferenceService preferenceService = PreferenceService.getInstance();
final AuthService authService = AuthService.getInstance();

String? validateEmail(String email) {
  if (email == null || email.isEmpty) return 'Required !!!';
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return (!regex.hasMatch(email)) ? 'Valid Email!!' : null;
}

String? validateName(String name) {
  String? required = requiredString(name);
  if (required != null) return required;
  RegExp regex = RegExp(r'^[ a-zA-Z]*$');
  return (!regex.hasMatch(name)) ? 'Valid Name!!' : null;
}

String? validatePhone(String phone) {
  String? required = requiredString(phone);
  if (required != null) return required;

  RegExp regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  return (!regex.hasMatch(phone)) ? 'Valid Phone Number!!' : null;
}

String? requiredString(String value) {
  if (value == null || value.isEmpty) return 'Required !!!';
  return null;
}


String? validateOtp(String otp) {
  String? required = requiredString(otp);
  if (required != null) return required;

  RegExp regex = RegExp(r'^[0-9]{1,6}$');
  return (!regex.hasMatch(otp)) ? 'Valid Otp!!' : null;
}



Future<bool> checkLanguage() async =>
    (await preferenceService.getLanguage() == null ||
        await preferenceService.getLanguage() == "english");

Widget customizedLeadingIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Styles.creamColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children:  [
        Text(message)
      ],
    ),
  );
}

void errorToast(String message, BuildContext context) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(child: customizedLeadingIconWidget(message));
}
