import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';

class CustomFilledBtn extends StatelessWidget {
  const CustomFilledBtn({
    super.key,
    required this.assetImage,
    required this.onPressed,
    this.btnBackgroundColor = AppColors.white,
    this.elevation = 3,
    this.width = 45,
    this.height = 45,
    this.childHeight = 25,
    this.childWidth = 25,
  });

  final VoidCallback onPressed;
  final Color btnBackgroundColor;
  final double? width, height, elevation, childWidth, childHeight;
  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(btnBackgroundColor),
          elevation: WidgetStateProperty.all(elevation),
        ),
        onPressed: onPressed,
        child: Image.asset(
          assetImage,
          fit: BoxFit.cover,
          width: childWidth,
          height: childHeight,
        ),
      ),
    );
  }
}
