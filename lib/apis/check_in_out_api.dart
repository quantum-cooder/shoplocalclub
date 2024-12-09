import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class CheckedInOutApi {
  static Future<void> checkInLocation({
    required String token,
    required int locationId,
  }) async {
    final url = Uri.parse("${ApiEndPoints.checkInShopLocation}$locationId");

    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
        }),
      );
      log('checkInLocation response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          // log('Fetched shop: ${ShopModel.instance?.data}');
        }
      }
    } catch (e) {
      log('checkInLocation error: $e');
      handleError(error: e);
    }
  }

  static Future<void> checkOutLocation({
    required String token,
    required int locationId,
  }) async {
    final url = Uri.parse("${ApiEndPoints.checkOutShopLocation}$locationId");

    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
        }),
      );
      log('checkOutLocation response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          // log('Fetched shop: ${ShopModel.instance?.data}');
        }
      }
    } catch (e) {
      log('checkOutLocation error: $e');
      handleError(error: e);
    }
  }
}
