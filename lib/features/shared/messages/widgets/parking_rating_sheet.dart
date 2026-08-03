import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class ParkingRatingSheet extends StatefulWidget {
  const ParkingRatingSheet({required this.onSubmit, super.key});

  final ValueChanged<int> onSubmit;

  @override
  State<ParkingRatingSheet> createState() => _ParkingRatingSheetState();
}

class _ParkingRatingSheetState extends State<ParkingRatingSheet> {
  final _feedbackController = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_rating == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a rating.')));
      return;
    }
    widget.onSubmit(_rating);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final contentBottomPadding = context.bottomSafeArea > 20
        ? context.bottomSafeArea
        : 20.0;
    final availableHeight =
        (context.screenHeight -
                context.keyboardHeight -
                context.safeAreaPadding.top)
            .clamp(260.0, context.screenHeight)
            .toDouble();

    return AnimatedPadding(
      duration: AppConstants.animationDuration,
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(bottom: context.keyboardHeight),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: availableHeight),
          child: Container(
            width: context.screenWidth,
            decoration: const BoxDecoration(
              color: AppColors.authField,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                context.isMobile ? 20 : 28,
                18,
                context.isMobile ? 20 : 28,
                contentBottomPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.hexFFE8FBE8,
                        child: Icon(
                          Icons.workspace_premium_outlined,
                          color: AppColors.hexFF23833C,
                          size: 19,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.hexFFC2C4C9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How was your parking experience?',
                    style: AppTextStyles.subheading.copyWith(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your feedback helps other drivers find reliable hosts.',
                    style: AppTextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Rate',
                    style: AppTextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      final value = index + 1;
                      return IconButton(
                        key: ValueKey('rating-star-$value'),
                        onPressed: () => setState(() => _rating = value),
                        padding: const EdgeInsets.only(right: 7),
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          value <= _rating
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: AppColors.loginGreen,
                          size: 25,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Write your thoughts',
                    style: AppTextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 9),
                  TextField(
                    key: const ValueKey('rating-feedback'),
                    controller: _feedbackController,
                    minLines: 3,
                    maxLines: 4,
                    style: const AppTextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Tell us more about your experience...',
                      hintStyle: const AppTextStyle(
                        color: AppColors.hexFF858891,
                        fontSize: 12.5,
                      ),
                      filled: true,
                      fillColor: AppColors.authSurface,
                      contentPadding: const EdgeInsets.all(13),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(
                          color: AppColors.authBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(
                          color: AppColors.loginGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.loginGreen,
                        foregroundColor: AppColors.authSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Submit',
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
          ),
        ),
      ),
    );
  }
}
