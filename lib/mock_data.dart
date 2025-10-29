
class Story {
  final String title;
  final String author;
  final String imageUrl;

  Story({required this.title, required this.author, required this.imageUrl});
}

final List<Story> topRatedStories = [
  Story(
    title: 'The Last Stand',
    author: 'By Sarah Jones',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
  ),
  Story(
    title: 'The Silent City',
    author: 'By David Chen',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
  ),
  Story(
    title: 'Echoes of the Past',
    author: 'By Maria Garcia',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
  ),
];

final List<Story> latestReleases = [
  Story(
    title: 'The Phoenix Project',
    author: 'By Ken Adams',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
  ),
  Story(
    title: 'Cybernetic Dreams',
    author: 'By Ava Williams',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
  ),
  Story(
    title: 'The Gilded Cage',
    author: 'By James Brown',
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
  ),
];
