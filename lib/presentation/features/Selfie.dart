import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/utils/global.dart';
import 'package:meri_id_operator/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/styles.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomImageContainer.dart';
import '../custom/CustomScaffold.dart';

class Selfie extends StatefulWidget {
  late String code;
  Selfie({required this.code});
  @override
  State<Selfie> createState() => _SelfieState();
}

class _SelfieState extends State<Selfie> {
  bool imageLoading = false;
  String? defaultContainerUrl = null;
  bool isButtonLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              CustomText.mediumText("Upload Selfie with the User"),
              Padding(
                padding: const EdgeInsets.all(32),
                child: CustomImageContainer(
                  isLoading: imageLoading,
                  onTap: () async {
                    try {
                      setState(() {
                        imageLoading = true;
                      });
                      XFile? xFile = (await ImagePicker.platform
                          .getImage(source: ImageSource.camera));
                      if (xFile != null) {
                        File file = File(xFile.path);
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        defaultContainerUrl = await uploadFileFirebase
                            .uploadFile(file, id, 'selfie');
                      } else {
                        errorToast("Please Choose the File", context);
                      }
                    } catch (e) {
                      errorToast("oops! some error occur", context);
                      print(e);
                    }
                    setState(() {
                      imageLoading = false;
                    });
                  },
                  image: defaultContainerUrl,
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                isLoading: isButtonLoading,
                postIcon: Icons.arrow_forward_ios,
                labelText: StringValues.submit.english,
                onTap: () async {
                  setState(() {
                    isButtonLoading = true;
                  });

                  if (defaultContainerUrl == null) {
                    errorToast("Please Upload the Image", context);
                    return;
                  }
                  String val = await apiService.getUrl(defaultContainerUrl!,
                      "8620a86e-8bfd-4718-bee5-6150dc10bd93");
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
                containerColor: Styles.redColor,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
