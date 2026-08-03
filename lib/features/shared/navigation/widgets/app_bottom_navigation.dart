import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _items = [
    (AppImages.homeNav, 'Home'),
    (AppImages.activityNav, 'Activity'),
    (AppImages.rewardsNav, 'Rewards'),
    (AppImages.messagesNav, 'Messages'),
    ('', 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationHeight = (context.screenHeight * 0.085)
        .clamp(70.0, 82.0)
        .toDouble();

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surfaceDeep,
        border: Border(top: BorderSide(color: AppColors.authBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: navigationHeight,
          child: Row(
            children: [
              for (var index = 0; index < _items.length; index++)
                Expanded(
                  child: _NavigationDestination(
                    asset: _items[index].$1,
                    label: _items[index].$2,
                    selected: selectedIndex == index,
                    isProfile: index == 4,
                    onTap: () => onSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationDestination extends StatelessWidget {
  const _NavigationDestination({
    required this.asset,
    required this.label,
    required this.selected,
    required this.isProfile,
    required this.onTap,
  });

  final String asset;
  final String label;
  final bool selected;
  final bool isProfile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.authLink : AppColors.hexFFE5E5E5;
    final iconSize = context.isMobile ? 24.0 : 27.0;

    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: InkResponse(
        onTap: onTap,
        radius: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isProfile)
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: selected ? 2 : 1),
                  image: const DecorationImage(
                    image: AssetImage(AppImages.profile),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              SvgPicture.asset(
                asset,
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            const SizedBox(height: 5),
            Text(
              label,
              maxLines: 1,
              style: AppTextStyle(
                color: color,
                fontSize: context.isMobile ? 11 : 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
