import 'package:cure/core/home_strings.dart';
import 'package:cure/features/booking/presentation/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../view_model/services_cubit.dart';
import '../view_model/services_state.dart';
import '../widgets/nursing_service_card.dart';

class HomeServicesScreen extends StatelessWidget {
  const HomeServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                HomeStrings.homeServicesTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                HomeStrings.homeServicesSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: BlocBuilder<ServicesCubit, ServicesState>(
                  builder: (context, state) {
                    if (state is ServicesLoading || state is ServicesInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ServicesFailure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.r,
                              color: AppColors.error,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<ServicesCubit>().loadServices(),
                              child: Text(HomeStrings.retry),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is ServicesLoaded) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: state.services.length,
                        itemBuilder: (context, index) {
                          final service = state.services[index];
                          return NursingServiceCard(
                            title: service.title,
                            description: service.description,
                            iconCodePoint: service.iconCodePoint,
                            price: service.price,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookingScreen(
                                        serviceId: service.id,
                                        serviceName: service.title,
                                        servicePrice: service.price,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
