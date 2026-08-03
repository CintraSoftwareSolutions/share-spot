import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/theme/app_colors.dart';

class ProfileSelectField extends StatelessWidget {
  const ProfileSelectField({
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
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          dropdownColor: AppColors.authField,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.iconMuted,
            size: 20,
          ),
          style: const AppTextStyle(
            color: AppColors.hexFFE8E8EA,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.authField,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(color: AppColors.loginGreen),
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

  OutlineInputBorder _border({Color color = AppColors.authBorder}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color),
    );
  }
}
