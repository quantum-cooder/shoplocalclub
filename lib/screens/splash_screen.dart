// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  @override
  void initState() {
    getToken();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          // AppRoutes.location,
          token == null ? AppRoutes.signIn : AppRoutes.customBottomNavigation,
          (route) => false,
        );
      },
    );
    super.initState();
  }

  Future<String?> getToken() async {
    token = await UserApiToken.getToken();
    log('Token: ${token ?? 'null'}');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          children: [
            const Gap(150),
            Image.asset(
              AppImages.whiteLogo,
            ),
            const Gap(150),
            const CustomText(
              title: 'Working in your community',
              fontSize: AppFontSize.xmedium,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontStyle: FontStyle.italic,
            ),

            // const Gap(10),
            // Align(
            //   alignment: Alignment.center,
            //   child: CustomBtn(
            //       btnTitle: 'Let\'s get started',
            //       btnTxtColor: AppColors.primary,
            //       btnBackgroundColor: const LinearGradient(
            //         colors: [Colors.white, Colors.white],
            //       ),
            //       onPressed: () {
            //         Navigator.pushNamed(
            //           context,
            //           AppRoutes.signUp,
            //         );
            //       }),
            // ),
            // const Gap(20),
            // Padding(
            //   padding: EdgeInsets.only(
            //     left: size.width * 0.3,
            //   ),
            //   child: Row(
            //     children: [
            //       const CustomText(title: 'Already have an account?'),
            //       const Gap(5),
            //       InkWell(
            //         onTap: () {
            //           Navigator.pushNamed(
            //             context,
            //             AppRoutes.signIn,
            //           );
            //         },
            //         child: const CustomText(
            //           title: 'login',
            //           fontSize: AppFontSize.medium,
            //           fontWeight: FontWeight.w400,
            //           textDecoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
