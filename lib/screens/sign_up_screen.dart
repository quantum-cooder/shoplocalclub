import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController,
      _emailController,
      _pwdController,
      _confirmPwdController,
      _countryIdController,
      _zipCodeController;

  late FocusNode _nameFocusNode,
      _emailFocusNode,
      _pwdFocusNode,
      _confirmPwdControllerFocusNode,
      _countryIdFocusNode,
      _zipCodeFocusNode;

  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<bool> _passwordLoadingNotifier,
      _confirmPasswordLoadingNotifier,
      _buttonLoadingNotifier,
      _checkBoxNotifier;

  final String termsAndCondition =
      'https://shoplocalclubcard.com/terms-conditions/';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Tester');
    _emailController = TextEditingController(text: 'tester99@gmail.com');
    _pwdController = TextEditingController(text: '12345678');
    _confirmPwdController = TextEditingController(text: '12345678');
    _countryIdController = TextEditingController(text: 'United Kingdom');
    _zipCodeController = TextEditingController(text: '345623');
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _pwdFocusNode = FocusNode();
    _confirmPwdControllerFocusNode = FocusNode();
    _countryIdFocusNode = FocusNode();
    _zipCodeFocusNode = FocusNode();
    _passwordLoadingNotifier = ValueNotifier(true);
    _confirmPasswordLoadingNotifier = ValueNotifier(true);
    _buttonLoadingNotifier = ValueNotifier(false);
    _checkBoxNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _confirmPwdController.dispose();
    _countryIdController.dispose();
    _zipCodeController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _pwdFocusNode.dispose();
    _confirmPwdControllerFocusNode.dispose();
    _countryIdFocusNode.dispose();
    _zipCodeFocusNode.dispose();
    _passwordLoadingNotifier.dispose();
    _confirmPasswordLoadingNotifier.dispose();
    _buttonLoadingNotifier.dispose();
    _checkBoxNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isIconNeeded: false,
        title: 'SignUp',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                const CustomText(
                  title: 'Name',
                ),
                const Gap(3),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'your name',
                  keyboardType: TextInputType.name,
                  focusNode: _nameFocusNode,
                  autofillHints: const [AutofillHints.name],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(_emailFocusNode),
                  validator: (value) => nameValidator(value),
                  prefixIcon: const Icon(
                    Icons.person_outline_sharp,
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
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(_pwdFocusNode),
                  validator: (value) => emailValidator(value),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Password',
                ),
                const Gap(3),
                ValueListenableBuilder<bool>(
                  valueListenable: _passwordLoadingNotifier,
                  builder: (context, isLoading, child) => CustomTextField(
                    controller: _pwdController,
                    hintText: 'your password',
                    keyboardType: TextInputType.visiblePassword,
                    isObscuredText: isLoading,
                    focusNode: _pwdFocusNode,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.next,
                    validator: (value) => passwordValidator(value),
                    onFieldSubmitted: (p0) => FocusScope.of(context)
                        .requestFocus(_confirmPwdControllerFocusNode),
                    prefixIcon: const Icon(
                      Icons.password_rounded,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        _passwordLoadingNotifier.value = !isLoading;
                      },
                      child: Icon(
                        isLoading
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Confirm Password',
                ),
                const Gap(3),
                ValueListenableBuilder<bool>(
                  valueListenable: _confirmPasswordLoadingNotifier,
                  builder: (context, isLoading, child) => CustomTextField(
                    controller: _confirmPwdController,
                    hintText: 'Retype password',
                    keyboardType: TextInputType.visiblePassword,
                    isObscuredText: isLoading,
                    focusNode: _confirmPwdControllerFocusNode,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.next,
                    validator: (value) => confirmPasswordValidator(
                        _pwdController.text, _confirmPwdController.text),
                    onFieldSubmitted: (p0) => FocusScope.of(context)
                        .requestFocus(_countryIdFocusNode),
                    prefixIcon: const Icon(
                      Icons.password_rounded,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        _confirmPasswordLoadingNotifier.value = !isLoading;
                      },
                      child: Icon(
                        isLoading
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Country Id',
                ),
                const Gap(3),
                DropdownButtonFormField(
                  items: getDropdownCountries(),
                  value: AllCountries.list.first,
                  onChanged: (value) {
                    _countryIdController.text = value as String;
                    FocusScope.of(context).requestFocus(_zipCodeFocusNode);
                  },
                  focusNode: _countryIdFocusNode,
                  validator: (value) =>
                      valueNotSelectedValidator(value as String),
                  hint: const CustomText(
                    title: '    Select country',
                    fontWeight: FontWeight.w400,
                    fontSize: AppFontSize.small,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    constraints: const BoxConstraints(maxHeight: 50),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Post/Zip Code',
                ),
                const Gap(3),
                CustomTextField(
                  controller: _zipCodeController,
                  hintText: 'Postal/Zip code',
                  keyboardType: TextInputType.number,
                  focusNode: _zipCodeFocusNode,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.postalCode],
                  validator: (value) => valueNotSelectedValidator(value),
                  onFieldSubmitted: (p0) => _zipCodeFocusNode.unfocus(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                  ),
                ),
                const Gap(5),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _checkBoxNotifier,
                      builder: (context, value, child) => Checkbox.adaptive(
                        value: value,
                        onChanged: (value) {
                          _checkBoxNotifier.value = value!;
                        },
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'I have read and accept ',
                            style: Theme.of(context).textTheme.labelLarge,
                            children: [
                              TextSpan(
                                text: 'terms and conditions',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await openUrl(termsAndCondition);
                                  },
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                ValueListenableBuilder<bool>(
                  valueListenable: _buttonLoadingNotifier,
                  builder: (context, isLoading, child) => CustomBtn(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      FocusScope.of(context).unfocus();
                      if (_checkBoxNotifier.value) {
                        _buttonLoadingNotifier.value = true;
                        await Authentication.signUp(
                          RegisterUserModel(
                            name: _nameController.text.trim(),
                            email: _emailController.text.toLowerCase().trim(),
                            password: _pwdController.text.trim(),
                            confirmPassword: _confirmPwdController.text.trim(),
                            countryId: AllCountries.getCounrtyId(
                                _countryIdController.text.trim()),
                            zipCode: _zipCodeController.text.trim(),
                          ),
                          context,
                        );
                        _buttonLoadingNotifier.value = false;
                      } else {
                        showToast(
                          toastMsg:
                              'Please confirm that you have read terms & conditions',
                        );
                      }
                    },
                    btnTitle: 'Create Account',
                    isLoading: isLoading,
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      title: 'Already have an account? ',
                      fontSize: AppFontSize.small,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const CustomText(
                        title: 'Sign in',
                        fontSize: AppFontSize.small,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Object>>? getDropdownCountries() {
    return AllCountries.list
        .map(
          (country) => DropdownMenuItem<Object>(
            value: country,
            alignment: Alignment.center,
            child: CustomText(title: country),
          ),
        )
        .toList();
  }
}
