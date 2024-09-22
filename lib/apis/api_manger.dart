import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:movieapp/models/browse_movies.dart';
import 'package:movieapp/models/movie_header_model.dart';

import '../models/browse_categories.dart';
import '../models/details_model.dart';
import '../models/morelikethis_model.dart';
import '../models/movies_search.dart';
import '../models/realese_model.dart';
import '../models/recommendation_model.dart';

class ApiManger{
  static Future<MoviesSearch> movieSearch(String query)async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&language=en-US&page=1");

    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return MoviesSearch.fromJson(json);
  }

  static Future<MorelikethisModel> getMoreLikeThis(int movieId)async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/$movieId/similar?language=en-US&page=1&api_key=8eb3a86e7c546f5f0dfa5f6341dd0c0c");

    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return MorelikethisModel.fromJson(json);
  }

  static Future<Detailsmodel> getDetails(int movieId)async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/$movieId?language=en-US&api_key=8eb3a86e7c546f5f0dfa5f6341dd0c0c");

    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return Detailsmodel.fromJson(json);
  }

  static Future<RecommendationModel> getRecommendation()async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1");

    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return RecommendationModel.fromJson(json);
  }
  static Future<RealeseModel> getRealese()async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1");

    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return RealeseModel.fromJson(json);
  }

  static Future<MovieHeaders> getPopular()async {

    Uri url = Uri.parse("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc");

    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return MovieHeaders.fromJson(json);
  }
  
  static Future<BrowseCategories> getBrowesCategories()async {
    Uri url =Uri.parse("https://api.themoviedb.org/3/genre/movie/list?language=en");
    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return BrowseCategories.fromJson(json);
  }

  static Future<BrowseMovies> getBrowesMovies()async {
    Uri url =Uri.parse("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc");
    http.Response response = await http.get(url,
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZWIzYTg2ZTdjNTQ2ZjVmMGRmYTVmNjM0MWRkMGMwYyIsIm5iZiI6MTcyNjA2OTAyNC43ODEwOTQsInN1YiI6IjY2ZTFiNmRhZTNmNGYyMTQwY2NjOTVmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6qwsjHE_Gil15HR_4xhJgV8U6PDXpKOetblNIKQJdrk',
        'accept': 'application/json',
      },
    );
    var json = jsonDecode(response.body);

    return BrowseMovies.fromJson(json);
  }



}