import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/request_provider.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RequestProvider>();
    final typeCounts = provider.getRequestTypeCounts();
    final avgResponse = provider.getAverageResponseTimeSeconds();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard & Analytics'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              'Average Response Time',
              '${avgResponse.toStringAsFixed(1)} seconds',
              Icons.timer,
              Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Request Volume by Type',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...typeCounts.entries.map((e) => _buildTypeTile(e.key, e.value)),
            const SizedBox(height: 32),
            const Text(
              'Room Assignments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...provider.assignments.map((a) => ListTile(
              leading: const Icon(Icons.meeting_room),
              title: Text('Room ${a.roomId}'),
              subtitle: Text('Assigned: ${a.caretakerId}'),
              trailing: const Icon(Icons.edit, size: 20),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildTypeTile(String type, int count) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(type),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
