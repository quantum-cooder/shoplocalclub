import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class ShopApi {
  static Future<void> getShops({
    required String token,
    required String latitude,
    required String longitude,
  }) async {
    final url = Uri.parse(ApiEndPoints.shops);
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
          "latitude": latitude,
          "longitude": longitude,
        }),
      );
      // log('getShop response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        ShopModel.fromJson(data);

        if (ShopModel.instance?.data?.shop != null) {
          final obj = ShopModel.instance!;
          log("Shop data: ${obj.data!.shop.toString()}");
        } else {
          log("ShopModel data is null: ${data.toString()}");
        }
      } else {
        log('API error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      log('getShop error: $e');
      handleError(error: e);
    }
  }
}
