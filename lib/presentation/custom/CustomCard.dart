import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/custom/CustomLocation.dart';
import 'package:meri_id_operator/utils/styles.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/strings.dart';

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
  final bool isStart;

  const CustomCard(
      {this.booking_id = "12345",
      this.isStart = true,
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
          elevation: 10,
          shadowColor: Styles.blackColor,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 8, right: 16, left: 16),
            child: Column(
              children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.mediumText(booking_id),
                   
                    InkWell(
                        onTap: () {
                          makeCall();
                        },
                        child: 
                          Container(
                            decoration: BoxDecoration(
                              color: (isStart) ? Colors.blue[400] : Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Text( (isStart) ? "Start" : "Call" ,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            color: Styles.backgroundColor,
                            fontWeight: FontWeight.w500))),
                              const Icon(Icons.arrow_forward, color:  Styles.backgroundColor,)         
                              ],
                            )
                          )
                         ),
                  ],
                
                ),
                 const SizedBox(
                  height: 8,
                ),

                InkWell(
                  onTap: () {
                    onMapClick();
                  },
                  child: SizedBox(
                    height: 220,
                    child: CustomLocation(
                      lat: lat,
                      long: long,
                      zoom: 8,
                    ),
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
                        const Icon(Icons.person),
                        // Name
                        CustomText.timeText(name),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.group),
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
                    CustomText.timeText(date),
                    CustomText.timeText(time),
                  ],
                ),
                 const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
