import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/all_shops_model.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class ShopApi {
  static Future<void> getFavoriteShops({
    required String token,
    required String latitude,
    required String longitude,
  }) async {
    final url = Uri.parse(ApiEndPoints.nearByShops);
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
          "latitude": latitude,
          "longitude": longitude,
          "limit": 50,
          "favorite": true,
        }),
      );
      log('getFavoriteShops response code= ${response.statusCode} : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          FavoriteShopsModel.fromJson(data);
          // log('Fetched shop: ${ShopModel.instance?.data}');
        }
      }
    } catch (e) {
      log('getShop error: $e');
      handleError(error: e);
    }
  }

  static Future<void> getNearByShops({
    required String token,
    required String latitude,
    required String longitude,
    bool isFavorite = false,
  }) async {
    final url = Uri.parse(ApiEndPoints.nearByShops);
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
          "latitude": latitude,
          "longitude": longitude,
          "limit": 50,
        }),
      );
      log('getShop response = ${response.statusCode} & isFavorite = $isFavorite: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          AllShopModel.fromJson(data);
          // log('Fetched shop: ${ShopModel.instance?.data}');
        }
      }
    } catch (e) {
      log('getShop error: $e');
      handleError(error: e);
    }
  }
}

// static Future<void> getUsersShops({
//     required String token,
//   }) async {
//     final url = Uri.parse(ApiEndPoints.shops);

//     try {
//       final http.Response response = await http.post(
//         url,
//         headers: ApiEndPoints.apiHeaders,
//         body: jsonEncode({
//           "api_token": token,
//         }),
//       );
//       log('getShop response : ${response.body}');
//       if (response.statusCode == ApiEndPoints.successCode) {
//         final data = jsonDecode(response.body);
//         if (data['result']) {
//           AllShopModel.fromJson(data);
//           log('Fetched shop: ${AllShopModel.instance?.data}');
//         }
//       }
//     } catch (e) {
//       log('getShop error: $e');
//       handleError(error: e);
//     }
//   }
