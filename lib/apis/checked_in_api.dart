import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class CheckedInApi {
  static Future<void> checkInShop({
    required String token,
    required int locationId,
  }) async {
    final url = Uri.parse(ApiEndPoints.checkInLocations);

    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
        }),
      );
      // log('getShop response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          // log('Fetched shop: ${ShopModel.instance?.data}');
        }
      }
    } catch (e) {
      log('getShop error: $e');
      handleError(error: e);
    }
  }
}
