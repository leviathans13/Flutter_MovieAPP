// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie.dart';

class ApiService {
  final String apiKey = '5595166bc62a97bac52cd8ed779fc806';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies(int page) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/movie/popular?api_key=$apiKey&language=id-ID&page=$page'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat film populer');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Movie> fetchMovieDetail(int movieId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=id-ID'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Detail Film Response: $data'); // Untuk debugging
        return Movie.fromJson(data);
      } else {
        print('Error Status Code: ${response.statusCode}'); // Untuk debugging
        throw Exception('Gagal memuat detail film');
      }
    } catch (e) {
      print('Error fetching movie detail: $e'); // Untuk debugging
      throw Exception('Error: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/search/movie?api_key=$apiKey&language=id-ID&query=$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mencari film');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}