import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class AddRemoveShopFromFavApi {
  static Future<void> addShopToFav({
    required String token,
    required int shopId,
    required int locationId,
  }) async {
    final url = Uri.parse("${ApiEndPoints.addShopToFavourite}$shopId");

    try {
      final response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "api_token": token,
            "location_id": locationId,
          },
        ),
      );
      log("addShopToFav response: ${response.body}");
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data["result"]) {
          if (data["result"]) {
            ///update value in provider to update UI
          }
        }
      }
    } catch (e) {
      log("addShopToFav response exception: $e");
      handleError(error: e);
    }
  }

  static Future<void> removeShopfromFav({
    required String token,
    required String shopId,
  }) async {
    final url = Uri.parse("${ApiEndPoints.removeShopToFavourite}$shopId");

    try {
      final response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "api_token": token,
          },
        ),
      );
      log("removeShopfromFav response: ${response.body} ");
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);

        if (data["result"]) {
          ///update value in provider to update UI
        }
      }
    } catch (e) {
      handleError(error: e);
      log("removeShopfromFav response: $e");
    }
  }
}
