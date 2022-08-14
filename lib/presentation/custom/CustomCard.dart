import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meri_id_operator/presentation/custom/CustomLocation.dart';
import 'package:meri_id_operator/utils/styles.dart';

import '../../services/widgets/CustomText.dart';

class CustomCard extends StatelessWidget {
  final String booking_id;
  final String date;
  final String time;
  final String name;
  final Color color;
  final Function onTap;
  final Function makeCall;
  final int persons;
  final double lat;
  final double long;
  final Function onMapClick;

  const CustomCard(
      {this.booking_id = "12345",
      this.date = "Date",
      this.time = "Time",
      this.name = "Person Name",
      required this.makeCall,
      this.color = Styles.redColor,
      required this.onTap,
      required this.onMapClick,
      this.persons = 0,
      required this.lat,
      required this.long});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Card(
          elevation: 5,
          shadowColor: Styles.blackColor,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: color,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16 , bottom: 8 , right: 16 , left: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    onMapClick();
                  },
                  child: SizedBox(
                    height: 200,
                    child: CustomLocation(lat: lat, long: long , zoom: 12,),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // profile pic
                        Icon(Icons.person),
                        // Name
                        CustomText.timeText(name),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.group),
                        CustomText.timeText(' ' + persons.toString()),
                        CustomText.timeText(" Person"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.timeText("03-july-2022"),
                    CustomText.timeText("4:00pm to 5:00 pm"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText.timeText("Booking ID : "),
                        CustomText.timeText(booking_id),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          makeCall();
                        },
                        icon: Icon(Icons.call)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



//  IconButton(
//                         onPressed: () {
//                           makeCall();
//                         },
//                         icon: Icon(Icons.call)),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time),
//                         CustomText.timeText(time),
//                       ],
//                     )