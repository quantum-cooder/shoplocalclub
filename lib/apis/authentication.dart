// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class Authentication {
  static Future<bool> checkEmailExists(String email) async {
    bool userExists = false;
    try {
      final http.Response response = await http.post(
          Uri.parse(
            ApiEndPoints.checkEmail,
          ),
          headers: ApiEndPoints.apiHeaders,
          body: jsonEncode({RegisterUserModel.keyEmail: email}));
      log('///user exists response: ${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        log('///////user exists:${data['result']}');
        if (data['result']) {
          userExists = true;
          showToast(toastMsg: 'This email alreay exists');
        }
      }
      return userExists;
    } catch (e) {
      log('/// email exists error: $e');
      handleError(error: e);
      return userExists;
    }
  }

  static Future<void> signUp(
      RegisterUserModel model, BuildContext context) async {
    if ((!await checkEmailExists(model.email!))) {
      try {
        final http.Response response = await http.post(
            Uri.parse(ApiEndPoints.registerUser),
            headers: ApiEndPoints.apiHeaders,
            body: jsonEncode(model.toMap(model)));
        if (response.statusCode == ApiEndPoints.successCode) {
          Map<dynamic, dynamic> data = jsonDecode(response.body);

          if (data['result']) {
            await UserApiToken.storeToken(data['data']['api_token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.cardMemberShip,
              (route) => false,
              arguments: model.name,
            );
            await verifyEmail(
              token: data['data']['api_token'],
              userId: data['data']['user']['id'],
              context: context,
            );
          }
        }
      } catch (e) {
        log('error:///////////$e');
        handleError(error: e);
      }
    }
  }

  static Future<void> verifyEmail({
    required String token,
    required int userId,
    required BuildContext context,
  }) async {
    try {
      final http.Response response = await http.post(
          Uri.parse('${ApiEndPoints.verifyEmail}/$userId'),
          headers: ApiEndPoints.apiHeaders,
          body: jsonEncode({'verification_code': token}));

      log('verifyEmail response body:${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        Map<dynamic, dynamic> data = jsonDecode(response.body);
        log('message:::::::${data['result']}');
        log('message:://////////::${data['data']['api_token']}');
        if (data['result']) {
          await UserApiToken.storeToken(data['data']['api_token']);
          showToast(
            toastMsg: 'Check email for verification code',
            toastLength: Toast.LENGTH_LONG,
          );
        }
      }
    } catch (e) {
      log(' verifyEmail error:$e');
      handleError(error: e);
    }
  }

  static Future<void> reSendVerifyEmail({
    required String email,
  }) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(ApiEndPoints.resendEmailVerify),
          headers: ApiEndPoints.apiHeaders,
          body: jsonEncode({'email': email}));

      log('reSendVerifyEmail response body:${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        Map<dynamic, dynamic> data = jsonDecode(response.body);
        log('message:::::::${data['result']}');
        if (data['result']) {
          showToast(
            toastMsg: 'Code Sent',
            toastLength: Toast.LENGTH_LONG,
          );
        } else if (!data['result']) {
          showToast(toastMsg: data['errors']['user'], isError: true);
        }
      }
    } catch (e) {
      log('reSendVerifyEmail error:$e');
      handleError(error: e);
    }
  }

  static Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(ApiEndPoints.login),
              headers: ApiEndPoints.apiHeaders,
              body: jsonEncode({
                'email': email,
                'password': password,
              }));
      log('login response ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data['result']) {
          await UserApiToken.storeToken(data['data']['api_token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        } else if (!data['result']) {
          showToast(toastMsg: data['errors']['user']);
        }
      }
    } catch (e) {
      log('login response error: $e');
      handleError(error: e);
    }
  }

  static Future<void> logout(BuildContext context) async {
    // await StoreApiToken.deleteToke();
    // final token = await StoreApiToken.getToken();
    // log(token.toString());
    try {
      final token = await UserApiToken.getToken();
      final http.Response response =
          await http.post(Uri.parse(ApiEndPoints.logout),
              headers: ApiEndPoints.apiHeaders,
              body: jsonEncode({
                'api_token': token,
              }));
      log('logout response ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data['result']) {
          await UserApiToken.deleteToke();
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.splash,
            (route) => false,
          );
        }
      }
    } catch (e) {
      log('login response error: $e');
      handleError(error: e);
    }
  }

  static Future<void> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    final Uri uri = Uri.parse(ApiEndPoints.resetPassword);
    try {
      log('$email     $password        $confirmPassword     $token');
      final http.Response response = await http.post(
        uri,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "password_confirmation": confirmPassword,
            "token": token,
          },
        ),
      );
      log('reset pwd response: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data['result']) {
          showToast(toastMsg: 'Password updated');
          await UserApiToken.storeToken(data['data']['api_token']);
        } else if (!data['result']) {
          showToast(toastMsg: data['errors']['user']);
        }
      }
    } catch (e) {
      log('reset pwd exception: ${e.toString()}');
      handleError(error: e);
    }
  }

  static Future<void> forgotPassword({
    required String email,
  }) async {
    final Uri uri = Uri.parse(ApiEndPoints.forgotPassword);
    try {
      final http.Response response = await http.post(
        uri,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "email": email,
          },
        ),
      );
      log('forgotPassword response: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data['result']) {
          showToast(toastMsg: 'Link is sent at your email to restore password');
          await UserApiToken.storeToken(data['data']['api_token']);
        } else if (!data['result']) {
          showToast(toastMsg: data['errors']['user']);
        }
      }
    } catch (e) {
      log('forgotPassword exception: ${e.toString()}');
      handleError(error: e);
    }
  }

  static Future<bool> checkInLocation(
      {required String token, required int locationId}) async {
    final Uri uri = Uri.parse(ApiEndPoints.checkInLocations);
    bool isCheckedIn = false;
    try {
      final http.Response response = await http.post(
        uri,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode(
          {
            "api_token": token,
          },
        ),
      );
      log('user  checkInLocation: ${response.body}');
      if (response.statusCode == ApiEndPoints.successCode) {
        final data = await jsonDecode(response.body);
        if (data['result']) {
          isCheckedIn = true;
        }
      }
      return isCheckedIn;
    } catch (e) {
      log('user checkInLocation exception: ${e.toString()}');
      handleError(error: e);
      return isCheckedIn;
    }
  }
}
