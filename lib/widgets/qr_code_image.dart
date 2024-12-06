import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/apis/apis.dart';

Widget qrCodeImage(String qrCodeBase64) {
  // Remove the data:image/png;base64, prefix if it exists
  if (qrCodeBase64.startsWith('data:image/png;base64,')) {
    qrCodeBase64 = qrCodeBase64.replaceFirst('data:image/png;base64,', '');
  }

  // Decode the base64 string
  final qrCodeBytes = base64Decode(qrCodeBase64);

  // Return an Image widget displaying the QR code
  return Image.memory(
    qrCodeBytes,
  );
}

builQrImage() {
  return FutureBuilder(
    future: CardMembershipApis.showQRCode(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CupertinoActivityIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Icon(Icons.error_outline_outlined));
      }
      final data = snapshot.data as String;
      return qrCodeImage(data);
    },
  );
}
