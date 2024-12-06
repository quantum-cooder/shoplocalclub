import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoplocalclubcard/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.isTabAble = true,
    this.focusNode,
    this.isObscuredText = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.contentPadding,
    this.fillColor = AppColors.white,
    this.filled = true,
    this.prefixIcon,
    this.prefixIconColor = AppColors.grey,
    this.suffixIcon,
    this.suffixIconColor = AppColors.grey,
    required this.hintText,
    this.prefixIconConstraints,
    this.textInputAction,
    this.validator,
    this.autofillHints,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool isTabAble, isObscuredText, filled, readOnly;
  final FocusNode? focusNode;
  final Function(String)? onChanged, onFieldSubmitted;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final EdgeInsets? contentPadding;
  final Color fillColor, prefixIconColor, suffixIconColor;
  final Widget? prefixIcon, suffixIcon;
  final String hintText;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final BoxConstraints? prefixIconConstraints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatters,
      enabled: isTabAble,
      focusNode: focusNode,
      obscureText: isObscuredText,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: textAlign,
      autofillHints: autofillHints,
      textAlignVertical: textAlignVertical,
      textInputAction: textInputAction,
      readOnly: readOnly,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        fillColor: fillColor,
        filled: filled,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        prefixIconConstraints: prefixIconConstraints,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: AppFontSize.small,
          color: AppColors.grey,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }
}
