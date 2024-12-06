import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ResetPwdByLink extends StatefulWidget {
  const ResetPwdByLink({super.key});

  @override
  State<ResetPwdByLink> createState() => _ResetPwdByLinkState();
}

class _ResetPwdByLinkState extends State<ResetPwdByLink> {
  static late Size size;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const CustomAppBar(
        isIconNeeded: false,
        leadingColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  AppImages.forgotImage,
                  fit: BoxFit.fitHeight,
                  height: size.height * 0.25,
                  width: double.infinity,
                ),
              ),
              const Gap(5),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                  ),
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CustomText(
                          title: 'Forgot Password',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.xxmedium,
                        ),
                      ),
                      const Center(
                        child: CustomText(
                          title:
                              'We need your registration Email account to send you reset password code',
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.xsmall,
                        ),
                      ),
                      const Gap(20),
                      const CustomText(
                        title: 'Email',
                      ),
                      const Gap(3),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'your email',
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      const Gap(30),
                      CustomBtn(
                        btnTitle: 'Confirm Email',
                        onPressed: () async {
                          await Authentication.forgotPassword(
                            email: _emailController.text.trim(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
