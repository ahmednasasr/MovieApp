import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieapp/models/realese_model.dart';
import 'package:movieapp/models/recommendation_model.dart';


class FirebaseFunctions{

  static FirebaseFirestore firestore =FirebaseFirestore.instance;

  static CollectionReference<RecommendationResults> mainFunction(){
    return firestore.collection("movies").withConverter(fromFirestore: (snapshot, options) {
      return RecommendationResults.fromJson(snapshot.data()!);
    }, toFirestore: (value, options) {
      return value.toJson();
    },);
  }

  static Future<void> saveMovie(RecommendationResults movie)async{
    var ref = mainFunction();
    var docref = ref.doc();
    movie.id = docref.id as int?;
    await docref.set(movie);
  }

  static Future<void> saveRecommendationToFirebase(RecommendationResults movie) async {
    try {
      await firestore.collection('movies').doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'releaseDate': movie.releaseDate,
        'voteAverage': movie.voteAverage,
        'isSavedRecomm': movie.isSavedRecomm,
      });
      print("Movie saved to Firebase successfully");
    } catch (e) {
      print("Failed to save movie: $e");
    }
  }
  static Future<void> saveRealaeseToFirebase(RealeseResults movie) async {
    try {
      await firestore.collection('movies').doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'releaseDate': movie.releaseDate,
        'voteAverage': movie.voteAverage,
        'isSaved': true,
      });
      print("Movie saved to Firebase successfully");
    } catch (e) {
      print("Failed to save movie: $e");
    }
  }


  static Future<List<RecommendationResults>> getSavedMovies() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('movies')
          .where('isSavedRecomm', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) {
        final data = doc.data();
        return RecommendationResults.fromJson(data);
      })
          .toList();
    } catch (e) {
      print("$e");
      return [];
    }
  }





}