import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:meri_id_operator/model/UserAttendance.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
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
  bool isButtonLoading = false;
  double? latitude;
  double? longitude;
  UserAttendance userAttendance = UserAttendance(status: "", punch_in: "");

  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _getUserLocation();
    await _checkAttendance();
    await _loadingOff();
  }

  _checkAttendance() async {
    userAttendance = await apiService.checkAttendance();
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

  _getDataBack() async {
    setState(() {
      isLoading = true;
    });
    userAttendance = await apiService.checkAttendance();
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
                      userAttendance.status != "done"
                          ? CustomButton(
                              isLoading: isButtonLoading,
                              postIconSize: 20,
                              postIcon: Icons.arrow_forward,
                              visiblepostIcon: false,
                              labelText: userAttendance.status == "present"
                                  ? "punch Out"
                                  : "punch In",
                              containerColor: Styles.redColor,
                              onTap: () async {
                                setState(() {
                                  isButtonLoading = true;
                                });

                                try {
                                  DateTime now = DateTime.now();
                                  String date =
                                      "${now.year.toString()}-${now.month.toString()}-${now.day.toString()}";
                                  String time =
                                      "${now.hour.toString()}:${now.minute.toString()}:${now.second.toString()}";
                                  if (userAttendance.status != "present") {
                                    bool val = await apiService
                                        .punchInAttendance(date, time);
                                    if (val)
                                      successToast(
                                          "Attendance Updated", context);
                                    else
                                      errorToast(
                                          "Oops Some Error Occur", context);
                                  } else {
                                    bool val = await apiService
                                        .punchOutAttendance(date, time);
                                    if (val)
                                      successToast(
                                          "Attendance Updated", context);
                                    else
                                      errorToast(
                                          "Oops Some Error Occur", context);
                                  }
                                } catch (e) {
                                  errorToast("Oops Some Error Occur", context);
                                }
                                setState(() {
                                  isButtonLoading = false;
                                });
                                _getDataBack();
                                // Navigator.pushNamed(context, SplashPage.routeNamed);
                              })
                          : Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      (userAttendance.status == "present")
                          ? Text(
                              "Punch In : ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(userAttendance.punch_in))}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
