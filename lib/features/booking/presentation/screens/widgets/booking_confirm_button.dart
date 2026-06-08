import 'package:cure/features/home/presentation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';
import 'package:cure/core/booking_strings.dart';
import 'package:cure/features/booking/domain/entities/booking_entity.dart';
import 'package:cure/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:cure/features/booking/presentation/view_model/booking_states.dart';

class BookingConfirmButton extends StatelessWidget {
  final String serviceId;
  final String selectedDay;
  final String selectedTime;
  final String notes;

  const BookingConfirmButton({
    super.key,
    required this.serviceId,
    required this.selectedDay,
    required this.selectedTime,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingStateSubmitted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainNavigationScreen()),
          );
        } else if (state is BookingStateSubmitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20.r),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      state.error,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.all(16.w),
            ),
          );
        }
      },
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          final isLoading = state is BookingStateSubmitting;
          return SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<BookingCubit>().submitBooking(
                        BookingEntity(
                          serviceId: serviceId,
                          dayName: selectedDay,
                          time: selectedTime,
                          notes: notes,
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.border,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      BookingStrings.confirmButton,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
