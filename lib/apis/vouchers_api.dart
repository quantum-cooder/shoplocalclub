// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:shoplocalclubcard/apis/apis.dart';
// import 'package:shoplocalclubcard/models/models.dart';
// import 'package:shoplocalclubcard/utils/utils.dart';

// class VoucherApi {
//   static Future<void> getVouchersForShop(
//     String shopId, {
//     int limit = 50,
//     int offset = 0,
//   }) async {
//     final url = Uri.parse('${ApiEndPoints.vouchers}$shopId');
//     final token = await UserApiToken.getToken();
//     try {
//       final http.Response response = await http.post(
//         url,
//         headers: ApiEndPoints.apiHeaders,
//         body: jsonEncode({
//           "api_token": token,
//           "limit": limit,
//           "offset": offset,
//         }),
//       );
//       log('getVouchersForShop response : ${response.body}');

//       if (response.statusCode == ApiEndPoints.successCode) {
//         final data = jsonDecode(response.body);
//         if (data['result']) {
//           VoucherModel.fromJson(data);
//           log('Fetched vouchers: ${VoucherModel.instance?.data?.vouchers?.length ?? 0}');
//         }
//       }
//     } catch (e) {
//       log('getVouchersForShop error: $e');
//       handleError(error: e);
//     }
//   }
// }
