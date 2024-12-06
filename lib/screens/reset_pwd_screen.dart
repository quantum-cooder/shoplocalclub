import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/authentication.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ResetPwdScreen extends StatefulWidget {
  const ResetPwdScreen({
    super.key,
    required this.email,
    required this.token,
  });

  final String email;
  final String token;
  @override
  State<ResetPwdScreen> createState() => _ResetPwdScreenState();
}

class _ResetPwdScreenState extends State<ResetPwdScreen> {
  static late Size size;
  late TextEditingController _newPwdController, _confirmPwdController;
  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<bool> loadingNotifier;

  @override
  void initState() {
    super.initState();
    _newPwdController = TextEditingController();
    _confirmPwdController = TextEditingController();
    loadingNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();
    _newPwdController.dispose();
    _confirmPwdController.dispose();
    loadingNotifier.dispose();
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
          child: Form(
            key: _formKey,
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
                            title: 'Reset Password',
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.xxmedium,
                          ),
                        ),
                        const Gap(10),
                        const Center(
                          child: CustomText(
                            title:
                                'Please add new password and confirm password',
                            color: AppColors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFontSize.xsmall,
                          ),
                        ),
                        const Gap(20),
                        const CustomText(
                          title: 'Password',
                        ),
                        const Gap(3),
                        CustomTextField(
                          controller: _newPwdController,
                          hintText: 'new password',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => passwordValidator(value),
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                          ),
                        ),
                        const Gap(20),
                        const CustomText(
                          title: 'Confirm password',
                        ),
                        const Gap(3),
                        CustomTextField(
                          controller: _confirmPwdController,
                          hintText: 'confirm password',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => confirmPasswordValidator(
                              _newPwdController.text,
                              _confirmPwdController.text),
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                          ),
                        ),
                        const Gap(30),
                        ValueListenableBuilder(
                          valueListenable: loadingNotifier,
                          builder: (context, value, child) => CustomBtn(
                            btnTitle: 'Change Password',
                            width: double.infinity,
                            isLoading: loadingNotifier.value,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                loadingNotifier.value = true;
                                await Authentication.resetPassword(
                                  email: widget.email,
                                  password: _newPwdController.text.trim(),
                                  confirmPassword:
                                      _confirmPwdController.text.trim(),
                                  token: widget.token,
                                );
                                loadingNotifier.value = false;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
