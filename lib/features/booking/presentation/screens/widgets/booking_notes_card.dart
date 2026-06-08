import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';

class BookingNotesCard extends StatelessWidget {
  final String title;
  final String notes;
  final String placeholder;

  const BookingNotesCard({
    super.key,
    required this.title,
    required this.notes,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note_outlined, color: AppColors.primary, size: 18.r),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            notes.isEmpty ? placeholder : notes,
            style: TextStyle(
              fontSize: 13.sp,
              color: notes.isEmpty ? AppColors.textSecondary : AppColors.textPrimary,
              fontStyle: notes.isEmpty ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
