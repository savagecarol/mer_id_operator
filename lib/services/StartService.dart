import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:meri_id_operator/services/PreferenceService.dart';
import 'package:meri_id_operator/utils/global.dart';

class StartService {
  StartService._();
  factory StartService.getInstance() => _instance;
  static final StartService _instance = StartService._();

  final String baseUrl = "https://meriid.herokuapp.com/api";
  final String role = 'operator';
  final String token = 'Token';

  Future<void> sendlatLong() async {
    Location location = Location();
    final _locationData = await location.getLocation();
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/operator/location/update/${userProfile.uuid}";
    Response res = await put(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          'lat': _locationData.latitude.toString(),
          'long': _locationData.longitude.toString()
        }));
    print(res.statusCode);
  }

  Future<void> doRun() async {
    String? uid = await preferenceService.getUID();
    if (uid == null || uid == "") {
      return;
    } else {
      await apiService.getProfile();
      if (userProfile.attendance == "present") {
        await sendlatLong();
      }
    }
  }
}
