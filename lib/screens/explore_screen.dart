
import 'package:flutter/material.dart';
import 'package:zero_adventures/api.dart';
import 'package:zero_adventures/mock_data.dart';
import 'package:zero_adventures/screens/category_screen.dart';
import 'package:zero_adventures/screens/story_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final Api _api;
  late Future<List<Story>> _topRatedStoriesFuture;
  late Future<List<Story>> _latestReleasesFuture;
  late final List<String> _genres;
  final Map<String, IconData> _genreIcons = {
    'adventure': Icons.explore,
    'sci-fi': Icons.rocket_launch,
    'dystopian': Icons.public_off,
    'fantasy': Icons.auto_stories,
    'horror': Icons.mood_bad,
    'action': Icons.directions_run,
    'comedy': Icons.sentiment_very_satisfied,
    'romance': Icons.favorite,
    'mystery': Icons.help,
    'shonen': Icons.bolt,
    'shojo': Icons.bubble_chart,
  };
  final Map<String, Color> _genreColors = {
    'adventure': Colors.orange,
    'sci-fi': Colors.blue,
    'dystopian': Colors.grey,
    'fantasy': Colors.purple,
    'horror': Colors.red,
    'action': Colors.green,
    'comedy': Colors.yellow,
    'romance': Colors.pink,
    'mystery': Colors.teal,
    'shonen': Colors.cyan,
    'shojo': Colors.lime,
  };

  @override
  void initState() {
    super.initState();
    _api = Api();
    _topRatedStoriesFuture = _api.getTopRatedStories();
    _latestReleasesFuture = _api.getLatestReleases();
    // Correctly initialize the list of genres from the mock data
    _genres = allStories.map((s) => s.subCategory).toSet().toList();
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
              'Genres',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _genres.length,
                itemBuilder: (context, index) {
                  final genre = _genres[index];
                  return _buildCategoryButton(
                    context,
                    genre,
                    _genreIcons[genre.toLowerCase()] ?? Icons.question_mark,
                    _genreColors[genre.toLowerCase()] ?? Colors.black,
                  );
                },
              ),
            ),
            const SizedBox(height: 34),
            _buildStoryList('Top Rated', _topRatedStoriesFuture),
            const SizedBox(height: 24),
            _buildStoryList('Latest Release', _latestReleasesFuture),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(category: title),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
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
        ),
      ),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StoryDetailsScreen(story: story),
                          ),
                        );
                      },
                      child: Container(
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
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 160,
                                    width: 140,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image_not_supported),
                                  );
                                },
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
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
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
