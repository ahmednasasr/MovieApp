import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:movieapp/models/movie_header_model.dart';

class ApiManger{
  static Future<MovieHeaders> getPopular()async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc");

    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);

    return MovieHeaders.fromJson(json);
  }
}