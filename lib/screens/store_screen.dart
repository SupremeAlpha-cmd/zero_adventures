import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shards = context.watch<GameProvider>().player.chronoshards; // Assuming chronoshards are part of the player model
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Chip(
              avatar: Icon(Icons.shield, color: theme.colorScheme.primary, size: 18),
              label: Text(shards.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: theme.colorScheme.surface,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeaturedStory(context),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Chronoshard Deals'),
            const SizedBox(height: 12),
            _buildChronoshardDeals(context),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Special Offers'),
            const SizedBox(height: 12),
            _buildSpecialOfferCard(context),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Get Free Chronoshards'),
            const SizedBox(height: 12),
            _buildFreeShardsOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFeaturedStory(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/featured_story_bg.png?alt=media&token=c9d09f3e-8c34-45e0-b747-31350a4f5f3e', // Placeholder
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'FEATURED STORY',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'The Sunken City of Aeridor',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: const Text('View Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChronoshardDeals(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.8,
      children: [
        _buildDealCard(context, '100', 'Small Pouch', '\$0.99', Colors.green.shade300),
        _buildDealCard(context, '550', 'Medium Chest', '\$4.99', Colors.blue.shade300, isMostPopular: true),
        _buildDealCard(context, '1,200', 'Large Crate', '\$9.99', Colors.purple.shade300),
        _buildDealCard(context, '3,000', 'Royal Treasury', '\$19.99', Colors.amber.shade300),
      ],
    );
  }

  Widget _buildDealCard(BuildContext context, String amount, String name, String price, Color color, {bool isMostPopular = false}) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isMostPopular ? BorderSide(color: theme.colorScheme.primary, width: 2) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isMostPopular)
              const Chip(label: Text('Most Popular'), padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
            if (!isMostPopular) const SizedBox(height: 24), // To align cards
            Column(
              children: [
                Icon(Icons.shield, size: 40, color: color),
                const SizedBox(height: 8),
                Text(amount, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(name, style: const TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary),
              child: Text(price),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialOfferCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.amber, size: 30),
        title: const Text('Starter Pack Bundle', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Get exclusive items and a story unlock for a low price!'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }

  Widget _buildFreeShardsOptions(BuildContext context) {
    return Column(
      children: [
        _buildFreeShardTile(context, 'Watch an Ad', 'Earn 10 Chronoshards', Icons.smart_display),
        _buildFreeShardTile(context, 'Complete a Survey', 'Earn up to 100 Chronoshards', Icons.poll),
      ],
    );
  }

  Widget _buildFreeShardTile(BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade400, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}
