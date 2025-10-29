import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/models/player_model.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class CharacterSheet extends StatelessWidget {
  const CharacterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the provider, but don't listen for changes
    // (assuming stats don't change while the sheet is open)
    final provider = context.read<GameProvider>();
    final stats = provider.playerStats;

    return Container(
      // Let it take up 90% of the screen height
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1726), // Dark background from your UI
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              _buildHeader(context, stats),
              const SizedBox(height: 24),

              // --- Character Stats ---
              Text(
                'Character Stats',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildStatBar(
                'Health (HP)',
                Icons.favorite,
                stats.currentHp / stats.maxHp,
                '${stats.currentHp}/${stats.maxHp}',
                Colors.green.shade400,
              ),
              const SizedBox(height: 16),
              _buildStatBar(
                'Mana (MP)',
                Icons.auto_awesome, // Using a different icon
                stats.currentMp / stats.maxMp,
                '${stats.currentMp}/${stats.maxMp}',
                Colors.blue.shade400,
              ),
              const SizedBox(height: 24),
              _buildAttributeGrid(stats),
              const SizedBox(height: 24),

              // --- Inventory ---
              Text(
                'Inventory',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildInventoryGrid(provider.inventory),
              const SizedBox(height: 24),

              // --- Relationships ---
              Text(
                'Relationships',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildRelationshipsList(provider.relationships),
            ],
          ),
        ),
      ),
    );
  }

  // --- Header ---
  Widget _buildHeader(BuildContext context, PlayerStats stats) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Close Button
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        // Avatar and Name
        Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade800,
              // Use AssetImage for local assets
              // backgroundImage: AssetImage(stats.avatarAsset),
              // Using a placeholder icon for simplicity
              child: const Icon(Icons.person, size: 40, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Text(
              stats.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stats.location,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  // --- Stat Bar Helper ---
  Widget _buildStatBar(
    String label,
    IconData icon,
    double value,
    String textValue,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            Text(
              textValue,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade800,
          color: color,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  // --- Attribute Grid ---
  Widget _buildAttributeGrid(PlayerStats stats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAttributeItem('Strength', stats.strength),
        _buildAttributeItem('Dexterity', stats.dexterity),
        _buildAttributeItem('Intelligence', stats.intelligence),
        _buildAttributeItem('Charisma', stats.charisma),
      ],
    );
  }

  Widget _buildAttributeItem(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // --- Inventory Grid ---
  Widget _buildInventoryGrid(List<Item?> inventory) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 8, // 2 rows of 4
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = inventory[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: item != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Placeholder for item image
                  child: Icon(Icons.shield, color: Colors.amber),
                  // You would use: Image.asset(item.imageAsset)
                )
              : null, // Empty slot
        );
      },
    );
  }

  // --- Relationships List ---
  Widget _buildRelationshipsList(List<NPC> relationships) {
    return Column(
      children: relationships
          .map((npc) => _buildRelationshipTile(npc))
          .toList(),
    );
  }

  Widget _buildRelationshipTile(NPC npc) {
    // Determine status color
    Color statusColor;
    String statusText;
    switch (npc.status) {
      case RelationshipStatus.Ally:
        statusColor = Colors.green;
        statusText = 'Ally';
        break;
      case RelationshipStatus.Neutral:
        statusColor = Colors.grey;
        statusText = 'Neutral';
        break;
      case RelationshipStatus.Enemy:
        statusColor = Colors.red;
        statusText = 'Enemy';
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade800,
            // backgroundImage: AssetImage(npc.imageAsset),
            child: const Icon(Icons.person, color: Colors.white70),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${npc.name}, ${npc.title}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor, width: 1),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
