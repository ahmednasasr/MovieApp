import 'package:flutter/material.dart';
import 'package:movieapp/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routename="splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushNamed(context, LayoutScreen.routename);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage("assets/images/splash.png"),fit: BoxFit.cover,),
    );
  }
}
