import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../providers/request_provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  static final AudioPlayer _player = AudioPlayer();

  Future<void> _playAndRequest(BuildContext context, String title, String audioFile) async {
    // 1. Play Audio
    await _player.stop();
    await _player.play(AssetSource(audioFile));

    // 2. Add Request to Hive
    final provider = Provider.of<RequestProvider>(context, listen: false);
    await provider.addRequest(title.toUpperCase(), '101'); // Assuming Room 101 for demo

    // 3. Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title Request Sent!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Buddy - Patient'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(24),
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        children: [
          _buildActionCard(context, 'Diet', 'assets/diet.png', 'diet.mp3', Colors.orange.shade100),
          _buildActionCard(context, 'Toilet', 'assets/toilet.png', 'toilet.mp3', Colors.blue.shade100),
          _buildActionCard(context, 'Help', 'assets/help.png', 'help.mp3', Colors.red.shade100),
          _buildActionCard(context, 'Water', 'assets/water.png', 'water.mp3', Colors.teal.shade100),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, String iconPath, String audioFile, Color bgColor) {
    final bool isHelp = title == 'Help';
    
    return Card(
      elevation: 4,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () => _playAndRequest(context, title, audioFile),
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isHelp ? Colors.red : Colors.white24,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isHelp ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
