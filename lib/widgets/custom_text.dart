import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.title,
    this.color = AppColors.grey,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
    this.decorationColor = AppColors.grey,
    this.textAlign = TextAlign.start,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.fontStyle = FontStyle.normal,
    super.key,
  });

  final String title;
  final Color color;
  final double fontSize, letterSpacing, wordSpacing;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  final Color decorationColor;
  final TextAlign textAlign;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
        fontStyle: fontStyle,
        decorationColor: decorationColor,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
    );
  }
}
