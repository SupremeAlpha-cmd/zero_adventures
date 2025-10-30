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

final List<Story> topRatedStories = [
  Story(
    title: 'The Lost Temple of Zara',
    author: 'Alex Ranger',
    imageUrl: 'https://picsum.photos/seed/zara/400/600',
    storyAssetPath: 'lib/assets/stories/the_lost_temple_of_zara.json',
    subCategory: 'Adventure',
  ),
  Story(
    title: 'Cybernetic Dreams',
    author: 'Nova Byte',
    imageUrl: 'https://picsum.photos/seed/cyber/400/600',
    storyAssetPath: 'lib/assets/stories/cybernetic_dreams.json',
    subCategory: 'Sci-Fi',
  ),
  Story(
    title: 'The Gilded Cage',
    author: 'Isabella Sterling',
    imageUrl: 'https://picsum.photos/seed/cage/400/600',
    storyAssetPath: 'lib/assets/stories/the_gilded_cage.json',
    subCategory: 'Dystopian',
  ),
];

final List<Story> latestReleases = [
  Story(
    title: 'Interstellar Odyssey',
    author: 'Captain Eva',
    imageUrl: 'https://picsum.photos/seed/odyssey/400/600',
    storyAssetPath: 'lib/assets/stories/interstellar_odyssey.json',
    subCategory: 'Sci-Fi',
  ),
  Story(
    title: "The Alchemist's Secret",
    author: 'Elias Thorne',
    imageUrl: 'https://picsum.photos/seed/alchemist/400/600',
    storyAssetPath: 'lib/assets/stories/the_alchemists_secret.json',
    subCategory: 'Fantasy',
  ),
  Story(
    title: 'Echoes of the Void',
    author: 'Kaelen',
    imageUrl: 'https://picsum.photos/seed/void/400/600',
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
    imageUrl: 'https://picsum.photos/seed/stand/400/600',
    storyAssetPath: 'lib/assets/stories/the_last_stand.json',
    subCategory: 'Action',
  ),
  Story(
    title: "Jester's Gambit",
    author: 'Barnaby',
    imageUrl: 'https://picsum.photos/seed/gambit/400/600',
    storyAssetPath: 'lib/assets/stories/jesters_gambit.json',
    subCategory: 'Comedy',
  ),
  Story(
    title: 'The Crimson Affair',
    author: 'Lady Annalise',
    imageUrl: 'https://picsum.photos/seed/affair/400/600',
    storyAssetPath: 'lib/assets/stories/the_crimson_affair.json',
    subCategory: 'Romance',
  ),
  Story(
    title: 'Shadows of the Past',
    author: 'Detective Miles',
    imageUrl: 'https://picsum.photos/seed/shadows/400/600',
    storyAssetPath: 'lib/assets/stories/shadows_of_the_past.json',
    subCategory: 'Mystery',
  ),
  Story(
    title: "The Ronin's Path",
    author: 'Kenshin',
    imageUrl: 'https://picsum.photos/seed/ronin/400/600',
    storyAssetPath: 'lib/assets/stories/the_ronins_path.json',
    subCategory: 'Shonen',
  ),
  Story(
    title: 'Whispers of the Heart',
    author: 'Sakura',
    imageUrl: 'https://picsum.photos/seed/whispers/400/600',
    storyAssetPath: 'lib/assets/stories/whispers_of_the_heart.json',
    subCategory: 'Shojo',
  ),
];
