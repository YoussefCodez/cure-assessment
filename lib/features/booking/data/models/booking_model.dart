import 'package:hive_ce/hive.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 4)
class BookingModel {
  @HiveField(0)
  final String serviceId;
  @HiveField(1)
  final String dayName;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final String notes;

  const BookingModel({
    required this.serviceId,
    required this.dayName,
    required this.time,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'dayName': dayName,
        'time': time,
        'notes': notes,
      };

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        serviceId: json['serviceId'] as String,
        dayName: json['dayName'] as String,
        time: json['time'] as String,
        notes: json['notes'] as String,
      );
}
