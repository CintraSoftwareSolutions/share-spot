import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/rewards/widgets/recent_rewards_activity.dart';

class RecentRewardsActivityScreen extends StatelessWidget {
  const RecentRewardsActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.isMobile ? 8 : 20,
                10,
                padding,
                12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    tooltip: 'Back',
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    'Recent Activity',
                    style: AppTextStyles.subheading.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(padding, 0, padding, 28),
                children: const [RecentRewardsActivity(showAll: true)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
