import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/theme/app_colors.dart';

class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    required this.label,
    required this.controller,
    super.key,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.onFieldSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;

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
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          readOnly: readOnly,
          validator: validator,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          autocorrect: false,
          style: const AppTextStyle(
            color: AppColors.hexFFE8E8EA,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const AppTextStyle(
              color: AppColors.hexFF878990,
              fontSize: 13,
            ),
            filled: true,
            fillColor: AppColors.authField,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: true,
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            border: _border(AppColors.authBorder),
            enabledBorder: _border(AppColors.authBorder),
            focusedBorder: _border(AppColors.loginGreen, width: 1.3),
            errorBorder: _border(AppColors.redAccent),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
