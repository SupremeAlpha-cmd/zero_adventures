import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/models/player_model.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class CharacterSheet extends StatefulWidget {
  const CharacterSheet({super.key});

  @override
  State<CharacterSheet> createState() => _CharacterSheetState();
}

class _CharacterSheetState extends State<CharacterSheet> {
  Item? _selectedItem;

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    final player = gameProvider.player;

    // Automatically select the first item if none is selected
    if (_selectedItem == null && player.inventory.isNotEmpty) {
      _selectedItem = player.inventory.first;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1726),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, player),
              const SizedBox(height: 24),
              _buildSectionTitle('Character Stats'),
              const SizedBox(height: 16),
              _buildStatBar(
                'Health (HP)',
                Icons.favorite,
                player.health / player.maxHealth,
                '${player.health}/${player.maxHealth}',
                Colors.green.shade400,
              ),
              const SizedBox(height: 16),
              _buildStatBar(
                'Mana (MP)',
                Icons.auto_awesome,
                player.mana / player.maxMana,
                '${player.mana}/${player.maxMana}',
                Colors.cyan.shade400,
              ),
              const SizedBox(height: 24),
              _buildAttributeGrid(player),
              const SizedBox(height: 24),
              _buildSectionTitle('Inventory'),
              const SizedBox(height: 16),
              _buildInventoryGrid(player.inventory),
              const SizedBox(height: 24),
              _buildSelectedItemDetails(context, gameProvider),
              const SizedBox(height: 24),
              _buildSectionTitle('Relationships'),
              const SizedBox(height: 16),
              _buildRelationshipsList(player.relationships),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Player player) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: NetworkImage(player.avatarUrl),
            ),
            const SizedBox(height: 12),
            Text(
              player.name,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              player.location,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBar(
      String label, IconData icon, double value, String textValue, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const Spacer(),
            Text(textValue, style: const TextStyle(color: Colors.white, fontSize: 16)),
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

  Widget _buildAttributeGrid(Player player) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildAttributeItem('Strength', player.strength),
        _buildAttributeItem('Dexterity', player.dexterity),
        _buildAttributeItem('Intelligence', player.intelligence),
        _buildAttributeItem('Charisma', player.charisma),
      ],
    );
  }

  Widget _buildAttributeItem(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInventoryGrid(List<Item> inventory) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 8, // Fixed number of slots
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = index < inventory.length ? inventory[index] : null;
        final isSelected = item != null && _selectedItem?.name == item.name;

        return GestureDetector(
          onTap: () {
            if (item != null) {
              setState(() {
                _selectedItem = item;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.cyan.shade400 : Colors.white24,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.cyan.shade400.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            child: item != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(item.imageUrl, fit: BoxFit.contain),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildSelectedItemDetails(BuildContext context, GameProvider gameProvider) {
    final bool canUseItem = _selectedItem != null &&
        ((_selectedItem!.name == 'Health Potion' && gameProvider.player.health < gameProvider.player.maxHealth) ||
         (_selectedItem!.name == 'Mana Potion' && gameProvider.player.mana < gameProvider.player.maxMana));

    if (_selectedItem == null) {
      return const Center(
          child: Text('No items in inventory.', style: TextStyle(color: Colors.white70)));
    }

    return Column(
      children: [
        Text(
          _selectedItem!.name,
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 18, 
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A common potion used to restore a small amount of health.', // Placeholder description
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: canUseItem
              ? () {
                  if (_selectedItem!.name == 'Health Potion') {
                    context.read<GameProvider>().useHealthPotion();
                  } else if (_selectedItem!.name == 'Mana Potion') {
                    // You need to implement useManaPotion() in your provider
                    // context.read<GameProvider>().useManaPotion();
                  }
                  // After using, the item might be gone, so we should update the state
                  setState(() {
                    _selectedItem = null; // Or select the next item
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan.shade400,
            disabledBackgroundColor: Colors.grey.shade800,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text('Use Item', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildRelationshipsList(List<Relationship> relationships) {
    return Column(
      children: relationships
          .map((relationship) => _buildRelationshipTile(relationship))
          .toList(),
    );
  }

  Widget _buildRelationshipTile(Relationship relationship) {
    Color statusColor;
    String statusText;
    switch (relationship.status) {
      case RelationshipStatus.ally:
        statusColor = Colors.green;
        statusText = 'Ally';
        break;
      case RelationshipStatus.neutral:
        statusColor = Colors.grey;
        statusText = 'Neutral';
        break;
      case RelationshipStatus.enemy:
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
            backgroundImage: NetworkImage(relationship.imageUrl),
          ),
          const SizedBox(width: 12),
          Text(
            relationship.name,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
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
                  color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
