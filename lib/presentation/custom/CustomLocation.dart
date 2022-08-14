//import "package:meri_id/presentation/custom/custom_scaffold.dart";
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomLocation extends StatefulWidget {
  final double lat;
  final double long;
  final double zoom;

  CustomLocation({required this.lat, required this.long , required this.zoom});

  @override
  _CustomLocationState createState() => _CustomLocationState();
}

class _CustomLocationState extends State<CustomLocation> {
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: const MarkerId('myMarker'),
      draggable: false,
      onTap: () {},
      position: LatLng(widget.lat, widget.long),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.long), zoom: widget.zoom),
          markers: Set.from(allMarkers),
        ),
      ],
    );
  }
}
