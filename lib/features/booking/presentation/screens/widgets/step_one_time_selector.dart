import 'package:cure/core/booking_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';
import '../../../domain/entities/available_time_slot_entity.dart';

class StepOneTimeSelector extends StatelessWidget {
  final List<AvailableTimeSlotEntity> availableTimes;
  final AvailableTimeSlotEntity? selectedDay;
  final String? selectedTime;
  final ValueChanged<AvailableTimeSlotEntity> onDaySelected;
  final ValueChanged<String> onTimeSelected;

  const StepOneTimeSelector({
    super.key,
    required this.availableTimes,
    required this.selectedDay,
    required this.selectedTime,
    required this.onDaySelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          BookingStrings.bookingAvailableDate,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: availableTimes.map((daySlot) {
              final isSelected = selectedDay?.dayName == daySlot.dayName;
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: ChoiceChip(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Text(
                      daySlot.dayName,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  onSelected: (_) => onDaySelected(daySlot),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 24.h),
        if (selectedDay != null) ...[
          Text(
            BookingStrings.bookingAvailableTime,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 2.2,
            ),
            itemCount: selectedDay!.times.length,
            itemBuilder: (context, index) {
              final time = selectedDay!.times[index];
              final isSelected = selectedTime == time;
              return InkWell(
                onTap: () => onTimeSelected(time),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: 1.5.w,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
        ] else
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Text(
                BookingStrings.bookingSelectDayPrompt,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
