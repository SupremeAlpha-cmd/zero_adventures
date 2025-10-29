import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read all the stats from the provider
    final gameProvider = context.watch<GameProvider>();
    final shards = gameProvider.chronoshards;
    final stories = gameProvider.storiesCompleted;
    final achievements = gameProvider.achievements;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              // You can use AssetImage for a local image
              // Or NetworkImage for a URL
              backgroundImage: NetworkImage(
                'https://i.imgur.com/example.png',
              ), // Placeholder
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Eon Strider',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // Chronoshard Balance
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield, color: Colors.cyan[600], size: 30),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CHRONOSHARD BALANCE',
                        style: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        shards.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              children: [
                _buildStatCard('Stories Completed', stories.toString()),
                const SizedBox(width: 20),
                _buildStatCard('Achievements', achievements.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the stat cards
  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[400],
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
