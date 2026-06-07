import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_colors.dart';
import '../../../domain/entities/user_entity.dart';
import '../../view_model/auth_cubit.dart';

class UserProfileCard extends StatelessWidget {
  final UserEntity user;

  const UserProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primaryLight.withAlpha(50),
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
              style: const TextStyle(
                fontSize: 36,
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            user.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error, width: 1.5),
              elevation: 0,
              minimumSize: const Size(double.infinity, 54),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
