import 'package:flutter/material.dart';
import 'package:movieapp/search/movie_search_delegate.dart';

import '../../models/movies_search.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff514F4F),
        leading: IconButton(onPressed: (){
          showSearch(context: context,
              delegate: MovieSearchDelegate()
          );
        }, icon: Icon(Icons.search,color: Colors.white,)),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),bottomLeft:Radius.circular(100)
            ,topRight: Radius.circular(100),topLeft: Radius.circular(100)
            )
        ),
        elevation: 0,
      ),
      body: Center(
        child: Image.asset("assets/images/Group 22.png"),
      ),
    );
  }
}