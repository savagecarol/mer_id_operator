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

  _getUserLocation() async {
    Location location = Location();
    final _locationData = await location.getLocation();
    return [_locationData.latitude, _locationData.longitude];
  }

  Future<void> sendlatLong() async {
    String? authId = await PreferenceService.uid;
    List<Double?> loc = await _getUserLocation();

    final String url = "$baseUrl/auth/issue";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          'lat': loc[0].toString(),
          'long': loc[1].toString(),
          'user': userProfile.userId
        }));
  }

  Future<void> doRun() async {
    String? uid = await preferenceService.getUID();
      if (uid == null || uid == "") {
        return;
      } else {
        await apiService.getProfile();
        if (userProfile.status != "absent") {
          await sendlatLong();
      }
    }
  }

}
