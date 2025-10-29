import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current shard balance from the provider
    final shards = context.watch<GameProvider>().chronoshards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chronoshards'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.shield, color: Colors.cyan[600], size: 20),
                const SizedBox(width: 8),
                Text(
                  shards.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'The Store Owners are in Miami come back later',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
