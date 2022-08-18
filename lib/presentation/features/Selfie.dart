import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id_operator/utils/global.dart';
import 'package:meri_id_operator/utils/strings.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/styles.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomImageContainer.dart';
import '../custom/CustomScaffold.dart';

class Selfie extends StatefulWidget {
  static const String routeNamed = 'selfie';

  @override
  State<Selfie> createState() => _SelfieState();
}

class _SelfieState extends State<Selfie> {
  bool isLoading = true;
  bool _language = true;


  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _loadingOff();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _loadingOff() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body:  (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Styles.redColor),
          )
        : Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              CustomText.xLargeText((_language)
                  ? StringValues.languageSettings.english
                  : StringValues.languageSettings.hindi),
              Padding(
                padding: const EdgeInsets.all(32),
                child: CustomImageContainer(
                    onTap: () async {
                      try {
                        XFile? file = await ImagePicker.platform
                            .getImage(source: ImageSource.camera);
                        print(file);
                        if (file != null) {
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    image: Styles.STATIC_LOGO_IMAGE //post.imageUrl,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                labelText: "submit",
                onTap: () {},
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
