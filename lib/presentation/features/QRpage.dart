import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meri_id_operator/presentation/custom/CustomButton.dart';
import 'package:meri_id_operator/presentation/features/Selfie.dart';
import 'package:meri_id_operator/presentation/features/TakeSelfie..dart';
import 'package:meri_id_operator/services/widgets/CustomText.dart';
import 'package:meri_id_operator/utils/global.dart';
import 'package:meri_id_operator/utils/styles.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../SplashPage.dart';

class QRpage extends StatefulWidget {
  static const String routeNamed = 'qr page';

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  late bool loadingYes = false;
  late bool loadingNo = false;

  @override
  void dispose() {
    super.dispose();
  }

  int i = 1;
  MobileScannerController cameraController = MobileScannerController();
  String? defaultContainerUrl = null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SplashPage.routeNamed);
            },
          ),
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 52),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.xLargeText("SCAN QR CODE"),
              const SizedBox(height: 128),
              Card(
                elevation: 20,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Styles.blackColor, width: 8),
                  ),
                  child: MobileScanner(
                      allowDuplicates: false,
                      controller: cameraController,
                      onDetect: (barcode, args) async {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                        } else {
                          final String code = barcode.rawValue!;
                          debugPrint('Barcode found! $code');

                          if (i == 1) {
                            successToast("QR Scanned", context);
                            i++;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      TakeSelfie(code: code)));
                        }
                      }),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.torchState,
                      builder: (context, state, child) {
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(Icons.flash_off);
                          case TorchState.on:
                            return const Icon(Icons.flash_on);
                        }
                      },
                    ),
                    iconSize: 30,
                    onPressed: () => cameraController.toggleTorch(),
                  ),
                  IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front);
                          case CameraFacing.back:
                            return const Icon(Icons.camera_rear);
                        }
                      },
                    ),
                    iconSize: 30,
                    onPressed: () => cameraController.switchCamera(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
