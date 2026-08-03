import 'package:flutter/material.dart';
import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/home/widgets/home_map_controls.dart';
import 'package:sharespot/features/guest/home/widgets/parking_home_sheet.dart';
import 'package:sharespot/features/shared/home/widgets/parking_map_pin.dart';

class ParkingHomeScreen extends StatelessWidget {
  const ParkingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
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
                        AppColors.hex20000000,
                        AppColors.transparent,
                        AppColors.hexCC101114,
                      ],
                      stops: [0, 0.48, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: context.screenWidth * 0.27,
                top: constraints.maxHeight * 0.31,
                child: const ParkingMapPin(color: AppColors.loginGreen),
              ),
              Positioned(
                right: context.screenWidth * 0.25,
                top: constraints.maxHeight * 0.24,
                child: const ParkingMapPin(
                  color: AppColors.authLink,
                  label: '↗',
                ),
              ),
              HomeMapControls(
                onNotifications: () =>
                    Navigator.pushNamed(context, AppRouteNames.notifications),
                onCurrentLocation: () =>
                    Navigator.pushNamed(context, AppRouteNames.parkingInsights),
              ),
              DraggableScrollableSheet(
                initialChildSize: context.isMobile ? 0.62 : 0.54,
                minChildSize: 0.52,
                maxChildSize: 0.92,
                snap: true,
                snapSizes: [context.isMobile ? 0.62 : 0.54, 0.92],
                builder: (context, scrollController) => ParkingHomeSheet(
                  scrollController: scrollController,
                  onViewAll: () =>
                      Navigator.pushNamed(context, AppRouteNames.waitAndDine),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
