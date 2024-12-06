import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class CustomVoucher extends StatelessWidget {
  const CustomVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 172,
      padding: const EdgeInsets.only(top: 20),
      decoration: const ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x23000000),
            blurRadius: 14.92,
            offset: Offset(0, 3.92),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: AppColors.primary)),
        ),
        child: Column(
          children: [
            const CustomText(
              title: 'Voucher (Point)',
              fontSize: AppFontSize.medium,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: double.infinity,
              height: 6,
              child: ListView.builder(
                itemCount: 80,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Divider(
                  height: 2,
                  color: index.isOdd ? AppColors.primary : Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
