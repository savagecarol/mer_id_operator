import 'package:flutter/material.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/styles.dart';
import '../SplashPage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomIcon.dart';
import '../custom/CustomScaffold.dart';
import '../custom/CustomTextField.dart';
import 'PhoneNumber.dart';

class OTP extends StatefulWidget {
  static const String routeNamed = 'OTP';
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  _routeToSplashPage() {
    Navigator.popAndPushNamed(context, SplashPage.routeNamed);
  }

  _routeToPhoneNumber() {
    Navigator.pushNamed(context, PhoneNumber.routeNamed);
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
                labelText: "Enter OTP",
              ),
              const SizedBox(height: 32),
              CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: false,
                  labelText: "Submit",
                  onTap: () {},
                  containerColor: Styles.redColor),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                child: CustomText.mediumText("Enter Number Again"),
                onTap: (() => _routeToPhoneNumber()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class KycStepper {}
