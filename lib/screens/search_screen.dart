// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService apiService = ApiService();
  List<Movie> searchResults = [];
  bool isLoading = false;
  String currentQuery = '';
  
  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    setState(() {
      isLoading = true;
      currentQuery = query;
    });

    try {
      final movies = await apiService.searchMovies(query);
      setState(() {
        searchResults = movies;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mencari film')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Cari film...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          onChanged: (value) {
            _searchMovies(value);
          },
        ),
      ),
      body: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(),
          Expanded(
            child: searchResults.isEmpty
                ? Center(
                    child: Text(
                      currentQuery.isEmpty
                          ? 'Cari film favorit Anda'
                          : 'Film tidak ditemukan',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: searchResults[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}