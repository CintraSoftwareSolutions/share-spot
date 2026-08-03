import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';

class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    required this.child,
    super.key,
    this.maxWidth = AppConstants.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: context.pagePadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
