// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomAssignmentAdapter extends TypeAdapter<RoomAssignment> {
  @override
  final int typeId = 1;

  @override
  RoomAssignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomAssignment(
      roomId: fields[0] as String,
      caretakerId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RoomAssignment obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.roomId)
      ..writeByte(1)
      ..write(obj.caretakerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomAssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
