// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_time_slot_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvailableTimeSlotModelAdapter
    extends TypeAdapter<AvailableTimeSlotModel> {
  @override
  final typeId = 2;

  @override
  AvailableTimeSlotModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AvailableTimeSlotModel(
      dayName: fields[0] as String,
      times: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AvailableTimeSlotModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dayName)
      ..writeByte(1)
      ..write(obj.times);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailableTimeSlotModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
