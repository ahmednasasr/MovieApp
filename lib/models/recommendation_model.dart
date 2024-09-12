class RecommendationModel {
  int? page;
  List<RecommendationResults>? results;
  int? totalPages;
  int? totalResults;

  RecommendationModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  RecommendationModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = json['results']
          .map<RecommendationResults>((v) => RecommendationResults.fromJson(v))
          .toList();
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class RecommendationResults {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  bool isSavedRecomm;

  RecommendationResults({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.isSavedRecomm = false,
  });

  RecommendationResults.fromJson(Map<String, dynamic> json)
    : adult = json['adult'],
    backdropPath = json['backdrop_path'],
    genreIds = List<int>.from(json['genre_ids']),
    id = json['id'],
    originalLanguage = json['original_language'],
    originalTitle = json['original_title'],
    overview = json['overview'],
    popularity = json['popularity'],
    posterPath = json['poster_path'],
    releaseDate = json['release_date'],
    title = json['title'],
    video = json['video'],
    voteAverage = json['vote_average'],
    voteCount = json['vote_count'],
    isSavedRecomm =false;


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
