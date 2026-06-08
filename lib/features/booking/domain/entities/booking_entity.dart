class BookingEntity {
  final String serviceId;
  final String dayName;
  final String time;
  final String notes;

  const BookingEntity({
    required this.serviceId,
    required this.dayName,
    required this.time,
    required this.notes,
  });
}
