import 'package:hive/hive.dart';

part 'request.g.dart';

@HiveType(typeId: 0)
class Request extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String roomId;

  @HiveField(2)
  late String type;

  @HiveField(3)
  late String status;

  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  DateTime? acceptedAt;

  @HiveField(6)
  DateTime? completedAt;

  Request({
    required this.id,
    required this.roomId,
    required this.type,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    this.completedAt,
  });
}
