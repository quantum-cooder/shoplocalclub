import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

class VoucherApi {
  static Future<List<MembershipCardVoucher>?> getVouchersForShop({
    int limit = 50,
    int offset = 0,
    bool isArchived = false,
  }) async {
    final url = Uri.parse(
        isArchived ? ApiEndPoints.archivedVouchers : ApiEndPoints.mineVouchers);
    final token = await UserApiToken.getToken();
    try {
      final http.Response response = await http.post(
        url,
        headers: ApiEndPoints.apiHeaders,
        body: jsonEncode({
          "api_token": token,
          "limit": limit,
          "offset": offset,
        }),
      );
      log('getVouchersForShop response: ${response.body}');

      if (response.statusCode == ApiEndPoints.successCode) {
        final data = jsonDecode(response.body);
        if (data['result']) {
          final vouchers = VoucherModel.fromJson(data);
          log('Fetched vouchers: ${vouchers.data?.membershipcardVouchers?.length ?? 0}');
          return VoucherModel.instance?.data?.membershipcardVouchers!;
        }
      } else {
        log('API Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      log('getVouchersForShop error: $e');
      handleError(error: e);
    }
    return null;
  }
}
