import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech Buddy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Single audio player for the app
  static final AudioPlayer _player = AudioPlayer();

  // Function to play audio from assets
  Future<void> _playAudio(String audioFile) async {
    await _player.stop(); // stop previous audio if any
    await _player.play(AssetSource(audioFile));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Buddy'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          _buildCard('Diet', 'assets/diet.png', 'diet.mp3'),
          _buildCard('Toilet', 'assets/toilet.png', 'toilet.mp3'),
          _buildCard('Help', 'assets/help.png', 'help.mp3'),
          _buildCard('Water', 'assets/water.png', 'water.mp3'),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String assetPath, String audioFile) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          _playAudio(audioFile); // Play audio on tap
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(assetPath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
} 
