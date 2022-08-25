import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/features/QRpage.dart';
import 'package:meri_id_operator/presentation/features/Selfie.dart';
import 'package:meri_id_operator/services/widgets/CustomText.dart';
import 'package:meri_id_operator/utils/global.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/styles.dart';
import '../custom/CustomScaffold.dart';

class TakeSelfie extends StatefulWidget {
  late String code;
  TakeSelfie({required this.code});

  @override
  State<TakeSelfie> createState() => _TakeSelfieState();
}

class _TakeSelfieState extends State<TakeSelfie> {
  bool isButtonLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, QRpage.routeNamed);
            },
          ),
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(children: [
            CustomText.xLargeText("Do you want to take Selfie with user"),
            SizedBox(
              height: 16,
            ),
            SvgPicture.asset("assets/images/empty.svg"),
            CustomButton(
              postIcon: Icons.arrow_forward_ios,
              containerColor: Styles.redColor,
              visiblepostIcon: false,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Selfie(code: widget.code)));
              },
              labelText: "Yes",
            ),
            SizedBox(
              height: 16,
            ),
            CustomButton(
              isLoading: isButtonLoading,
              postIcon: Icons.arrow_forward_ios,
              containerColor: Styles.redColor,
              visiblepostIcon: false,
              onTap: () async {
                setState(() {
                  isButtonLoading = true;
                });

                String val = await apiService.getUrl("", widget.code);
                if (val != "") {
                  launchUrl(Uri.parse(val));
                  currentPage = 0;
                  Navigator.popAndPushNamed(context, SplashPage.routeNamed);
                } else {
                  errorToast("!OOps Please Try Again", context);
                }
                setState(() {
                  isButtonLoading = false;
                });
              },
              labelText: "No",
            )
          ]),
        ),
      ),
    );
  }
}
