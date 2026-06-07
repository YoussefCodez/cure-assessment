import 'package:flutter/material.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/signup_strings.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.person_add_alt_1_outlined,
          size: 72,
          color: AppColors.primary,
        ),
        const SizedBox(height: 24),
        Text(
          SignupStrings.createAccount,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          SignupStrings.signUpTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
