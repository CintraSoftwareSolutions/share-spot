import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter/services.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/home/models/parking_detail_arguments.dart';
import 'package:sharespot/features/guest/home/widgets/ai_insight_card.dart';
import 'package:sharespot/features/guest/home/widgets/destination_preference_card.dart';
import 'package:sharespot/features/guest/home/widgets/nearby_hosts_section.dart';
import 'package:sharespot/features/guest/home/widgets/nearby_rewards_section.dart';
import 'package:sharespot/features/guest/home/widgets/parking_stats_section.dart';

class ParkingInsightsScreen extends StatelessWidget {
  const ParkingInsightsScreen({super.key, this.details = defaultDetails});

  static const defaultDetails = ParkingDetailArguments(
    destinationName: 'East Village Residence',
    mapLabel: 'The Highline Hub',
    arrivalTime: 'Arrive by 6:00 PM',
    successRate: '94%',
  );

  final ParkingDetailArguments details;

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                width: context.screenWidth,
                height: 250,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      AppImages.map,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.hex33000000,
                            AppColors.hexB0101114,
                          ],
                          stops: [0, 1],
                        ),
                      ),
                    ),
                    Center(
                      child: _DestinationMarker(
                        label: details.resolvedMapLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                padding,
                20,
                padding,
                24 + context.bottomSafeArea,
              ),
              sliver: SliverList.list(
                children: [
                  DestinationPreferenceCard(
                    destinationName: details.destinationName,
                    arrivalTime: details.arrivalTime,
                  ),
                  const SizedBox(height: 25),
                  ParkingStatsSection(successRate: details.successRate),
                  const SizedBox(height: 28),
                  const NearbyHostsSection(),
                  const SizedBox(height: 28),
                  const NearbyRewardsSection(),
                  const SizedBox(height: 24),
                  const AiInsightCard(),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Finding the best parking spot...'),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.loginGreen,
                        foregroundColor: AppColors.greenInk,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                      icon: const Icon(Icons.explore_outlined, size: 20),
                      label: const Text(
                        'Find Parking',
                        style: AppTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationMarker extends StatelessWidget {
  const _DestinationMarker({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.loginGreen,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              'P',
              style: AppTextStyle(
                color: AppColors.greenInk,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.hexE6111318,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              label,
              style: const AppTextStyle(color: AppColors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
