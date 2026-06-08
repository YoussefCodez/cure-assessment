import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../../config/network/network_exceptions.dart';
import '../../domain/entities/available_time_slot_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository_contract.dart';
import '../datasources/booking_local_datasource.dart';
import '../datasources/booking_mock_remote_datasource.dart';
import '../models/booking_model.dart';

@LazySingleton(as: BookingRepositoryContract)
class BookingRepositoryImpl implements BookingRepositoryContract {
  final BookingMockRemoteDataSource _bookingMockRemoteDataSource;
  final BookingLocalDataSource _bookingLocalDataSource;

  const BookingRepositoryImpl({
    required BookingMockRemoteDataSource bookingMockRemoteDataSource,
    required BookingLocalDataSource bookingLocalDataSource,
  }) : _bookingMockRemoteDataSource = bookingMockRemoteDataSource,
       _bookingLocalDataSource = bookingLocalDataSource;

  @override
  Future<BaseResponse<List<AvailableTimeSlotEntity>>> fetchAvailableTimes(String serviceId) async {
    try {
      // 1- check if cached existed and not empty or null if yes return it
      final cached = await _bookingLocalDataSource.getCachedAvailableTimes(serviceId);
      if (cached.isNotEmpty) {
        return SuccessResponse(cached.map((e) => e.toEntity()).toList());
      }

      // 2- get the data from api and cache it
      final remote = await _bookingMockRemoteDataSource.fetchAvailableTimes(serviceId);
      await _bookingLocalDataSource.cacheAvailableTimes(serviceId, remote);

      // 3- return remote data
      return SuccessResponse(remote.map((e) => e.toEntity()).toList());
    } on NetworkException catch (e) {
      // 4- in catches show cache first if failed show failed response
      final cached = await _bookingLocalDataSource.getCachedAvailableTimes(serviceId);
      if (cached.isEmpty) {
        return FailedResponse(ErrorHandler.handle(e));
      }
      return SuccessResponse(cached.map((e) => e.toEntity()).toList());
    } catch (e) {
      final cached = await _bookingLocalDataSource.getCachedAvailableTimes(serviceId);
      if (cached.isEmpty) {
        return FailedResponse(ErrorHandler.handle(e));
      }
      return SuccessResponse(cached.map((e) => e.toEntity()).toList());
    }
  }

  @override
  Future<BaseResponse<BookingEntity>> submitBooking(BookingEntity booking) async {
    try {
      final model = BookingModel(
        serviceId: booking.serviceId,
        dayName: booking.dayName,
        time: booking.time,
        notes: booking.notes,
      );
      final remoteModel = await _bookingMockRemoteDataSource.submitBooking(model);
      
      // Save successfully submitted booking to history
      await _bookingLocalDataSource.cacheBooking(remoteModel);
      
      return SuccessResponse(booking);
    } on NetworkException catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    } catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<List<BookingEntity>>> fetchBookingHistory() async {
    try {
      final cachedModels = await _bookingLocalDataSource.getCachedBookings();
      final entities = cachedModels.map((model) => BookingEntity(
        serviceId: model.serviceId,
        dayName: model.dayName,
        time: model.time,
        notes: model.notes,
      )).toList();
      return SuccessResponse(entities);
    } catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    }
  }
}
