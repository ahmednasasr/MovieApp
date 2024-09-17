import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/models/morelikethis_model.dart';
import 'package:movieapp/models/movie_header_model.dart';
import 'package:movieapp/models/realese_model.dart';
import 'package:movieapp/models/recommendation_model.dart';
import 'package:provider/provider.dart';

import '../models/movies_search.dart';

class DetailsScreen extends StatefulWidget {
  static const String routename = "details";
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    int? movieId;
    String? title;
    if (arguments is Results) {
      movieId = arguments.id;
      title = arguments.title;
    } else if (arguments is RealeseResults) {
      movieId = arguments.id;
      title = arguments.title;
    } else if (arguments is RecommendationResults) {
      movieId = arguments.id;
      title = arguments.title;
    }
    else if (arguments is MovieResult) {
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          movieDetails?.releaseDate ?? "",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: 130,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${movieDetails?.posterPath ?? ""}",
                                fit: BoxFit.cover,
                              ),
                            ),
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
                        FutureBuilder<MorelikethisModel>(
                            future: provider.getMoreLikeThis(movieId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(child: Text("Error loading data"));
                              } else if (snapshot.hasData) {
                                List<MoreLikeThisResult> results = snapshot.data?.results??[];
                                return Column(
                                  children: [
                                    Container(
                                      color: Color(0xff282A28),
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Recommendation',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        viewportFraction: 0.3,
                                        enableInfiniteScroll: true,
                                        enlargeCenterPage: false,
                                        height: 210.0,
                                      ),
                                      items: results.map((e) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                                color: Color(0xff282A28),
                                                child: Column(children: [
                                                  Stack(clipBehavior: Clip.none, children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 150,
                                                      child: CachedNetworkImage(
                                                        imageUrl:"https://image.tmdb.org/t/p/w500${e.posterPath ?? ''}",
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                    ),
                                                   Icon(
                                                        Icons.bookmark,
                                                        color:  Color(0xff514F4F),
                                                      ),
                                                  ]),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellowAccent,
                                                      ),
                                                      Text(
                                                        "${e.voteAverage}".substring(0, 3),
                                                        style:
                                                        TextStyle(color: Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                        e.title ?? "",
                                                        style: TextStyle(
                                                            color: Colors.white, fontSize: 15),
                                                      )),
                                                  Expanded(
                                                      child: Text(
                                                        e.releaseDate ?? "".substring(0, 10),
                                                        style: TextStyle(
                                                            color: Colors.white, fontSize: 13),
                                                      )),
                                                ]));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                );
                              } else {
                                return const Center(child: Text("No data available"));
                              }
                            })
        
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
