import 'package:flutter/material.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/screens/details_screen.dart';
import 'package:provider/provider.dart';

class CategoryMovies extends StatefulWidget {
  static const String routename='Categorymovies';
  const CategoryMovies({super.key});

  @override
  State<CategoryMovies> createState() => _CategoryMoviesState();
}

class _CategoryMoviesState extends State<CategoryMovies> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<mainProvider>(context, listen: false);
    provider.getCatMovie();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<mainProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: provider.browsemovieresult.length,
        itemBuilder: (context, index) {
          var result = provider.browsemovieresult;
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, DetailsScreen.routename,arguments: provider.browsemovieresult[index]);
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
                      'https://image.tmdb.org/t/p/w500${result[index].posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(result[index].title!,style: TextStyle(color: Colors.white),),
                  subtitle: Text(result[index].releaseDate ??"",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),
        );
      },),
    );
  }
}
