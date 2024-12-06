import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class LocationCongrulationScreen extends StatelessWidget {
  const LocationCongrulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isIconNeeded: false,
        leadingColor: AppColors.primary,
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Image.asset(
              AppImages.congratulationsImage,
              fit: BoxFit.cover,
            ),
            const Gap(30),
            const CustomText(
              title: 'Congratulation',
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.xxmedium,
            ),
            const CustomText(
              title: 'Welcome to our loyalty Link',
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
              fontSize: AppFontSize.xsmall,
              textAlign: TextAlign.center,
            ),
            const Gap(40),
            CustomBtn(
              btnTitle: 'Go to Homepage',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.customBottomNavigation,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
