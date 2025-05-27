class Movie{
  final String id;
  final String title;
  final String imgUrl;
  final String rating;
  final String genre;
  final String duration;

  Movie({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.rating,
    required this.genre,
    required this.duration
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      id: json['id'] ?? "empty", 
      title: json['title'] ?? "notitle", 
      imgUrl: (json['images'] != null && json['images'].isNotEmpty) 
      ? json['images'][0] : 'https:/placehold.co/600x400', 
      rating: (json['rating'] ?? "Empty"),
      genre: (json['genre'] ?? "Empty"),
      duration: (json ['duration'] ?? "Empty")
    );
  }
}