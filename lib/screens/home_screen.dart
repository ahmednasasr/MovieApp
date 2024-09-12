import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/models/movie_header_model.dart';
import 'package:movieapp/models/recommendation_model.dart';
import 'package:provider/provider.dart';

import '../models/realese_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<mainProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<MovieHeaders>(
              future: provider.getPopular(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error loading data"));
                } else if (snapshot.hasData) {
                  List<Results> results = snapshot.data?.results ?? [];

                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 340.0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                    ),
                    items: results.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              child: Column(children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 260,
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 140,
                                  left: 180,
                                  child: Icon(
                                    Icons.play_circle_filled,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                ),
                                Positioned(
                                  top: 130,
                                  left: 7,
                                  child: Container(
                                    height: 200,
                                    width: 129,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                movie.originalTitle ?? "No title",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                movie.releaseDate ?? "No title",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]));
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<RealeseModel>(
              future: provider.getRealese(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error loading data"));
                } else if (snapshot.hasData) {
                  List<RealeseResults> results = snapshot.data!.results ?? [];
                  return Column(
                    children: [
                      Container(
                        color: Color(0xff282A28),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'New Realaese',
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
                          height: 200.0,
                        ),
                        items: results.map((movie) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  color: Color(0xff282A28),
                                  child: Column(children: [
                                    Stack(clipBehavior: Clip.none, children: [
                                      Container(
                                        width: double.infinity,
                                        height: 180,
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/w500${movie.posterPath ?? ''}",
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          provider.OnSaved(movie);
                                        },
                                        child: Icon(
                                          movie.isSaved
                                              ? Icons.bookmark
                                              : Icons.add_box,
                                          size: 25,
                                          color: movie.isSaved
                                              ? Colors.yellow
                                              : Color(0xff514F4F),
                                        ),
                                      )
                                    ])
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
              },
            ),
            SizedBox(height: 10),
            FutureBuilder<RecommendationModel>(
                future: provider.getRecommendation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading data"));
                  } else if (snapshot.hasData) {
                    List<RecommendationResults> results =
                        snapshot.data!.results ?? [];
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
                                          child: Image.network(
                                            "https://image.tmdb.org/t/p/w500${e.posterPath ?? ''}",
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            provider.OnSavedRecommendation(e);
                                          },
                                          child: Icon(
                                            e.isSavedRecomm
                                                ? Icons.bookmark
                                                : Icons.add_box,
                                            size: 25,
                                            color: e.isSavedRecomm
                                                ? Colors.yellow
                                                : Color(0xff514F4F),
                                          ),
                                        )
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
          ],
        ),
      ),
    );
  }
}
