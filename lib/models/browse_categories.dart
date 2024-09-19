class BrowseCategories {
  BrowseCategories({
      this.genres,});

  BrowseCategories.fromJson(dynamic json) {
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(BrowseGenres.fromJson(v));
      });
    }
  }
  List<BrowseGenres>? genres;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BrowseGenres {
  BrowseGenres({
      this.id, 
      this.name,});

  BrowseGenres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}