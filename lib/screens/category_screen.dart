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

  @override
  Widget build(BuildContext context) {
    final subCategories = _getSubCategories(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sub-Categories',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final subCategory = subCategories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: () => _onSubCategorySelected(subCategory),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSubCategory == subCategory
                            ? Theme.of(context).primaryColor
                            : Colors.grey[800],
                      ),
                      child: Text(subCategory),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            if (_selectedSubCategory != null)
              Expanded(
                child: FutureBuilder<List<Story>>(
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
                      return ListView.builder(
                        itemCount: stories.length,
                        itemBuilder: (context, index) {
                          final story = stories[index];
                          return ListTile(
                            leading: Image.network(
                              story.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(story.title),
                            subtitle: Text(story.author),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StoryDetailsScreen(story: story),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

List<String> _getSubCategories(String category) {
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
