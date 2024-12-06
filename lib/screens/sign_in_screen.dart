import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static late Size size;
  late TextEditingController _emailController, _pwdController;
  late FocusNode _emailFocusNode, _pwdFocusNode;
  late ValueNotifier<List<bool>> loadingNotifier;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: 'freddy@shoplocalclubcard.com');
    _pwdController = TextEditingController(text: 'wicwet-6wozja-gaqniD');
    _emailFocusNode = FocusNode();
    _pwdFocusNode = FocusNode();
    loadingNotifier = ValueNotifier([false, true]);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _emailFocusNode.dispose();
    _pwdFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Form(
            key: _key,
            child: Column(
              children: [
                const Gap(40),
                Center(
                  child: Image.asset(
                    AppImages.signInImage,
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
                            title: 'Sign In',
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.xxmedium,
                          ),
                        ),
                        const Center(
                          child: CustomText(
                            title: 'Sign in to Continue',
                            color: AppColors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFontSize.xsmall,
                          ),
                        ),
                        const Gap(10),
                        const CustomText(
                          title: 'Email',
                        ),
                        const Gap(3),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'your email',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: _emailFocusNode,
                          validator: (value) => emailValidator(value),
                          autofillHints: const [AutofillHints.email],
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          onFieldSubmitted: (p0) => FocusScope.of(context)
                              .requestFocus(_pwdFocusNode),
                        ),
                        const Gap(10),
                        const CustomText(
                          title: 'Password',
                        ),
                        const Gap(3),
                        ValueListenableBuilder(
                          valueListenable: loadingNotifier,
                          builder: (context, value, child) => CustomTextField(
                            controller: _pwdController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'your password',
                            isObscuredText: loadingNotifier.value[1],
                            validator: (value) => passwordValidator(value),
                            autofillHints: const [AutofillHints.password],
                            focusNode: _pwdFocusNode,
                            onFieldSubmitted: (p0) => _pwdFocusNode.unfocus(),
                            prefixIcon: const Icon(
                              Icons.password_outlined,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                loadingNotifier.value = [
                                  loadingNotifier.value[0],
                                  !loadingNotifier.value[1],
                                ];
                              },
                              child: Icon(
                                value[1]
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.pwdResetByLink,
                              );
                            },
                            child: const CustomText(
                              title: 'Forgot Password?',
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const Gap(30),
                        ValueListenableBuilder(
                          valueListenable: loadingNotifier,
                          builder: (context, value, child) => CustomBtn(
                            btnTitle: 'Sign In',
                            isLoading: loadingNotifier.value.first,
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                loadingNotifier.value = [
                                  true,
                                  loadingNotifier.value[1]
                                ];
                                await Authentication.login(
                                  email: _emailController.text
                                      .toLowerCase()
                                      .trim(),
                                  password: _pwdController.text.trim(),
                                  context: context,
                                );
                                loadingNotifier.value = [
                                  false,
                                  loadingNotifier.value[1],
                                ];
                              }
                            },
                          ),
                        ),
                        const Gap(40),
                        // const Expanded(child: SizedBox()),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Expanded(
                        //       child: Divider(
                        //         endIndent: 10,
                        //         indent: 10,
                        //       ),
                        //     ),
                        //     CustomText(title: 'or sign in with'),
                        //     Expanded(
                        //       child: Divider(
                        //         endIndent: 10,
                        //         indent: 10,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Gap(20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     CustomFilledBtn(
                        //       assetImage: AppImages.googleLogo,
                        //       onPressed: () {},
                        //     ),
                        //     const Gap(15),
                        //     CustomFilledBtn(
                        //       assetImage: AppImages.appleLogo,
                        //       onPressed: () {},
                        //     ),
                        //     const Gap(15),
                        //     CustomFilledBtn(
                        //       assetImage: AppImages.facebookLogo,
                        //       onPressed: () {},
                        //     ),
                        //   ],
                        // ),
                        // const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CustomText(
                              title: 'Don\'t have an account ?',
                            ),
                            const Gap(8),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.signUp,
                                );
                              },
                              child: const CustomText(
                                title: 'Sign Up',
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const Gap(20),
                        InkWell(
                          onTap: () async {
                            await CustomBottomSheet
                                .showResendEmailVerificationBottomSheet(
                                    context);
                          },
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: CustomText(
                              title: 'Resend verification',
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              textDecoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
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
