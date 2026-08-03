import 'package:flutter/material.dart';

import 'package:sharespot/core/theme/app_text_styles.dart';

/// A single-line auth action label that always paints the complete wording.
class AuthButtonLabel extends StatelessWidget {
  const AuthButtonLabel(
    this.label, {
    super.key,
    this.style = AppTextStyles.authButtonLabel,
  });

  final String label;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        label,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
