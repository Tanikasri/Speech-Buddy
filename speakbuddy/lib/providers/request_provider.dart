import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/request.dart';
import '../models/room_assignment.dart';

class RequestProvider extends ChangeNotifier {
  late Box<Request> _requestBox;
  late Box<RoomAssignment> _assignmentBox;
  final _uuid = const Uuid();

  List<Request> get requests => _requestBox.values.toList();
  List<RoomAssignment> get assignments => _assignmentBox.values.toList();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    _requestBox = await Hive.openBox<Request>('requests');
    _assignmentBox = await Hive.openBox<RoomAssignment>('assignments');
    
    // Seed default assignments if empty
    if (_assignmentBox.isEmpty) {
      await _assignmentBox.addAll([
        RoomAssignment(roomId: '101', caretakerId: 'Caretaker A'),
        RoomAssignment(roomId: '102', caretakerId: 'Caretaker B'),
        RoomAssignment(roomId: '103', caretakerId: 'Caretaker A'),
      ]);
    }
    
    _isInitialized = true;
    notifyListeners();
  }

  // --- ACTIONS ---

  Future<void> addRequest(String type, String roomId) async {
    final newRequest = Request(
      id: _uuid.v4(),
      roomId: roomId,
      type: type,
      status: 'PENDING',
      createdAt: DateTime.now(),
    );
    await _requestBox.put(newRequest.id, newRequest);
    notifyListeners();
  }

  Future<void> acceptRequest(String id) async {
    final request = _requestBox.get(id);
    if (request != null) {
      request.status = 'ACCEPTED';
      request.acceptedAt = DateTime.now();
      await request.save();
      notifyListeners();
    }
  }

  Future<void> completeRequest(String id) async {
    final request = _requestBox.get(id);
    if (request != null) {
      request.status = 'COMPLETED';
      request.completedAt = DateTime.now();
      await request.save();
      notifyListeners();
    }
  }

  Future<void> assignCaretaker(String roomId, String caretakerId) async {
    // Find existing assignment or create new
    final index = _assignmentBox.values.toList().indexWhere((a) => a.roomId == roomId);
    if (index != -1) {
      final assignment = _assignmentBox.getAt(index);
      assignment?.caretakerId = caretakerId;
      await assignment?.save();
    } else {
      await _assignmentBox.add(RoomAssignment(roomId: roomId, caretakerId: caretakerId));
    }
    notifyListeners();
  }

  // --- GETTERS ---

  List<Request> getRequestsForCaretaker(String caretakerId) {
    final assignedRooms = _assignmentBox.values
        .where((a) => a.caretakerId == caretakerId)
        .map((a) => a.roomId)
        .toSet();
    
    final filtered = requests.where((r) => assignedRooms.contains(r.roomId)).toList();
    
    // Sort: PENDING first, then by priority (HELP at top), then by time
    filtered.sort((a, b) {
      if (a.status != b.status) {
        if (a.status == 'PENDING') return -1;
        if (b.status == 'PENDING') return 1;
        if (a.status == 'ACCEPTED') return -1;
        if (b.status == 'ACCEPTED') return 1;
      }
      if (a.type != b.type) {
        if (a.type == 'HELP') return -1;
        if (b.type == 'HELP') return 1;
      }
      return b.createdAt.compareTo(a.createdAt);
    });
    
    return filtered;
  }

  // Analytics
  Map<String, int> getRequestTypeCounts() {
    final counts = <String, int>{};
    for (var r in requests) {
      counts[r.type] = (counts[r.type] ?? 0) + 1;
    }
    return counts;
  }

  double getAverageResponseTimeSeconds() {
    final completed = requests.where((r) => r.acceptedAt != null).toList();
    if (completed.isEmpty) return 0;
    
    final total = completed.fold<int>(0, (sum, r) {
      return sum + r.acceptedAt!.difference(r.createdAt).inSeconds;
    });
    return total / completed.length;
  }
}
