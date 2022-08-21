import 'dart:convert';
import 'package:http/http.dart';
import 'package:meri_id_operator/model/Booking.dart';
import 'package:meri_id_operator/model/UserAttendance.dart';
import 'package:meri_id_operator/model/UserProfile.dart';
import 'package:meri_id_operator/utils/global.dart';

class ApiService {
  ApiService._();
  factory ApiService.getInstance() => _instance;
  static final ApiService _instance = ApiService._();

  final String baseUrl = "https://meriid.herokuapp.com/api";
  final String role = 'operator';
  final String token = 'Token';

  Future<bool> getOtp(String phoneNumber) async {
    final String url = "$baseUrl/auth/otp-send";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
          <String, String>{'phone_number': phoneNumber, 'role': role}),
    );
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> login(String phoneNumber, String otp) async {
    final String url = "$baseUrl/auth/login";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body:
          jsonEncode(<String, String>{'phone_number': phoneNumber, 'otp': otp}),
    );

    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      await preferenceService.setUID(body["data"]["token"]);
      return true;
    }
    return false;
  }

  Future<bool> logOut() async {
    await preferenceService.removeUID();
    return true;
  }

  Future<void> getProfile() async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/profile/operator";
    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      userProfile = UserProfile(
          uuid: body['data']['uuid'],
          name: body['data']['name'],
          number: body['data']['number'],
          userId: body['data']['userId'],
          status: body['data']['status'],
          attendance: body['data']['attendance']);
    } else {
      userProfile = UserProfile(
          uuid: "uuid",
          name: "User",
          number: "7830980xxx",
          userId: "123",
          status: "active",
          attendance: "absent");
    }
  }

  Future<bool> raiseIssue(String title, String description) async {
    String? authId = await preferenceService.getUID();
    print(authId);
    final String url = "$baseUrl/auth/issue";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(
            <String, String>{'title': title, 'description': description}));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<String> getGuildeLines() async {
    final String url = "$baseUrl/general/guidelines?role=operator";
    Response res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body["data"][0]["guideline"];
    }
    return "No GuidelInes";
  }

  Future<bool> punchInAttendance(String date, String time) async {
    print(date);
    print(time);
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/attendance";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          "date": date,
          "punch_in": time,
        }));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> punchOutAttendance(String date, String time) async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/attendance/punch-out";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          "date": date,
          "punch_out": time,
        }));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<UserAttendance> checkAttendance() async {
    String? authId = await preferenceService.getUID();
    DateTime now = DateTime.now();
    String date =
        "${now.year.toString()}-${now.month.toString()}-${now.day.toString()}";
    final String url =
        "$baseUrl/auth/attendance?operator=${userProfile.uuid}&date_from=$date&date_to=$date";
    Response res = await get(Uri.parse(url), headers: {
      'content-type': 'application/json',
      'Authorization': '$token $authId'
    });
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return UserAttendance(
          status: body["data"][0]["status"] ?? "",
          punch_in: body["data"][0]["punch_in"] ?? "");
    }
    return UserAttendance(status: "", punch_in: "");
  }

  Future<List<Booking>> getBooking() async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/booking/list/operator";
    List<Booking> bookList = [];
    Response response = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var res = body["data"];
      for (int i = 0; i < res.length; i++) {
        bookList.add(Booking(
            lat: res[i]["lat"] ?? "",
            long: res[i]["long"] ?? "",
            name: res[i]["name"] ?? "",
            numberofPeople: res[i]["no_of_people"].toString(),
            bookingId: res[i]["booking_id"] ?? "",
            timeSlot: res[i]["time_slot"] ?? "",
            day: res[i]["date"] ?? "",
            number: res[i]["number"] ?? "",
            uuid: res[i]["uuid"] ?? "",
            status: res[i]["status"] ?? ""));
      }
    }
    return bookList;
  }

  Future<bool> updateBooking(String uuid) async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/booking/status/update";
    Response res = await put(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(
            <String, String>{"uuid": uuid, "status": "operator_out"}));
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }
}
