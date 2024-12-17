import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

Widget customBodyText(String title, {Color color = Colors.black}) {
  return CustomText(
    title: title,
    color: color,
    fontSize: AppFontSize.medium,
    fontWeight: FontWeight.w600,
  );
}
