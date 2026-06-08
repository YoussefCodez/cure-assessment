import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';

class BookingCostCard extends StatelessWidget {
  final double serviceAmount;
  final double serviceFee;
  final double total;
  final String serviceCostLabel;
  final String feeCostLabel;
  final String totalLabel;
  final String currencyLabel;

  const BookingCostCard({
    super.key,
    required this.serviceAmount,
    required this.serviceFee,
    required this.total,
    required this.serviceCostLabel,
    required this.feeCostLabel,
    required this.totalLabel,
    required this.currencyLabel,
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
          _costRow(serviceCostLabel, '${serviceAmount.toStringAsFixed(0)} $currencyLabel'),
          SizedBox(height: 10.h),
          _costRow(feeCostLabel, '${serviceFee.toStringAsFixed(0)} $currencyLabel'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: AppColors.border),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalLabel,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${total.toStringAsFixed(0)} $currencyLabel',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _costRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
