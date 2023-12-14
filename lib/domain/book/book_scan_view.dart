import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:bookbox/util/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

@RoutePage()
class BookScanView extends ConsumerStatefulWidget {
  const BookScanView({super.key});

  @override
  ConsumerState<BookScanView> createState() => _BookScanViewState();
}

class _BookScanViewState extends ConsumerState<BookScanView> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  late QRViewController controller;

  void pop() {
    context.router.pushAndPopUntil(const AppRootRoute(),
        predicate: (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  Future<void> _onQRViewCreated(QRViewController ctrl) async {
    final grant = await PermissionHelper.requestCameraPermission();
    if (grant) {
      // setState(() {
      //   controller = ctrl;
      // });
      ctrl.scannedDataStream.listen((scanData) {
        context.router.pop();
        context.router.push(UserBookRegistViewRoute(code: scanData.code));
        ctrl.dispose();
        // setState(() {
        //   result = scanData;
        //   context.router.push(UserBookRegistViewRoute(code: scanData.code));
        // });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              onQRViewCreated: _onQRViewCreated,
              key: qrKey,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.cyanAccent,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8),
            ),
          ),
          if (result != null) Text(result?.code?.toString() ?? ""),
        ],
      ),
    );
  }
}
