
class Story {
  final String title;
  final String author;
  final String imageUrl;
  final String storyAssetPath;

  Story({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.storyAssetPath,
  });
}

final List<Story> topRatedStories = [
  Story(
    title: 'The Last Stand',
    author: 'By Sarah Jones',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    storyAssetPath: 'lib/assets/stories/the_last_stand.json',
  ),
  Story(
    title: 'The Silent City',
    author: 'By David Chen',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    storyAssetPath: 'lib/assets/stories/the_silent_city.json',
  ),
  Story(
    title: 'Echoes of the Past',
    author: 'By Maria Garcia',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    storyAssetPath: 'lib/assets/stories/echoes_of_the_past.json',
  ),
];

final List<Story> latestReleases = [
  Story(
    title: 'Interstellar Odyssey',
    author: 'By ChatGPT',
    imageUrl: 'https.picsum.photos/seed/picsum/200/300',
    storyAssetPath: 'lib/assets/stories/interstellar_odyssey.json',
  ),
  Story(
    title: 'Cybernetic Dreams',
    author: 'By Ava Williams',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    storyAssetPath: 'lib/assets/stories/cybernetic_dreams.json',
  ),
  Story(
    title: 'The Gilded Cage',
    author: 'By James Brown',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    storyAssetPath: 'lib/assets/stories/the_gilded_cage.json',
  ),
];
