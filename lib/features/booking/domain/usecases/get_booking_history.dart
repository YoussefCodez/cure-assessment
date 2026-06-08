import 'package:cure/config/network/base_response.dart';
import 'package:cure/features/booking/domain/entities/booking_entity.dart';
import 'package:cure/features/booking/domain/repositories/booking_repository_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetBookingHistoryUseCase {
  final BookingRepositoryContract repository;

  const GetBookingHistoryUseCase(this.repository);

  Future<BaseResponse<List<BookingEntity>>> call() {
    return repository.fetchBookingHistory();
  }
}
