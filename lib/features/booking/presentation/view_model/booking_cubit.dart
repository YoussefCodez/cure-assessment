import 'package:bloc/bloc.dart';
import 'package:cure/features/booking/domain/entities/available_time_slot_entity.dart';
import 'package:cure/features/booking/domain/entities/booking_entity.dart';
import 'package:cure/features/booking/domain/usecases/fetch_available_times.dart';
import 'package:cure/features/booking/domain/usecases/submit_booking_usecase.dart';
import 'package:cure/features/booking/domain/usecases/get_booking_history.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/network/base_response.dart';
import 'booking_states.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final FetchAvailableTimesUseCase fetchAvailableTimesUseCase;
  final SubmitBookingUseCase submitBookingUseCase;
  final GetBookingHistoryUseCase getBookingHistoryUseCase;

  BookingCubit(
    this.fetchAvailableTimesUseCase,
    this.submitBookingUseCase,
    this.getBookingHistoryUseCase,
  ) : super(const BookingState.initial());

  Future<void> fetchAvailableTimes(String serviceId) async {
    emit(const BookingState.loading());
    try {
      final result = await fetchAvailableTimesUseCase.call(serviceId);
      if (result is SuccessResponse<List<AvailableTimeSlotEntity>>) {
        emit(BookingState.success(result.data));
      } else if (result is FailedResponse<List<AvailableTimeSlotEntity>>) {
        emit(BookingState.failure(result.message));
      }
    } catch (e) {
      emit(BookingState.failure(e.toString()));
    }
  }

  Future<void> submitBooking(BookingEntity booking) async {
    emit(const BookingState.submitting());
    try {
      final result = await submitBookingUseCase.call(booking);
      if (result is SuccessResponse<BookingEntity>) {
        emit(BookingState.submitted(result.data));
      } else if (result is FailedResponse<BookingEntity>) {
        emit(BookingState.submitFailure(result.message));
      }
    } catch (e) {
      emit(BookingState.submitFailure(e.toString()));
    }
  }

  Future<void> fetchBookingHistory() async {
    emit(const BookingState.loadingHistory());
    try {
      final result = await getBookingHistoryUseCase.call();
      if (result is SuccessResponse<List<BookingEntity>>) {
        emit(BookingState.historySuccess(result.data));
      } else if (result is FailedResponse<List<BookingEntity>>) {
        emit(BookingState.historyFailure(result.message));
      }
    } catch (e) {
      emit(BookingState.historyFailure(e.toString()));
    }
  }
}