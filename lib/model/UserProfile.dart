import 'package:flutter/material.dart';

class UserProfile {
  late String uuid;
  late String name;
  late String number;
  late String userId;
  late String status;
  late String attendance;
  UserProfile(
      {
      required this.uuid,
      required this.name,
      required this.number,
      required this.userId,
      this.status = "active",
      this.attendance = "absent"});
}
