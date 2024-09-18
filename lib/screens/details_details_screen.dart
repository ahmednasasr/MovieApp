import 'package:flutter/material.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/models/recommendation_model.dart';
import 'package:provider/provider.dart';

import '../models/morelikethis_model.dart';
import '../models/movie_header_model.dart';
import '../models/movies_search.dart';
import '../models/realese_model.dart';


class DetailsDetailsScreen extends StatefulWidget {
  static const String routename = "detailsdetails";
  const DetailsDetailsScreen({super.key});

  @override
  State<DetailsDetailsScreen> createState() => _DetailsDetailsScreenState();
}

class _DetailsDetailsScreenState extends State<DetailsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    int? movieId;
    String? title;


     if (arguments is MoreLikeThisResult) {
      movieId = arguments.id as int?;
      title = arguments.title;
    }

    if (movieId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("movieDetails"),
        ),
        body: const Center(child: Text("No details available")),
      );
    }


    var provider = Provider.of<mainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: provider.getDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading details'));
            } else {
              var movieDetails = snapshot.data;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 260,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${movieDetails?.posterPath ?? ""}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 170,
                              child: Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          movieDetails?.title ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          movieDetails?.releaseDate ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 200,
                                    width: 130,
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w500${movieDetails?.posterPath ?? ""}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add_box,
                                    size: 30,
                                  ),
                                ]),
                            Expanded(
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children:
                                    movieDetails?.genres?.map((e) {
                                      return Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color:  Color(0xff514F4F)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            e.name.toString(),
                                            style:  TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList() ?? [],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(movieDetails?.overview??"",style: TextStyle(color: Colors.white),),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star,color: Colors.yellowAccent,size: 25,),
                                      Text("${movieDetails?.voteAverage??""}".substring(0,3),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)

                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                      ]
                  )
              );
            }
          },
        ),
      ),
    );
  }
}
