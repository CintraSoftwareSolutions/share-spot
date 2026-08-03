import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/home/widgets/home_map_controls.dart';
import 'package:sharespot/features/shared/home/widgets/parking_map_pin.dart';
import 'package:sharespot/features/host/home/widgets/host_home_sheet.dart';

class HostHomeScreen extends StatelessWidget {
  const HostHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.map,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                filterQuality: FilterQuality.medium,
              ),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.hex30000000,
                      AppColors.transparent,
                      AppColors.hexD9101114,
                    ],
                    stops: [0, 0.48, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              left: context.screenWidth * 0.28,
              top: constraints.maxHeight * 0.30,
              child: const ParkingMapPin(color: AppColors.loginGreen),
            ),
            Positioned(
              right: context.screenWidth * 0.25,
              top: constraints.maxHeight * 0.22,
              child: const ParkingMapPin(color: AppColors.authLink, label: '+'),
            ),
            HomeMapControls(
              points: '3,250 pts',
              hintText: 'Share your parking spot',
              showFilters: false,
              onNotifications: () =>
                  Navigator.pushNamed(context, AppRouteNames.hostNotifications),
              onCurrentLocation: () =>
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Current location selected.')),
                  ),
            ),
            DraggableScrollableSheet(
              initialChildSize: context.isMobile ? 0.59 : 0.54,
              minChildSize: 0.52,
              maxChildSize: 0.94,
              snap: true,
              snapSizes: [context.isMobile ? 0.59 : 0.54, 0.94],
              builder: (context, controller) => HostHomeSheet(
                scrollController: controller,
                onViewAll: () =>
                    Navigator.pushNamed(context, AppRouteNames.hostWaitAndDine),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
