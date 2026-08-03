import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    required this.time,
    required this.isMine,
    super.key,
  });

  final String message;
  final String time;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.screenWidth * 0.65),
        child: Column(
          crossAxisAlignment: isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.authField,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: AppColors.authBorder),
              ),
              child: Text(
                message,
                style: const AppTextStyle(
                  color: AppColors.hexFFF2F2F3,
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const AppTextStyle(
                color: AppColors.hexFF8F9299,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
