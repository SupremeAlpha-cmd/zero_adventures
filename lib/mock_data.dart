class Story {
  final String title;
  final String author;
  final String imageUrl;
  final String storyAssetPath;
  final String subCategory;

  Story({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.storyAssetPath,
    required this.subCategory,
  });
}

const String _firebaseBaseUrl = 'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/';

final List<Story> topRatedStories = [
  Story(
    title: 'The Lost Temple of Zara',
    author: 'Alex Ranger',
    imageUrl: '${_firebaseBaseUrl}the_lost_temple_of_zara.png?alt=media',
    storyAssetPath: 'lib/assets/stories/the_lost_temple_of_zara.json',
    subCategory: 'Adventure',
  ),
  Story(
    title: 'Cybernetic Dreams',
    author: 'Nova Byte',
    imageUrl: '${_firebaseBaseUrl}cybernetic_dreams.png?alt=media',
    storyAssetPath: 'lib/assets/stories/cybernetic_dreams.json',
    subCategory: 'Sci-Fi',
  ),
  Story(
    title: 'The Gilded Cage',
    author: 'Isabella Sterling',
    imageUrl: '${_firebaseBaseUrl}the_gilded_cage.png?alt=media',
    storyAssetPath: 'lib/assets/stories/the_gilded_cage.json',
    subCategory: 'Dystopian',
  ),
];

final List<Story> latestReleases = [
  Story(
    title: 'Interstellar Odyssey',
    author: 'Captain Eva',
    imageUrl: '${_firebaseBaseUrl}interstellar_odyssey.png?alt=media',
    storyAssetPath: 'lib/assets/stories/interstellar_odyssey.json',
    subCategory: 'Sci-Fi',
  ),
  Story(
    title: "The Alchemist's Secret",
    author: 'Elias Thorne',
    imageUrl: '${_firebaseBaseUrl}the_alchemists_secret.png?alt=media',
    storyAssetPath: 'lib/assets/stories/the_alchemists_secret.json',
    subCategory: 'Fantasy',
  ),
  Story(
    title: 'Echoes of the Void',
    author: 'Kaelen',
    imageUrl: '${_firebaseBaseUrl}echoes_of_the_void.png?alt=media',
    storyAssetPath: 'lib/assets/stories/echoes_of_the_void.json',
    subCategory: 'Horror',
  ),
];

final List<Story> allStories = [
  ...topRatedStories,
  ...latestReleases,
  Story(
    title: 'The Last Stand',
    author: 'General Armitage',
    imageUrl: '${_firebaseBaseUrl}the_last_stand.png?alt=media',
    storyAssetPath: 'lib/assets/stories/the_last_stand.json',
    subCategory: 'Action',
  ),
  Story(
    title: "Jester's Gambit",
    author: 'Barnaby',
    imageUrl: '${_firebaseBaseUrl}jesters_gambit.png?alt=media',
    storyAssetPath: 'lib/assets/stories/jesters_gambit.json',
    subCategory: 'Comedy',
  ),
  Story(
    title: 'The Crimson Affair',
    author: 'Lady Annalise',
    imageUrl: '${_firebaseBaseUrl}the_crimson_affair.png?alt=media',
    storyAssetPath: 'lib/assets/stories/the_crimson_affair.json',
    subCategory: 'Romance',
  ),
  Story(
    title: 'Shadows of the Past',
    author: 'Detective Miles',
    imageUrl: '${_firebaseBaseUrl}shadows_of_the_past.png?alt=media',
    storyAssetPath: 'lib/assets/stories/shadows_of_the_past.json',
    subCategory: 'Mystery',
  ),
  Story(
    title: "The Ronin's Path",
    author: 'Kenshin',
    imageUrl: '${_firebaseBaseUrl}the_ronins_path.png?alt=media',
    storyAssetPath: 'lib/assets/stories/the_ronins_path.json',
    subCategory: 'Shonen',
  ),
  Story(
    title: 'Whispers of the Heart',
    author: 'Sakura',
    imageUrl: '${_firebaseBaseUrl}whispers_of_the_heart.png?alt=media',
    storyAssetPath: 'lib/assets/stories/whispers_of_the_heart.json',
    subCategory: 'Shojo',
  ),
];
