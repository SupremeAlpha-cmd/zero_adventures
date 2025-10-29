import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    final player = gameProvider.player;
    final theme = Theme.of(context);
    final statValueStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );
    final statLabelStyle = TextStyle(
      fontSize: 14,
      color: theme.textTheme.bodySmall?.color,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // You can add a background image here
                  Container(color: theme.scaffoldBackgroundColor),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(player.avatarUrl),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          player.name,
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Joined August 2024', // Placeholder
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildChronoshardBalance(context, player.chronoshards),
                  const SizedBox(height: 24),
                  _buildStatsGrid(context, gameProvider, statValueStyle, statLabelStyle),
                  const SizedBox(height: 24),
                  Text(
                    'Achievements',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildAchievementTile(context, 'World Traveler', 'Visit every location in the main story.', 0.8, Icons.public),
                  _buildAchievementTile(context, 'Master of a Thousand Blades', 'Complete the swordsman questline.', 0.4, Icons.shield),
                  _buildAchievementTile(context, 'A Friend to All', 'Achieve ally status with all companions.', 0.9, Icons.group_add),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChronoshardBalance(BuildContext context, int shards) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shield, color: theme.colorScheme.primary, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHRONOSHARD BALANCE',
                style: TextStyle(color: Colors.white70, letterSpacing: 1.2),
              ),
              Text(
                shards.toString(),
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, GameProvider gameProvider, TextStyle valueStyle, TextStyle labelStyle) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(context, 'Stories Completed', gameProvider.storiesCompleted.toString(), valueStyle, labelStyle),
        _buildStatCard(context, 'Achievements', gameProvider.achievements.toString(), valueStyle, labelStyle),
        _buildStatCard(context, 'Highest Level', '15', valueStyle, labelStyle), // Placeholder
        _buildStatCard(context, 'Time Played', '42h', valueStyle, labelStyle), // Placeholder
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, TextStyle valueStyle, TextStyle labelStyle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: valueStyle),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: labelStyle),
        ],
      ),
    );
  }

  Widget _buildAchievementTile(BuildContext context, String title, String subtitle, double progress, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade700,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
