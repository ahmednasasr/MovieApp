import 'package:flutter/material.dart';
import 'package:movieapp/core/theme.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/screens/details_screen.dart';
import 'package:movieapp/screens/layout_screen.dart';
import 'package:movieapp/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
      },
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: SplashScreen(),
    );
  }
}