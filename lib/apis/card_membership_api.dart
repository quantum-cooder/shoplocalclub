import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class CardMembershipApis {
  static Future<bool> doesCardExists() async {
    bool cardExists = false;
    final uri = Uri.parse(ApiEndPoints.checkCard);
    final token = await UserApiToken.getToken();
    log('token: $token');
    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode({
          'api_token': token,
        }),
        headers: ApiEndPoints.apiHeaders,
      );
      log('getCard response: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        cardExists = data['result'];
        return cardExists;
      }
      return cardExists;
    } catch (e) {
      log('getCard exception');
      handleError(error: e);
      return false;
    }
  }

  static Future<void> claimCard(String cardNbr) async {
    final uri = Uri.parse(ApiEndPoints.claimCard);
    // final token = await StoreApiToken.getToken();
    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode({
          'code': cardNbr,
        }),
        headers: ApiEndPoints.apiHeaders,
      );
      log('getCard response: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (!data['result']) {
          showToast(toastMsg: data['errors']['membershipcard']);
        } else if (data['result']) {
          //////shakil updated its functionality to see what happens after user manul entrance of membership card given by company
        }
      }
    } catch (e) {
      log('claim card exception $e');
      handleError(error: e);
    }
  }

  static Future<String?> makeCard() async {
    String? code;
    final uri = Uri.parse(ApiEndPoints.makeCard);
    final token = await UserApiToken.getToken();
    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode({
          'api_token': token,
        }),
        headers: ApiEndPoints.apiHeaders,
      );
      log('makeCard response: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (!data['result']) {
          // showToast(toastMsg: data['result']['errors']['membershipcard']);
        } else if (data['result']) {
          code = data['data']['membershipcard']['code'];
          log('code : $code');
          //////shakil updated its functionality to see what happens after user manul entrance of membership card given by company
        }
      }
      return code;
    } catch (e) {
      log('makeCard exception $e');
      handleError(error: e);
      return null;
    }
  }

  static Future<String?> showQRCode() async {
    String? base64String;
    final uri = Uri.parse(ApiEndPoints.qrCode);
    final token = await UserApiToken.getToken();
    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode({
          'api_token': token,
        }),
        headers: ApiEndPoints.apiHeaders,
      );
      log('makeCard response: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (!data['result']) {
          // showToast(toastMsg: data['result']['errors']['membershipcard']);
        } else if (data['result']) {
          base64String = data['data']['qr'];
          log('base64String : $base64String');
          //////shakil updated its functionality to see what happens after user manul entrance of membership card given by company
        }
      }
      return base64String;
    } catch (e) {
      log('makeCard exception $e');
      handleError(error: e);
      return null;
    }
  }
}
