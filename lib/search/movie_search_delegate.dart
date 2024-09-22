import 'package:flutter/material.dart';
import 'package:movieapp/apis/api_manger.dart';
import 'package:movieapp/models/movies_search.dart';
import 'package:movieapp/screens/details_screen.dart';
import 'package:provider/provider.dart';

import '../manger/main_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<MoviesSearch>(
      future: ApiManger.movieSearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error '));
        } else if (!snapshot.hasData || snapshot.data?.results?.isEmpty == true) {
          return Center(child: Text('No results found.'));
        } else {
          var results = snapshot.data?.results ?? [];
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var result = results[index];
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500${result.posterPath}', // عرض صورة الفيلم
                  fit: BoxFit.cover,
                ),
                title: Text(result.title!),
                subtitle: Text(result.releaseDate ?? 'N/A'),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Please enter a movie name to search'),
      );
    }

    return FutureBuilder<MoviesSearch>(
      future: ApiManger.movieSearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('has error'));
        } else if (!snapshot.hasData || snapshot.data?.results?.isEmpty == true) {
          return Center(child: Text('No results found.'));
        } else {
          var results = snapshot.data?.results ?? [];
          return ListView.separated(
            separatorBuilder: (context, index) {
               return Divider(height: 1,);
            },
            itemCount: results.length,
            itemBuilder: (context, index) {
              var result = results[index];
              return InkWell(
                onTap: (){
                  Navigator.pushNamed(context, DetailsScreen.routename,arguments: results[index]
                  );
                },
                child: Card(
                  color: Colors.transparent,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Container(
                      height: 400,
                      child: ListTile(
                        leading:SizedBox(
                          height: 200,
                          width: 100,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${result.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(result.title!,style: TextStyle(color: Colors.white),),
                        subtitle: Text(result.releaseDate ??"",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

}
