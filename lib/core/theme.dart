import 'package:flutter/material.dart';

class AppTheme{
  static final ThemeData theme =ThemeData(
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black12
    ),
    // appBarTheme: AppBarTheme(
    //   backgroundColor: Color(0xff514F4F),
    //   iconTheme: IconThemeData(
    //     color: Colors.white,
    //   ),
    //   shape: OutlineInputBorder(
    //       borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),bottomLeft:Radius.circular(100)
    //           ,topRight: Radius.circular(100),topLeft: Radius.circular(100)
    //       )
    //   ),
    //   titleTextStyle: TextStyle(
    //     color: Colors.white,
    //     fontSize: 20,
    //   ),
    // ),
  );
}