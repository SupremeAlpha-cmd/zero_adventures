import 'package:flutter/material.dart';
import 'package:zero_adventures/mock_data.dart';
import 'package:zero_adventures/screens/story_details_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // In a real app, these would be managed by a provider or state management solution
  late final List<Story> _continuePlaying;
  late final List<Story> _savedForLater;
  List<Story> _filteredContinuePlaying = [];
  List<Story> _filteredSavedForLater = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // For now, we'll use mock data. This can be replaced with real user data later.
    _continuePlaying = [allStories[0], allStories[2]]; // Example data
    _savedForLater = [allStories[1], allStories[3]];   // Example data

    _filteredContinuePlaying = _continuePlaying;
    _filteredSavedForLater = _savedForLater;

    _searchController.addListener(_filterStories);
  }

  void _filterStories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContinuePlaying = _continuePlaying
          .where((story) => story.title.toLowerCase().contains(query))
          .toList();
      _filteredSavedForLater = _savedForLater
          .where((story) => story.title.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStorySection(
                        'Continue Playing', _filteredContinuePlaying),
                    const SizedBox(height: 32),
                    _buildStorySection('Saved for Later', _filteredSavedForLater),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search in your library...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[800],
      ),
    );
  }

  Widget _buildStorySection(String title, List<Story> stories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (stories.isEmpty)
          const Text('No stories in this section yet.')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return _buildStoryTile(story);
            },
          ),
      ],
    );
  }

  Widget _buildStoryTile(Story story) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryDetailsScreen(story: story),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                story.imageUrl,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${story.author}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // Example of a progress bar
                  const LinearProgressIndicator(
                    value: 0.4, // This would be dynamic in a real app
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
