import 'package:flutter/material.dart';
import 'package:zero_adventures/api.dart';
import 'package:zero_adventures/mock_data.dart';
import 'package:zero_adventures/screens/story_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final Api _api;
  String? _selectedSubCategory;
  Future<List<Story>>? _storiesFuture;

  @override
  void initState() {
    super.initState();
    _api = Api();
  }

  void _onSubCategorySelected(String subCategory) {
    setState(() {
      _selectedSubCategory = subCategory;
      _storiesFuture = _api.getStoriesBySubCategory(subCategory);
    });
  }

  List<String> _getSubCategories(String category) {
    // This should be dynamic in a real app, but for now, it's hardcoded
    switch (category) {
      case 'Movies':
        return ['Action', 'Comedy', 'Sci-Fi', 'Horror', 'Adventure'];
      case 'Books':
        return ['Fantasy', 'Mystery', 'Romance', 'Thriller', 'Dystopian'];
      case 'Anime':
        return ['Shonen', 'Shojo', 'Seinen', 'Isekai', 'Mecha'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final subCategories = _getSubCategories(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        // Add a back button for the story list view
        leading: _selectedSubCategory != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _selectedSubCategory = null;
                    _storiesFuture = null;
                  });
                },
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // If no sub-category is selected, show the grid of sub-categories
        child: _selectedSubCategory == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sub-Categories',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5, // Make buttons wider
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: subCategories.length,
                      itemBuilder: (context, index) {
                        final subCategory = subCategories[index];
                        return ElevatedButton(
                          onPressed: () => _onSubCategorySelected(subCategory),
                          child: Text(subCategory),
                        );
                      },
                    ),
                  ),
                ],
              )
            // If a sub-category IS selected, show the list of stories
            : FutureBuilder<List<Story>>(
                future: _storiesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No stories found.'));
                  } else {
                    final stories = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: stories.length,
                      itemBuilder: (context, index) {
                        final story = stories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoryDetailsScreen(story: story),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  story.imageUrl,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 160,
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
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      ),
    );
  }
}
