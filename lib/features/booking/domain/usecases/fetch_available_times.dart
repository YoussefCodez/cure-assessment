
import 'package:cure/config/network/base_response.dart';
import 'package:cure/features/booking/domain/entities/available_time_slot_entity.dart';
import 'package:cure/features/booking/domain/repositories/booking_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FetchAvailableTimesUseCase {
  final BookingRepositoryContract repository;

  const FetchAvailableTimesUseCase(this.repository);
  
  Future<BaseResponse<List<AvailableTimeSlotEntity>>> call(String serviceId) {
    return repository.fetchAvailableTimes(serviceId);
  }
}