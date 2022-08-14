import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meri_id_operator/presentation/custom/CustomCard.dart';
import 'package:meri_id_operator/presentation/features/QRpage.dart';
import 'package:meri_id_operator/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../services/widgets/CustomText.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  _navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  _navigateToQrPage() {
    Navigator.pushNamed(context, QRpage.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Styles.redColor),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText.xLargeText("Home"),
                      IconButton(
                          onPressed: () {
                            _navigateToQrPage();
                          },
                          icon: Icon(
                            Icons.qr_code,
                            size: 32,
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  for (int i = 0; i < 10; i++)
                    CustomCard(
                      name: "Janhvi Singh",
                      time: "4:00pm",
                      lat: latitude!,
                      long: longitude!,
                      onMapClick: () {
                        _navigateTo(latitude!, longitude!);
                      },
                      persons: 2,
                      onTap: () {},
                      makeCall: () {
                        launchUrlString("tel:+91963852741");
                      },
                    ),
                ],
              ),
            ),
          );
  }
}

// buildAvailability(context),
//                 const SizedBox(height: 24),
//                 buildAuthenticate(context),
