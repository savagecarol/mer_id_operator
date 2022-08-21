import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/custom/CustomLocation.dart';
import 'package:meri_id_operator/utils/global.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool isLoading = true;
  bool _language = true;
  double? latitude;
  double? longitude;

  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _getUserLocation();
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


  _getUserLocation() async {
    Location location = Location();
    final _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Styles.redColor),
          )
        : Stack(
            children: [
              CustomLocation(
                lat: latitude!,
                long: longitude!,
                zoom: 12,
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.xLargeText(
                        (_language)
                            ? StringValues.attendance.english
                            : StringValues.attendance.hindi,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                          postIconSize: 20,
                          postIcon: Icons.arrow_forward,
                          visiblepostIcon: false,
                          labelText: "punch In",
                          containerColor: Styles.redColor,
                          onTap: () {}),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
