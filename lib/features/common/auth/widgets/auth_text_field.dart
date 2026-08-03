import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.onTap,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const AppTextStyle(
            color: AppColors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.isCompactHeight ? 5 : 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          readOnly: readOnly,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          autocorrect: false,
          style: const AppTextStyle(color: AppColors.white),
          cursorColor: AppColors.loginGreen,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const AppTextStyle(color: AppColors.hexFF858993),
            filled: true,
            fillColor: AppColors.authField,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorMaxLines: 1,
            errorStyle: const AppTextStyle(
              color: AppColors.redAccent,
              fontSize: 10,
              height: 1,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: context.isCompactHeight ? 6 : 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.authBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.authBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.loginGreen,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
