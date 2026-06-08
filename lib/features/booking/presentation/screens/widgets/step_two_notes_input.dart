import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';
import 'package:cure/core/booking_strings.dart';

class StepTwoNotesInput extends StatelessWidget {
  final TextEditingController controller;

  const StepTwoNotesInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.medical_information_outlined,
                color: AppColors.primary,
                size: 24.r,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    BookingStrings.notesTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    BookingStrings.notesSubtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 28.h),
        Text(
          BookingStrings.notesLabel,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          maxLines: 7,
          maxLength: 500,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: BookingStrings.notesHint,
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
            ),
            contentPadding: EdgeInsets.all(16.w),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary, size: 16.r),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  BookingStrings.notesInfoTip,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
