import 'package:flutter/material.dart';
import 'package:meri_id_operator/utils/styles.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  CustomScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body,
      ),
    );
  }
}
