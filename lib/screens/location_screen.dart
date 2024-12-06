// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// For reverse geocoding
// For sending data to server
import 'package:shoplocalclubcard/apis/apis.dart';
// For json encoding
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late ValueNotifier<bool> isCheckingPosition;

  @override
  void initState() {
    super.initState();
    isCheckingPosition = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();
    isCheckingPosition.dispose();
  }

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
              AppImages.locationImage,
              fit: BoxFit.cover,
            ),
            const Gap(30),
            const CustomText(
              title: 'Enable Location',
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.xxmedium,
            ),
            const CustomText(
              title:
                  'By allowing location you are able to explore AR experiences from your friends.',
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
              fontSize: AppFontSize.xsmall,
              textAlign: TextAlign.center,
            ),
            const Gap(40),
            ValueListenableBuilder(
              valueListenable: isCheckingPosition,
              builder: (context, value, child) => CustomBtn(
                btnTitle: 'Allow',
                isLoading: value,
                onPressed: () async {
                  isCheckingPosition.value = true;
                  final position = await LocationApi.getPosition();
                  if (position != null) {
                    await LocationApi.updateLocationDetails(position);
                  }
                  isCheckingPosition.value = false;
                  Navigator.pushNamed(
                    context,
                    AppRoutes.locationCongratulation,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
