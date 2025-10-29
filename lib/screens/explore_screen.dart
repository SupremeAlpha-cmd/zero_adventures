import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/api.dart';
import 'package:zero_adventures/mock_data.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final Api _api;
  late Future<List<Story>> _topRatedStoriesFuture;
  late Future<List<Story>> _latestReleasesFuture;

  @override
  void initState() {
    super.initState();
    _api = Api();
    _topRatedStoriesFuture = _api.getTopRatedStories();
    _latestReleasesFuture = _api.getLatestReleases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zero Adventures'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryButton(context, 'Movies', Icons.movie, Colors.orange),
                _buildCategoryButton(context, 'Books', Icons.book, Colors.blue),
                _buildCategoryButton(context, 'Anime', Icons.tv, Colors.purple),
                _buildCategoryButton(context, 'Games', Icons.games, Colors.green),
              ],
            ),

            // --- TEST BUTTON TO START STORY ---
            // This is a temporary button to test our game logic
            Center(
              child: ElevatedButton(
                child: const Text('Interstellar Odyssey'),
                onPressed: () {
                  // Get the provider and tell it to load our story
                  context.read<GameProvider>().loadStory(
                    'lib/assets/stories/interstellar_odyssey.json',
                  );

                  // Navigate to the game screen
                  Navigator.pushNamed(context, '/game');
                },
              ),
            ),

            // --- END TEST BUTTON ---
            const SizedBox(height: 34),
            _buildStoryList('Top Rated', _topRatedStoriesFuture),
            const SizedBox(height: 24),
            _buildStoryList('Latest Release', _latestReleasesFuture),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildStoryList(String title, Future<List<Story>> future) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: FutureBuilder<List<Story>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No stories found.'));
              } else {
                final stories = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              story.imageUrl,
                              height: 160,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            story.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            story.author,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
