import 'package:hive_ce/hive.dart';
import '../../domain/entities/available_time_slot_entity.dart';

part 'available_time_slot_model.g.dart';

@HiveType(typeId: 2)
class AvailableTimeSlotModel extends HiveObject {
  @HiveField(0)
  final String dayName;
  @HiveField(1)
  final List<String> times;

  AvailableTimeSlotModel({
    required this.dayName,
    required this.times,
  });

  AvailableTimeSlotEntity toEntity() {
    return AvailableTimeSlotEntity(
      dayName: dayName,
      times: times,
    );
  }

  factory AvailableTimeSlotModel.fromEntity(AvailableTimeSlotEntity entity) {
    return AvailableTimeSlotModel(
      dayName: entity.dayName,
      times: entity.times,
    );
  }
}
