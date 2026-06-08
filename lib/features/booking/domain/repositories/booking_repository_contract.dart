import '../../../../config/network/base_response.dart';
import '../entities/available_time_slot_entity.dart';
import '../entities/booking_entity.dart';

abstract class BookingRepositoryContract {
  Future<BaseResponse<List<AvailableTimeSlotEntity>>> fetchAvailableTimes(String serviceId);
  Future<BaseResponse<BookingEntity>> submitBooking(BookingEntity booking);
  Future<BaseResponse<List<BookingEntity>>> fetchBookingHistory();
}