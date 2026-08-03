import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/messages/models/chat_conversation.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    required this.conversation,
    required this.onTap,
    super.key,
  });

  final ChatConversation conversation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.authField,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.authBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            conversation.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const AppTextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${conversation.rating}',
                          style: const AppTextStyle(
                            color: AppColors.hexFFC6C8CE,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.loginGreen,
                          size: 12,
                        ),
                        if (conversation.isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColors.loginGreen,
                            size: 12,
                          ),
                        ],
                        const Spacer(),
                        Text(
                          conversation.time,
                          style: const AppTextStyle(
                            color: AppColors.hexFFA8ABB2,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      conversation.preview,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const AppTextStyle(
                        color: AppColors.hexFFE0E1E4,
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: conversation.isCompleted
                                ? AppColors.hexFF292B30
                                : AppColors.hexFF15341F,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            conversation.status,
                            style: AppTextStyle(
                              color: conversation.isCompleted
                                  ? AppColors.hexFFC5C6CA
                                  : AppColors.loginGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          conversation.isCompleted
                              ? Icons.workspace_premium_outlined
                              : Icons.near_me_outlined,
                          color: AppColors.hexFFA8ABB2,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            conversation.meta,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const AppTextStyle(
                              color: AppColors.hexFFA8ABB2,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
