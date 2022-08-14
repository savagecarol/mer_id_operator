import 'package:flutter/material.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/presentation/auth/PhoneNumber.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/custom/CustomIcon.dart';
import 'package:meri_id_operator/presentation/custom/CustomScaffold.dart';
import 'package:meri_id_operator/presentation/custom/CustomTextField.dart';
import 'package:meri_id_operator/services/widgets/CustomText.dart';
import 'package:meri_id_operator/utils/styles.dart';

import '../../utils/strings.dart';

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
                labelText: "Get OTP",
                // (_language)
                //     ? StringValues.getOTP.english
                //     : StringValues.getOTP.hindi,
              ),
              const SizedBox(height: 32),
              CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: false,
                  labelText: "Submit",
                  // (_language)
                  // ? StringValues.submit.english
                  // : StringValues.submit.hindi,
                  onTap: () {
                    _routeToSplashPage();
                  },
                  containerColor: Styles.redColor),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: (() => _routeToPhoneNumber()),
                child: CustomText.mediumText("Enter Number Again")
                  // (_language)
                  //   ? StringValues.enterNumberAgain.english
                  //   : StringValues.enterNumberAgain.hindi,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
