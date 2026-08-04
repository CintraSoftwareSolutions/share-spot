import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';

class ParkingMapPin extends StatelessWidget {
  const ParkingMapPin({required this.color, super.key, this.label = 'P'});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = context.isMobile ? 38.0 : 44.0;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: const [
          BoxShadow(color: AppColors.black45, blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: Text(
        label,
        style: const AppTextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
