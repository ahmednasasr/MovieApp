import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:movieapp/models/browse_movies.dart';
import 'package:movieapp/models/details_model.dart';
import 'package:movieapp/models/morelikethis_model.dart';
import 'package:movieapp/models/movies_search.dart';
import 'package:movieapp/models/realese_model.dart';
import 'package:movieapp/models/recommendation_model.dart';
import 'package:movieapp/services/firebase.dart';
import '../apis/api_manger.dart';
import '../models/browse_categories.dart';
import '../models/movie_header_model.dart';

class mainProvider extends ChangeNotifier{
  int selectedTab =0;
  bool watched =false;
  List<RecommendationResults> savedmovie = [];
   List<RecommendationResults> recommendationMovie=[];
  List<BrowseGenres> browsecategore =[];
  List<browseMoviesResult> browsemovieresult=[];
  Map<int ,bool> watchedMovies ={};




  onSelectedTap(value){
    selectedTab=value;
    notifyListeners();
  }




  Future<void> getBrowse()async{
   var date =await ApiManger.getBrowesCategories();
   browsecategore = date.genres??[];
   notifyListeners();
  }



  void OnSavedRecommendation(RecommendationResults movie) {
    movie.isSavedRecomm = !movie.isSavedRecomm;
    notifyListeners();

    if (movie.isSavedRecomm) {
      FirebaseFunctions.saveRecommendationToFirebase(movie);
    }
  }



// الجزء الخاص بحفظ ال movie
///////////////////////////////////////
  void OnSavedRealease(RealeseResults movie) {
    notifyListeners();

    if (movie.isSaved) {
      FirebaseFunctions.saveRealaeseToFirebase(movie);
    }
  }
  void toggleWatched(int movieId) {
    watchedMovies[movieId] = !(watchedMovies[movieId] ?? false);
    notifyListeners();
  }

  bool isWatched(int movieId) {
    return watchedMovies[movieId] ?? false;
  }
///////////////////////////////////////////

  Future<void> SavedMovies() async {
    savedmovie= await FirebaseFunctions.getSavedMovies();
    notifyListeners();
  }





  Future<void> getMoive() async {
    try {
      savedmovie = await FirebaseFunctions.getSavedMovies();
      notifyListeners();
    } catch (e) {
      print("Error fetching saved movies: $e");
    }
  }




  Future<void> getRecommendationMovie()async{
   var data =await ApiManger.getRecommendation();
   recommendationMovie =data.results!;
   notifyListeners();
  }



  Future<void> getCatMovie()async{
    var data =await ApiManger.getBrowesMovies();
    browsemovieresult =data.results??[];
    notifyListeners();
  }


}