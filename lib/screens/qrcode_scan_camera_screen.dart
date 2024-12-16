import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/providers/providers.dart';

class QrcodeScanCameraScreen extends StatelessWidget {
  const QrcodeScanCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MobileScannerController cameraController = MobileScannerController();
    final provider =
        Provider.of<StampCardNumberProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (barcodeCapture) {
          if (barcodeCapture.barcodes.isNotEmpty) {
            final barcode = barcodeCapture.barcodes.first.rawValue;
            if (barcode != null) {
              provider.scanQrCodeFromCamera(barcode);
              Navigator.pop(
                  context); // Close the scanner once the code is scanned
            }
          }
        },
      ),
    );
  }
}
