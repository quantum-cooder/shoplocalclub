import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.isIconNeeded = true,
    this.leadingWidget,
    this.titleColor = AppColors.white,
    this.backgroundColor = AppColors.primary,
    this.leadingColor = AppColors.white,
    this.leadingWidth = 56,
    this.actionPaddingFromRight = 0,
    // this.actionOnPressed,
    this.actionIconColor = AppColors.white,
    this.isLeadingNeeded = true,
  });

  final String title;
  final bool isIconNeeded, isLeadingNeeded;
  final Color titleColor, backgroundColor, leadingColor, actionIconColor;
  final Widget? leadingWidget;
  final double leadingWidth;
  final double actionPaddingFromRight;
  // final void Function()? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: leadingWidget ??
          (isLeadingNeeded
              ? BackButton(
                  color: leadingColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const SizedBox.shrink()),
      leadingWidth: leadingWidth,
      title: CustomText(
        title: title,
        fontSize: AppFontSize.medium,
        fontWeight: FontWeight.w700,
        color: titleColor,
      ),
      actions: isIconNeeded
          ? [
              Padding(
                padding: EdgeInsets.only(right: actionPaddingFromRight),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_on_outlined,
                    color: actionIconColor,
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
