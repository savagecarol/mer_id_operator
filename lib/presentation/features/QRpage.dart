

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meri_id_operator/utils/styles.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRpage extends StatefulWidget {
  static const String routeNamed = 'qr page';
  const QRpage({Key? key}) : super(key: key);

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {

  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;
//in order to get hot reload to work.
  
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }



void onQRViewCreated(QRViewController p1) 
{
//called when View gets created. 
    this.controller = p1;

    controller.scannedDataStream.listen((scanevent) {
      setState(() {
//UI gets created with new QR code.
        result = scanevent;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _scanQRCode() {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderWidth: 10,
                    borderColor: Colors.teal,
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: 220,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
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
            body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: onQRViewCreated,
                  overlay: QrScannerOverlayShape(
//customizing scan area
                    borderWidth: 10,
                    borderColor: Colors.teal,
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await controller.flipCamera();
                            }),
                        IconButton(
                            icon: const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await controller.toggleFlash();
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(8.0),
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: result != null
                    ? Column(
                        children: [
                          Text('Code: ${result!.code}'),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text('Format: ${result!.format}'),
                        ],
                      )
                    : Text('Scan Code'),
              ),
            ),
          ),
        ],
      ),
      )
      );
  }
}
