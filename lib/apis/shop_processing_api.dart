import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/shop_processing_model.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class ShopProcessingApi {
  static Future<ShopProcessingModel?> getShopsOperatedByUser() async {
    final token = await UserApiToken.getToken();
    final url = Uri.parse(ApiEndPoints.shopsOperatedByUser);

    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({"api_token": token}),
      );

      log('getShopsOperatedByUser response : ${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);

        if (data['result']) {
          return ShopProcessingModel.fromJson(data);
        }
      }
    } catch (e) {
      log('getShopsOperatedByUser error: $e');
    }

    return null;
  }

  static Future<ShopProcessingModel?> operateShop() async {
    final token = await UserApiToken.getToken();
    final url = Uri.parse(ApiEndPoints.operateShop);

    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({"api_token": token}),
      );

      log('operateShop() response : ${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);

        if (data['result']) {
          return ShopProcessingModel.fromJson(data);
        }
      }
    } catch (e) {
      log('operateShop() error: $e');
    }

    return null;
  }
}
