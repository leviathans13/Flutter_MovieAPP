// lib/models/movie.dart
class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      // Pastikan overview tidak null dengan memberikan string kosong sebagai default
      overview: json['overview'] ?? 'Tidak ada sinopsis tersedia',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Tanggal tidak tersedia',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}