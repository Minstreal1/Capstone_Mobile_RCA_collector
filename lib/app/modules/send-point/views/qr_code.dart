import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '/app/modules/calendar-detail/controllers/calendar_detail_controller.dart';
import '/app/modules/send-point/controllers/send_point_controller.dart';
import '/app/resource/reponsive_utils.dart';

class QrViewSendPoint extends StatefulWidget {
  const QrViewSendPoint({super.key});

  @override
  State<QrViewSendPoint> createState() => _QrViewSendPointState();
}

class _QrViewSendPointState extends State<QrViewSendPoint> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: (result != null)
                    ? Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    : Text(
                        'Scan a code',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize:
                                UtilsReponsive.formatFontSize(16, context),
                            fontWeight: FontWeight.w600),
                      )),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          Get.find<SendPointController>().getDataUserQr(result!.code!);
          Get.back();
          controller.dispose();
          // Get.back();
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
