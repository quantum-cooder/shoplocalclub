import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.btnTitle,
    required this.onPressed,
    this.btnBackgroundColor = AppColors.btnColor,
    this.btnTxtColor = AppColors.white,
    this.fontSize = AppFontSize.small,
    this.fontWeight = FontWeight.w700,
    this.width = double.infinity,
    this.isLoading = false,
  });

  final String btnTitle;
  final VoidCallback onPressed;
  final FontWeight fontWeight;
  final Color btnTxtColor;
  final Gradient btnBackgroundColor;
  final double? fontSize, width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 45,
        decoration: BoxDecoration(
          gradient: btnBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: isLoading
              ? const CupertinoActivityIndicator(color: AppColors.white)
              : CustomText(
                  title: btnTitle,
                  color: btnTxtColor,
                  fontSize: fontSize!,
                  fontWeight: fontWeight,
                ),
        ),
      ),
    );
  }
}
