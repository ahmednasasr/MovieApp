import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:movieapp/models/details_model.dart';
import 'package:movieapp/models/morelikethis_model.dart';
import 'package:movieapp/models/movies_search.dart';
import 'package:movieapp/models/realese_model.dart';
import 'package:movieapp/models/recommendation_model.dart';
import 'package:movieapp/screens/details_screen.dart';
import '../models/movie_header_model.dart';

class mainProvider extends ChangeNotifier{
  int selectedTab =0;
  final List<MovieResult> movieresult = [];

  onSelectedTap(value){
    selectedTab=value;
    notifyListeners();
  }

   Future<MovieHeaders> getPopular()async {

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
  Future<RealeseModel> getRealese()async {

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

   OnSaved(RealeseResults movie) {
    movie.isSaved =!movie.isSaved;
    print('isSaved: ${movie.isSaved}');
  notifyListeners();
  }
  OnSavedRecommendation(RecommendationResults movie) {
    movie.isSavedRecomm =! movie.isSavedRecomm;
    print('isSaved: ${movie.isSavedRecomm}');
  notifyListeners();
  }


 Future<RecommendationModel> getRecommendation()async {

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


Future<Detailsmodel> getDetails(int movieId)async {

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
  Future<MorelikethisModel> getMoreLikeThis(int movieId)async {

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
 Future<MoviesSearch> movieSearch(String query)async {

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


}