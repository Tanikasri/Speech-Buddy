import 'package:hive/hive.dart';

part 'room_assignment.g.dart';

@HiveType(typeId: 1)
class RoomAssignment extends HiveObject {
  @HiveField(0)
  late String roomId;

  @HiveField(1)
  late String caretakerId;

  RoomAssignment({
    required this.roomId,
    required this.caretakerId,
  });
}
