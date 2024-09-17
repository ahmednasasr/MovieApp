import 'package:flutter/material.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:movieapp/screens/browse_screen.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/screens/search_screen.dart';
import 'package:movieapp/screens/watchlist_screen.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatelessWidget {
  static const String routename="homescreen";
   LayoutScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<mainProvider>(context);
    List<Widget> screens=[
      HomeScreen(),
      SearchScreen(),
      BrowseScreen(),
      WatchlistScreen()
    ];

    var theme=Theme.of(context);
    return  Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value){
              provider.onSelectedTap(value);
            },
              currentIndex: provider.selectedTab,
              selectedLabelStyle: TextStyle(color: Colors.yellowAccent),
              selectedItemColor: Colors.yellowAccent,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black12,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home" ),
                BottomNavigationBarItem(icon: Icon(Icons.search,),label: "Search" ),
                BottomNavigationBarItem(icon: Icon(Icons.category),label: "Browse" ),
                BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Watch List", ),

              ]),
          body: screens[provider.selectedTab]
        );

  }
}
