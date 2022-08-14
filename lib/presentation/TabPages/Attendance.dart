import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/custom/CustomCard.dart';
import 'package:meri_id_operator/presentation/custom/CustomLocation.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/styles.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool isLoading = true;
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Styles.redColor),
          )
        : Stack(
          children: [
             CustomLocation(lat: latitude!, long: longitude! , zoom: 12,),
             Positioned(child: 
               Padding(
                 padding: const EdgeInsets.all(32),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     CustomText.xLargeText("Attendance"),
                     const SizedBox(height: 32,),
                  CustomButton(
                  postIconSize: 20,
                  postIcon: Icons.arrow_forward,
                  visiblepostIcon: false,
                  labelText: "punch In",
                  containerColor: Styles.redColor,
                  onTap: () {           
                  }),
                   ],
                 ),
               ),

             )
          ],
        );

    // : Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(32),
    //           child: CustomText.xLargeText("Attendance"),
    //         ),
    //         Container(child: CustomLocation(lat: latitude!, long: longitude!) , height: 300,),
    //       ],
    //     ),
    //   ],
    // );
  }
}
