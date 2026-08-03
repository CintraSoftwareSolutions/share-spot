import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class HomeMapControls extends StatelessWidget {
  const HomeMapControls({
    required this.onNotifications,
    required this.onCurrentLocation,
    super.key,
    this.points = '2,450 pts',
    this.hintText = 'Where do you need parking?',
    this.showFilters = true,
  });

  final VoidCallback onNotifications;
  final VoidCallback onCurrentLocation;
  final String points;
  final String hintText;
  final bool showFilters;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.isMobile ? 16 : 28,
          8,
          context.isMobile ? 16 : 28,
          0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 21,
                  backgroundImage: AssetImage(AppImages.profile),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.hexCC191B20,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.authBorder),
                  ),
                  child: Text(
                    points,
                    style: const AppTextStyle(
                      color: AppColors.loginGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton.filledTonal(
                  key: const ValueKey('home-notifications-button'),
                  onPressed: onNotifications,
                  tooltip: 'Notifications',
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.hexCC191B20,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size.square(46),
                  ),
                  icon: SvgPicture.asset(
                    AppImages.notificationBell,
                    width: 23,
                    height: 23,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: const AppTextStyle(color: AppColors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const AppTextStyle(
                  color: AppColors.textMuted,
                  fontSize: 15,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.white70,
                  size: 22,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 112,
                  minHeight: 54,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 1,
                      height: 26,
                      color: AppColors.hexFF3A3D45,
                    ),
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Voice search',
                      constraints: const BoxConstraints.tightFor(
                        width: 44,
                        height: 44,
                      ),
                      icon: SvgPicture.asset(
                        AppImages.microphone,
                        width: 22,
                        height: 22,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 7),
                      decoration: const BoxDecoration(
                        color: AppColors.loginGreen,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: onCurrentLocation,
                        tooltip: 'Use current location',
                        padding: const EdgeInsets.all(10),
                        icon: SvgPicture.asset(
                          AppImages.locateFixed,
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ),
                  ],
                ),
                filled: true,
                fillColor: AppColors.hexE6191B20,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(29),
                  borderSide: const BorderSide(color: AppColors.authBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(29),
                  borderSide: const BorderSide(color: AppColors.authBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(29),
                  borderSide: const BorderSide(color: AppColors.loginGreen),
                ),
              ),
            ),
            if (showFilters) ...[
              const SizedBox(height: 10),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _MapFilterChip(icon: Icons.home_outlined, label: 'Home'),
                    _MapFilterChip(
                      icon: Icons.work_outline_rounded,
                      label: 'Work',
                    ),
                    _MapFilterChip(
                      icon: Icons.shopping_bag_outlined,
                      label: 'Shopping',
                    ),
                    _MapFilterChip(
                      icon: Icons.local_hospital_outlined,
                      label: 'Crowd',
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MapFilterChip extends StatelessWidget {
  const _MapFilterChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.hexDF191B20,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white, size: context.isMobile ? 17 : 19),
          const SizedBox(width: 6),
          Text(
            label,
            style: const AppTextStyle(color: AppColors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
