import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies/src/models/movies_model.dart';

class MoviesProvider {
  String _apiKey = 'cd4eecbfed96359ff30d72387a78d8d7';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final data = json.decode(response.body);

    final movies = new Movies.fromJsonList(data['results']);

    return movies.items;
  }

  Future<List<Movie>> getInCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processResponse(url);
  }


  Future<List<Movie>> getPopular() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _language});

    return await _processResponse(url);

  }
}
