import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class ProfileApi {
  static Future<void> getprofileData() async {
    final token = await UserApiToken.getToken();

    try {
      final http.Response response = await http.post(
        Uri.parse(ApiEndPoints.userProfile),
        body: jsonEncode({'api_token': token}),
        headers: ApiEndPoints.apiHeaders,
      );
      log('getprofileData response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data['result']) {
          UserProfileModel.fromJson(data);
        }
      }
    } catch (e) {
      log('getprofileData error: $e');
      handleError(error: e);
    }
  }

  static Future<void> updateUserProfile(
      {required String? zipCode,
      required String? name,
      required File? avatar,
      required int? countryId}) async {
    final token = await UserApiToken.getToken();

    try {
      final http.Response response = await http.post(
        Uri.parse(ApiEndPoints.updateProfile),
        body: jsonEncode({
          'api_token': token,
          'zipcode': zipCode,
          'name': name,
          'avatar': avatar,
          'country_id': countryId,
        }),
        headers: ApiEndPoints.apiHeaders,
      );
      log('updateUserProfile response : ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        log('updateUserProfile : ${data['result']}');
        if (data['result']) {
          showToast(toastMsg: 'Profile updated successfully');
        }
      }
    } catch (e) {
      log('updateUserProfile error: $e');
      handleError(error: e);
    }
  }
}
