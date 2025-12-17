//lib/features/qr/pages/qr_scanner_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _hasScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner un QR Code")),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
        ),
        onDetect: (barcodeCapture) {
          if (_hasScanned) return;

          final barcode = barcodeCapture.barcodes.first;
          final String? rawValue = barcode.rawValue;

          if (rawValue == null) return;

          _hasScanned = true;

          // 🔙 Retourner le résultat à l'écran précédent
          Navigator.pop(context, rawValue);
        },
      ),
    );
  }
}
