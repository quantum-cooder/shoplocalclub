import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shoplocalclubcard/utils/utils.dart';

void handleError({
  required dynamic error,
}) {
  String errorMessage = "An unexpected error occurred.";

  if (error is SocketException) {
    errorMessage =
        "No internet connection. Please check your network settings.";
  } else if (error is TimeoutException) {
    errorMessage = "Request timed out. Please try again.";
  } else if (error is http.ClientException) {
    errorMessage = "HTTP Error. Please try again later.";
    if (error is http.Response) {
      errorMessage = "HTTP Error. Please try again later.";
    }
  } else if (error is FormatException) {
    errorMessage = "Invalid response format. Please contact support.";
  } else {
    errorMessage =
        "An unexpected error occurred. Please try again later or contact support.";
  }
  showToast(toastMsg: errorMessage, isError: true);
}
