import 'package:flutter/material.dart';
import 'package:movieapp/manger/main_provider.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<mainProvider>(context, listen: false);
    provider.getMoive();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<mainProvider>(context, listen: false).getMoive();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Consumer<mainProvider>(
        builder: (context, provider, child) {
          if (provider.savedmovie.isEmpty) {
            return const Center(child: Text('No saved movies.',style: TextStyle(color: Colors.white),));
          }
          return ListView.builder(
            itemCount: provider.savedmovie.length,
            itemBuilder: (context, index) {
              var movie = provider.savedmovie[index];
              return ListTile(
                leading: Image.network(movie.posterPath ?? ''),
                title: Text(movie.title ?? 'No title'),
                subtitle: Text('Release Date: ${movie.releaseDate ?? ''}'),
              );
            },
          );
        },
      ),
    );
  }
}