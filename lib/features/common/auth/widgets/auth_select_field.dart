import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';

class AuthSelectField extends StatelessWidget {
  const AuthSelectField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const AppTextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: context.isCompactHeight ? 5 : 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          dropdownColor: AppColors.authField,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.iconMuted,
          ),
          style: const AppTextStyle(color: AppColors.white, fontSize: 13),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.authField,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: context.isCompactHeight ? 8 : 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: AppColors.authBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: AppColors.authBorder),
            ),
          ),
          items: [
            for (final item in items)
              DropdownMenuItem(value: item, child: Text(item)),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
