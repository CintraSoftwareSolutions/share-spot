import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.svgAsset,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final IconData? icon;
  final String? svgAsset;
  final VoidCallback onTap;
}

class ProfileMenuGroup extends StatelessWidget {
  const ProfileMenuGroup({
    required this.heading,
    required this.items,
    super.key,
  });

  final String heading;
  final List<ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const AppTextStyle(
              color: AppColors.hexFFD4D5D8,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.authField,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderStrong),
            ),
            child: Column(
              children: [
                for (var index = 0; index < items.length; index++)
                  _MenuRow(
                    item: items[index],
                    showDivider: index < items.length - 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.item, required this.showDivider});

  final ProfileMenuItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        constraints: BoxConstraints(minHeight: item.subtitle == null ? 52 : 61),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.hexFF292B30))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.surfaceDeep,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: item.svgAsset != null
                    ? SvgPicture.asset(
                        item.svgAsset!,
                        width: item.label == 'Privacy & Safety' ? 11 : 14,
                        height: 14,
                      )
                    : Icon(item.icon, color: AppColors.loginGreen, size: 15),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: const AppTextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      item.subtitle!,
                      style: const AppTextStyle(
                        color: AppColors.hexFFBABCC1,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.hexFFD0D1D4,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
