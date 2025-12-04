// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 5;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
      timestamp: fields[3] as DateTime,
      isRead: fields[4] as bool,
      payload: fields[5] as String?,
      type: fields[6] as String?,
      checkInTime: fields[7] as DateTime?,
      checkOutTime: fields[8] as DateTime?,
      checkInLocation: fields[9] as String?,
      checkOutLocation: fields[10] as String?,
      workDuration: fields[11] as String?,
      date: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.isRead)
      ..writeByte(5)
      ..write(obj.payload)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.checkInTime)
      ..writeByte(8)
      ..write(obj.checkOutTime)
      ..writeByte(9)
      ..write(obj.checkInLocation)
      ..writeByte(10)
      ..write(obj.checkOutLocation)
      ..writeByte(11)
      ..write(obj.workDuration)
      ..writeByte(12)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
