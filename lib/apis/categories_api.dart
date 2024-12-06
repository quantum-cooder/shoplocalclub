import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class CategoriesApi {
  static Future<void> getAllCategories() async {
    try {
      final http.Response response = await http.post(
        Uri.parse(ApiEndPoints.categories),
        headers: ApiEndPoints.apiHeaders,
      );
      // log('getAllCategories response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        CategoriesModel.fromJson(data);
        if (CategoriesModel.hasData) {
          // log('Fetched categories:${CategoriesModel.instance?.data?.categories ?? []} ');
        }
      }
    } catch (e) {
      log('getAllCategories error: $e');
      handleError(error: e);
    }
  }
}
