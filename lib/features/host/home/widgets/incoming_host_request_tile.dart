import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/host/home/models/incoming_host_request.dart';

class IncomingHostRequestTile extends StatelessWidget {
  const IncomingHostRequestTile({required this.request, super.key});

  final IncomingHostRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppImages.profile),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.name,
                  style: const AppTextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.loginGreen,
                      size: 14,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        '${request.rating}  ${request.distance}',
                        softWrap: true,
                        style: const AppTextStyle(
                          color: AppColors.textSoft,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${request.match}% Match',
            style: const AppTextStyle(
              color: AppColors.loginGreen,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
