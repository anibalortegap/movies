import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor_model.dart';

class ActorsProvider {
  String _apiKey = 'cd4eecbfed96359ff30d72387a78d8d7';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Actor>> getCast(int movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);

    final data = json.decode(response.body);

    final cast = new Cast.fromJsonList(data['cast']);

    return cast.actors;
  }
}
