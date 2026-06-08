import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/available_time_slot_model.dart';
import '../models/booking_model.dart';

@lazySingleton
class BookingLocalDataSource {
  static const String _boxPrefix = 'booking_slots_box_';
  static const String _historyBoxName = 'booking_history_box';

  Future<void> cacheAvailableTimes(String serviceId, List<AvailableTimeSlotModel> slots) async {
    final box = await Hive.openBox<AvailableTimeSlotModel>('$_boxPrefix$serviceId');
    await box.clear();
    for (int i = 0; i < slots.length; i++) {
      await box.put(i, slots[i]);
    }
  }

  Future<List<AvailableTimeSlotModel>> getCachedAvailableTimes(String serviceId) async {
    final box = await Hive.openBox<AvailableTimeSlotModel>('$_boxPrefix$serviceId');
    return box.values.toList();
  }

  Future<void> cacheBooking(BookingModel booking) async {
    final box = await Hive.openBox<BookingModel>(_historyBoxName);
    await box.add(booking);
  }

  Future<List<BookingModel>> getCachedBookings() async {
    final box = await Hive.openBox<BookingModel>(_historyBoxName);
    return box.values.toList();
  }
}
