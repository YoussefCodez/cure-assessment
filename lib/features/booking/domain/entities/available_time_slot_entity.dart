import 'package:equatable/equatable.dart';

class AvailableTimeSlotEntity extends Equatable {
  final String dayName;
  final List<String> times;

  const AvailableTimeSlotEntity({
    required this.dayName,
    required this.times,
  });

  @override
  List<Object?> get props => [dayName, times];
}
