import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/stamp_card_model.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class StampCardApi {
  static Future<void> getStampCardData() async {
    final url = Uri.parse(ApiEndPoints.stampCard);
    final token = await UserApiToken.getToken();

    try {
      final response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
        }),
      );

      log('getStampCardData response: ${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          StampCardModel.fromJson(data);
          log('Fetched stamp cards: ${StampCardModel.instance?.data?.stampcardUsers?.length}');
        }
      }
    } catch (e) {
      log('getStampCardData error: $e');
      handleError(error: e);
    }
  }
}
