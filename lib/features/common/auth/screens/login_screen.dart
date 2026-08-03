import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientAuthScaffold(
      headerFraction: context.isCompactHeight ? 0.2 : 0.3,
      topPadding: context.isCompactHeight ? 24 : 30,
      child: const LoginForm(),
    );
  }
}
