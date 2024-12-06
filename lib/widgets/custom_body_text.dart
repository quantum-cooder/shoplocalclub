import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

Widget customBodyText(String title) {
  return CustomText(
    title: title,
    color: Colors.black,
    fontSize: AppFontSize.medium,
    fontWeight: FontWeight.w600,
  );
}
