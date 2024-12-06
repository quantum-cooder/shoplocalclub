import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoplocalclubcard/constants/constants.dart';

void showToast({
  required String toastMsg,
  bool isError = false,
  Toast toastLength = Toast.LENGTH_SHORT,
}) {
  Fluttertoast.showToast(
    msg: toastMsg,
    toastLength: toastLength,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? AppColors.primary : AppColors.white,
    textColor: isError ? AppColors.white : AppColors.primary,
    fontSize: 14.0,
    timeInSecForIosWeb: 1,
  );
}
