import 'package:flutter/material.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/presentation/auth/PhoneNumber.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/custom/CustomIcon.dart';
import 'package:meri_id_operator/presentation/custom/CustomScaffold.dart';
import 'package:meri_id_operator/presentation/custom/CustomTextField.dart';
import 'package:meri_id_operator/services/widgets/CustomText.dart';
import 'package:meri_id_operator/utils/global.dart';
import 'package:meri_id_operator/utils/styles.dart';

import '../../utils/strings.dart';

class OTP extends StatefulWidget {
  final String phoneNumber;
  OTP({required this.phoneNumber});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  _routeToPhoneNumber() {
    Navigator.pushNamed(context, PhoneNumber.routeNamed);
  }

  bool isButtonLoading = false;
  String otp = "";


  _routeToSplashPage(BuildContext c) async {
    setState(() {
      isButtonLoading = true;
    });
    if (validateOtp(otp) == null) {
      bool res = await authService.login(widget.phoneNumber , otp);
      if (res) {
        Navigator.pop(context);
        Navigator.pushNamed(context, SplashPage.routeNamed);
      } else {
        errorToast("Oops!! server down", c);
      }
    } else {
      errorToast("please enter valid Otp", c);
    }
    setState(() {
      isButtonLoading = false;
    });
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
                  onSaved: () {},
                  onChanged: (value) {
                    otp = value!;
                  },
                  validator: () {},
                  labelText: StringValues.getOTP.english),
              const SizedBox(height: 32),
              CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: false,
                  labelText: StringValues.submit.english,
                  isLoading: isButtonLoading,
                  onTap: () async{
                    await _routeToSplashPage(context);
                  },
                  containerColor: Styles.redColor),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                  onTap: (() => _routeToPhoneNumber()),
                  child: CustomText.mediumText(
                      StringValues.enterNumberAgain.english))
            ],
          ),
        ),
      ),
    );
  }
}
