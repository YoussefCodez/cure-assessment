import 'package:cure/core/app_colors.dart';
import 'package:cure/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/di/injection_container.dart';
import 'widgets/booking_page_views.dart';

class BookingScreen extends StatelessWidget {
  final String serviceId;
  final String serviceName;
  final String servicePrice;

  const BookingScreen({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BookingCubit>()..fetchAvailableTimes(serviceId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textPrimary,
              size: 20.r,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BookingPageViews(
              serviceId: serviceId,
              serviceName: serviceName,
              servicePrice: servicePrice,
            ),
          ),
        ),
      ),
    );
  }
}
