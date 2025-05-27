class Movie{
  final int id;
  final String title;
  final String imgUrl;
  final String rating;
  final List<String> genre;
  final String createdAt;
  final String description;
  final String director;
  final List<String> cast;
  final String language;
  final String duration;


  Movie({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.rating,
    required this.genre,
    required this.createdAt,
    required this.description,
    required this.director,
    required this.cast,
    required this.language,
    required this.duration
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      id: int.tryParse(json['id']) ?? 0, 
      title: json['title'] ?? 'notitle', 
      imgUrl: json['imgUrl'] ?? 'empty', 
      rating: json['rating'] ?? 'empty',
      genre: List<String>.from(json['genre'] ?? []),
      createdAt: json['created_at'] ?? 'empty',
      description: json['description'] ?? 'empty',
      director: json['director'] ?? 'empty',
      cast: List<String>.from(json['cast'] ?? []),
      language: json['language'] ?? 'empty',
      duration: json ['duration'] ?? 'empty'
    );
  }
}