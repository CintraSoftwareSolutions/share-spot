import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/features/shared/home/models/parking_detail_arguments.dart';
import 'package:sharespot/features/shared/profile/models/favorite_location.dart';
import 'package:sharespot/features/guest/profile/providers/profile_provider.dart';
import 'package:sharespot/features/shared/profile/widgets/favorite_location_card.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_page_scaffold.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = context.select<ProfileProvider, List<FavoriteLocation>>(
      (provider) => provider.favoriteLocations,
    );
    final padding = context.isMobile ? 20.0 : 32.0;
    return ProfilePageScaffold(
      title: 'Favorites',
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(padding, 14, padding, 24),
        itemCount: locations.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final location = locations[index];
          return FavoriteLocationCard(
            location: location,
            onTap: () => Navigator.pushNamed(
              context,
              AppRouteNames.parkingInsights,
              arguments: ParkingDetailArguments(
                destinationName: location.name,
                arrivalTime: location.arrivalTime,
                successRate: location.reliability,
              ),
            ),
          );
        },
      ),
    );
  }
}
