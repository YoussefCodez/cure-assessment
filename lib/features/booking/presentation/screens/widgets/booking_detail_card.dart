import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';

class BookingDetailCard extends StatelessWidget {
  final String serviceName;
  final String selectedDay;
  final String selectedTime;
  final String serviceLabel;
  final String dayLabel;
  final String timeLabel;

  const BookingDetailCard({
    super.key,
    required this.serviceName,
    required this.selectedDay,
    required this.selectedTime,
    required this.serviceLabel,
    required this.dayLabel,
    required this.timeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _infoRow(
            Icons.medical_services_outlined,
            serviceLabel,
            serviceName,
          ),
          Divider(height: 24.h, color: AppColors.border),
          _infoRow(
            Icons.calendar_today_outlined,
            dayLabel,
            selectedDay,
          ),
          Divider(height: 24.h, color: AppColors.border),
          _infoRow(
            Icons.access_time_outlined,
            timeLabel,
            selectedTime,
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.r),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
