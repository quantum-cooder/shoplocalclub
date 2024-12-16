import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';

class StampCardNumberProvider extends ChangeNotifier {
  String _cardNumber = '';

  String get cardNumber => _cardNumber;

  /// Pick image and scan QR code
  Future<void> scanQrCodeFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final File imageFile = File(pickedImage.path);
      final barcodeScanner = BarcodeScanner();
      final inputImage = InputImage.fromFile(imageFile);

      final barcodes = await barcodeScanner.processImage(inputImage);
      await barcodeScanner.close();

      if (barcodes.isNotEmpty) {
        _cardNumber = barcodes.first.rawValue ?? '';
        notifyListeners();
      } else {
        _cardNumber = "No QR code found";
        notifyListeners();
      }
    } catch (e) {
      _cardNumber = "Error: $e";
      notifyListeners();
    }
  }

  /// Scan QR code from Camera
  void scanQrCodeFromCamera(String scannedValue) {
    _cardNumber = scannedValue;
    notifyListeners();
  }
}
