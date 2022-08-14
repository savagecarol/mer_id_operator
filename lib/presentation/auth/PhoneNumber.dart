import 'package:flutter/material.dart';
import 'package:meri_id_operator/presentation/auth/otp.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/custom/CustomIcon.dart';
import 'package:meri_id_operator/presentation/custom/CustomScaffold.dart';
import 'package:meri_id_operator/presentation/custom/CustomTextField.dart';
import 'package:meri_id_operator/utils/styles.dart';

import '../../utils/strings.dart';

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
                labelText: "Enter Phone Number",
                // (_language)
                //                   ? StringValues.enterPhoneNumber.english
                //                   : StringValues.enterPhoneNumber.hindi,
              ),
              const SizedBox(height: 32),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: false,
                labelText: "Get Otp",
                //   (_language)
                // ? StringValues.getOTP.english
                // : StringValues.getOTP.hindi,
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
