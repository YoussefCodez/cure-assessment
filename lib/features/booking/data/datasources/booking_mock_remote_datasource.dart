import 'package:injectable/injectable.dart';
import '../../../../config/network/dio_client.dart';
import '../models/available_time_slot_model.dart';
import '../models/booking_model.dart';

@lazySingleton
class BookingMockRemoteDataSource {
  final DioClient _dioClient;

  const BookingMockRemoteDataSource(this._dioClient);

  Future<List<AvailableTimeSlotModel>> fetchAvailableTimes(String serviceId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    switch (serviceId) {
      case '1':
        return [
          AvailableTimeSlotModel(dayName: 'Monday', times: ['10:00 PM', '12:30 AM']),
          AvailableTimeSlotModel(dayName: 'Wednesday', times: ['09:00 AM', '02:00 PM', '06:00 PM']),
          AvailableTimeSlotModel(dayName: 'Friday', times: ['04:00 PM', '08:30 PM']),
        ];
      case '2':
        return [
          AvailableTimeSlotModel(dayName: 'Tuesday', times: ['11:00 AM', '01:30 PM']),
          AvailableTimeSlotModel(dayName: 'Thursday', times: ['03:00 PM', '07:00 PM', '10:00 PM']),
          AvailableTimeSlotModel(dayName: 'Saturday', times: ['10:00 AM', '12:00 PM']),
        ];
      case '3':
        return [
          AvailableTimeSlotModel(dayName: 'Sunday', times: ['08:00 AM', '12:00 PM']),
          AvailableTimeSlotModel(dayName: 'Monday', times: ['01:00 PM', '05:30 PM']),
          AvailableTimeSlotModel(dayName: 'Thursday', times: ['09:00 PM', '11:30 PM']),
        ];
      case '4':
        return [
          AvailableTimeSlotModel(dayName: 'Tuesday', times: ['02:00 PM', '04:30 PM']),
          AvailableTimeSlotModel(dayName: 'Wednesday', times: ['10:00 AM', '01:00 PM']),
          AvailableTimeSlotModel(dayName: 'Friday', times: ['07:00 PM', '09:30 PM']),
        ];
      default:
        return [
          AvailableTimeSlotModel(dayName: 'Monday', times: ['10:00 AM', '02:00 PM']),
          AvailableTimeSlotModel(dayName: 'Thursday', times: ['04:00 PM', '08:00 PM']),
        ];
    }
  }

  Future<BookingModel> submitBooking(BookingModel booking) async {
    final response = await _dioClient.dio.post(
      '/booking',
      data: booking.toJson(),
    );
    return BookingModel.fromJson(response.data as Map<String, dynamic>);
  }
}