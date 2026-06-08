import 'package:cure/config/network/base_response.dart';
import 'package:cure/features/booking/domain/entities/booking_entity.dart';
import 'package:cure/features/booking/domain/repositories/booking_repository_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitBookingUseCase {
  final BookingRepositoryContract repository;

  const SubmitBookingUseCase(this.repository);

  Future<BaseResponse<BookingEntity>> call(BookingEntity booking) {
    return repository.submitBooking(booking);
  }
}
