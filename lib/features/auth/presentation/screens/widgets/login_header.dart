import 'package:flutter/material.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/login_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.shield_outlined,
          size: 72,
          color: AppColors.primary,
        ),
        const SizedBox(height: 24),
        Text(
          LoginStrings.welcomeBack,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          LoginStrings.loginTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
