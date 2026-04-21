// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestAdapter extends TypeAdapter<Request> {
  @override
  final int typeId = 0;

  @override
  Request read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Request(
      id: fields[0] as String,
      roomId: fields[1] as String,
      type: fields[2] as String,
      status: fields[3] as String,
      createdAt: fields[4] as DateTime,
      acceptedAt: fields[5] as DateTime?,
      completedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Request obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roomId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.acceptedAt)
      ..writeByte(6)
      ..write(obj.completedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
