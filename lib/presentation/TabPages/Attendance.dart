import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meri_id_operator/presentation/custom/CustomCard.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/styles.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomTextField.dart';
import '../features/ChooseAddress.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  void initState() {
    super.initState();
    _getUserLocation();
  }

  double? latitude;
  double? longitude;

  _getUserLocation() async {
    Location location = Location();
    final _locationData = await location.getLocation();
    setState(() {
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Styles.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  CustomText.xLargeText("Add Bookings"),
                  const SizedBox(height: 16),
                  CustomText.mediumText(
                      "For how many people you want to do booking?"),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomCard(
                    name: "Janhvi Singh",
                    time: "4:00pm",
                    lat: latitude!,
                    long: longitude!,
                    persons: 2,
                    onTap: () {},
                    makeCall: () {
                      launchUrlString("tel:+91963852741");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
