import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../services/widgets/CustomText.dart';
import '../custom/CustomCard.dart';
import '../features/BookingDetail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _routoBookingDetail() {
    Navigator.pushNamed(context, BookingDetail.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            CustomText.xLargeText("Home"),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// buildAvailability(context),
//                 const SizedBox(height: 24),
//                 buildAuthenticate(context),
