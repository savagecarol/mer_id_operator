import 'package:flutter/material.dart';
import '../../utils/styles.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomIcon.dart';
import '../custom/CustomScaffold.dart';
import '../custom/CustomTextField.dart';
import 'otp.dart';

class LoginPage extends StatefulWidget {
  static const String routeNamed = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                labelText: 'Enter Username',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "",
                hintTextSize: 16,
                initialValue: '',
                onChanged: () {},
                onSaved: () {},
                validator: () {},
                labelText: 'Enter Password',
                obscureText: true,
              ),
              const SizedBox(height: 32),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: false,
                labelText: "Submit",
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
