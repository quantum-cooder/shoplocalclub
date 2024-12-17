import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';
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
      handleError(error: e);
    }

    return null;
  }

  static Future<bool> operateShop(int locationId) async {
    final token = await UserApiToken.getToken();
    final url = Uri.parse("${ApiEndPoints.operateShop}$locationId");
    bool canOperate = false;
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
          return canOperate = true;
        }
      }
    } catch (e) {
      log('operateShop() error: $e');
      return canOperate;
    }

    return canOperate;
  }

  static Future<void> getSpecificShop(int shopLocationId) async {
    final token = await UserApiToken.getToken();
    final url = Uri.parse("${ApiEndPoints.getSpecificShop}$shopLocationId");
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({"api_token": token}),
      );
      log('getSpecificShop() response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          SpecificShopModel.fromJson(data);
        }
      }
    } catch (e) {
      log('getSpecificShop() error: $e');
      handleError(error: e);
    }
  }

  static Future<bool> hasCheckedInSpecificShop(int shopLocationId) async {
    final token = await UserApiToken.getToken();
    final url =
        Uri.parse("${ApiEndPoints.hasCheckedInSpecificShop}$shopLocationId");
    bool hasCheckIn = false;
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({"api_token": token}),
      );
      log('hasCheckedInSpecificShop() response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          return hasCheckIn = data['result'];
        }
      }
    } catch (e) {
      log('hasCheckedInSpecificShop() error: $e');
      handleError(error: e);
      return hasCheckIn;
    }
    return hasCheckIn;
  }

  static Future<void> getShopOperatorUserData(String membercard) async {
    final token = await UserApiToken.getToken();
    final url = Uri.parse("${ApiEndPoints.specificShopOperatorUserData}");
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "api_token": token,
            "membercard": membercard,
          },
        ),
      );
      log('getShopOperatorUserData() response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          OperateShopModel.fromJson(data);
        }
      }
    } catch (e) {
      log('getShopOperatorUserData() error: $e');
      handleError(error: e);
    }
  }
}
