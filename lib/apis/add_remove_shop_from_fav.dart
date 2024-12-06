import 'dart:convert';
import 'dart:developer';

import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/utils/utils.dart';

class AddRemoveShopFromFav {
  static Future<bool> addShopToFav({
    required String token,
    required int shopId,
  }) async {
    final url = Uri.parse("${ApiEndPoints.addShopToFavourite}$shopId");
    bool isFav = false;
    try {
      final response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "api_token": token,
            "location_id": shopId,
          },
        ),
      );
      log("addShopToFav response: ${response.body}");
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data["result"]) {
          isFav = true;
        }
      }
      return isFav;
    } catch (e) {
      log("addShopToFav response exception: $e");
      handleError(error: e);
      return isFav;
    }
  }

  static Future<void> removeShopfromFav({required String token}) async {
    final url = Uri.parse(ApiEndPoints.removeShopToFavourite);

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
          // return true;
          // update ui
        }
      }
    } catch (e) {
      handleError(error: e);
      log("removeShopfromFav response: $e");
    }
  }
}
