class Karya {
  String title;
  String artist;
  String yearMade;
  String description;
  String imageAsset;
  List<String> likes = [];

  Karya({
    required this.title,
    required this.artist,
    required this.yearMade,
    required this.description,
    required this.imageAsset,
  });

  void toggleLike(String? userEmail) {
    if (likes.contains(userEmail)) {
      likes.remove(userEmail);
    } else {
      likes.add(userEmail!);
    }
  }
}
