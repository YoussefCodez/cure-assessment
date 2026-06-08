// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingModelAdapter extends TypeAdapter<BookingModel> {
  @override
  final typeId = 4;

  @override
  BookingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingModel(
      serviceId: fields[0] as String,
      dayName: fields[1] as String,
      time: fields[2] as String,
      notes: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.serviceId)
      ..writeByte(1)
      ..write(obj.dayName)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
