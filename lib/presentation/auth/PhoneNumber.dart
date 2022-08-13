import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomIcon.dart';
import '../custom/CustomScaffold.dart';
import '../custom/CustomTextField.dart';
import 'otp.dart';

class PhoneNumber extends StatefulWidget {
  static const String routeNamed = 'PhoneNumber';
  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  _routeToOtp() {
    Navigator.pushNamed(context, OTP.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIcon(
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "",
                hintTextSize: 16,
                initialValue: '',
                onChanged: () {},
                onSaved: () {},
                validator: () {},
                labelText: 'Enter Phone Number',
              ),
              const SizedBox(height: 32),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: false,
                labelText: "Get Otp",
                onTap: _routeToOtp,
                containerColor: Styles.redColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
