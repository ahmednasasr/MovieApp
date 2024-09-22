import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/theme.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/screens/browse/category_movies.dart';
import 'package:movieapp/screens/details_details_screen.dart';
import 'package:movieapp/screens/details_screen.dart';
import 'package:movieapp/screens/home/layout_screen.dart';
import 'package:movieapp/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => mainProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        SplashScreen.routename:(_)=>SplashScreen(),
        LayoutScreen.routename:(_)=>LayoutScreen(),
        DetailsScreen.routename:(_)=>DetailsScreen(),
        DetailsDetailsScreen.routename:(_)=>DetailsDetailsScreen(),
        CategoryMovies.routename:(_)=>CategoryMovies(),
      },
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: SplashScreen(),
    );
  }
}