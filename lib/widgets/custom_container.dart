import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.width = 88,
    this.height = 90,
    required this.avatarBgColor,
    required this.imageAsset,
    required this.containerTitle,
    required this.index,
    this.isBadgeNeeded = false,
  });

  final double width, height;
  final Color avatarBgColor;
  final String imageAsset, containerTitle;
  final int index;
  final bool isBadgeNeeded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.grey.withOpacity(0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 25,
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
                FittedBox(
                  child: CustomText(
                    title: containerTitle,
                    fontSize: AppFontSize.xxsmall,
                  ),
                ),
              ],
            ),
          ),
          if (isBadgeNeeded)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 25,
                height: 15,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: CustomText(
                  title: index.toString(),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFA7004D),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
