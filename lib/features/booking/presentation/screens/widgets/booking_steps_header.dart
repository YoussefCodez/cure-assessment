import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';
import 'package:cure/core/booking_strings.dart';

class BookingStepsHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const BookingStepsHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          BookingStrings.bookingScreenTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: List.generate(totalSteps * 2 - 1, (index) {
            if (index.isOdd) {
              final isPassed = (index ~/ 2) < currentStep;
              return Expanded(
                child: Container(
                  height: 3.h,
                  color: isPassed ? AppColors.primary : AppColors.border,
                ),
              );
            } else {
              final stepIndex = index ~/ 2;
              final isCurrent = stepIndex == currentStep;
              final isPassed = stepIndex < currentStep;
              return Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent
                      ? AppColors.primary
                      : (isPassed
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.surface),
                  border: Border.all(
                    color: isCurrent || isPassed
                        ? AppColors.primary
                        : AppColors.border,
                    width: 2.w,
                  ),
                ),
                child: Center(
                  child: isPassed
                      ? Icon(Icons.check, color: AppColors.primary, size: 16.r)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isCurrent
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                ),
              );
            }
          }),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              BookingStrings.bookingStepSelectTime,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: currentStep == 0 ? FontWeight.bold : FontWeight.normal,
                color: currentStep == 0 ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            Text(
              BookingStrings.bookingStepNotes,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: currentStep == 1 ? FontWeight.bold : FontWeight.normal,
                color: currentStep == 1 ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            Text(
              BookingStrings.bookingStepConfirm,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: currentStep == 2 ? FontWeight.bold : FontWeight.normal,
                color: currentStep == 2 ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
