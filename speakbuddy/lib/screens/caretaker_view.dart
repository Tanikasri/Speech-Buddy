import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/request_provider.dart';
import '../models/request.dart';

class CaretakerView extends StatelessWidget {
  const CaretakerView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RequestProvider>();
    final requests = provider.getRequestsForCaretaker('Caretaker A'); // Hardcoded for demo

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caretaker Dashboard (Caretaker A)'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: requests.isEmpty
          ? const Center(child: Text('No requests for your rooms.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final r = requests[index];
                return _buildRequestCard(context, provider, r);
              },
            ),
    );
  }

  Widget _buildRequestCard(BuildContext context, RequestProvider provider, Request r) {
    final Color statusColor = _getStatusColor(r);
    final String timeStr = DateFormat('jm').format(r.createdAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor, width: 2),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: statusColor,
          child: Icon(_getTypeIcon(r.type), color: Colors.white),
        ),
        title: Text(
          'Room ${r.roomId}: ${r.type}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${r.status} | Sent at: $timeStr'),
            if (r.acceptedAt != null)
              Text('Accepted at: ${DateFormat('jm').format(r.acceptedAt!)}', 
                   style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: _buildActions(provider, r),
      ),
    );
  }

  Widget _buildActions(RequestProvider provider, Request r) {
    if (r.status == 'PENDING') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        onPressed: () => provider.acceptRequest(r.id),
        child: const Text('ACCEPT', style: TextStyle(color: Colors.black)),
      );
    } else if (r.status == 'ACCEPTED') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () => provider.completeRequest(r.id),
        child: const Text('COMPLETE', style: TextStyle(color: Colors.white)),
      );
    }
    return const Icon(Icons.check_circle, color: Colors.green);
  }

  Color _getStatusColor(Request r) {
    if (r.type == 'HELP' && r.status == 'PENDING') return Colors.red;
    switch (r.status) {
      case 'PENDING': return Colors.amber;
      case 'ACCEPTED': return Colors.blue;
      case 'COMPLETED': return Colors.green;
      default: return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'HELP': return Icons.warning_amber;
      case 'WATER': return Icons.water_drop;
      case 'DIET': return Icons.restaurant;
      case 'TOILET': return Icons.wc;
      default: return Icons.help_outline;
    }
  }
}
