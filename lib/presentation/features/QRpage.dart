import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meri_id_operator/utils/styles.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRpage extends StatefulWidget {
 static const String routeNamed = 'qr page';
  const QRpage({Key? key}) : super(key: key);

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  String result = "Hello World...!";
  
  Future _scanQR() async {
    try {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        result =
            cameraScanResult!; // setting string result with cameraScanResult
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: Center(
          child: Text(result), // Here the scanned result will be shown
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _scanQR(); // calling a function when user click on button
            },
            label: Text("Scan")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
