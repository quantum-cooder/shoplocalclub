// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/authentication.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class CustomBottomSheet {
  static final _emailController = TextEditingController();
  static ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  static final _key = GlobalKey<FormState>();
  static late Size size;
  static showResendEmailVerificationBottomSheet(BuildContext context) {
    size = MediaQuery.of(context).size;
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: size.height * 0.8),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20,
        ),
        child: Form(
          key: _key,
          child: Column(
            children: [
              customBodyText('ReSend Email Verification'),
              const Gap(20),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter email',
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: (value) => emailValidator(value),
              ),
              const Gap(30),
              ValueListenableBuilder(
                valueListenable: loadingNotifier,
                builder: (context, value, child) => CustomBtn(
                  btnTitle: 'Send Code',
                  isLoading: loadingNotifier.value,
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      loadingNotifier.value = true;
                      await Authentication.reSendVerifyEmail(
                        email: _emailController.text.toLowerCase().trim(),
                      );
                      loadingNotifier.value = false;
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
