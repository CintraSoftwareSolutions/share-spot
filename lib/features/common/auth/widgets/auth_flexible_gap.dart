import 'package:flutter/material.dart';

/// Keeps the requested auth-screen spacing when room is available and
/// proportionally contracts it before fixed content can overflow.
class AuthFlexibleGap extends StatelessWidget {
  const AuthFlexibleGap({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    if (height <= 0) return const SizedBox.shrink();

    return Flexible(
      flex: height.round().clamp(1, 100),
      fit: FlexFit.loose,
      child: SizedBox(height: height),
    );
  }
}
