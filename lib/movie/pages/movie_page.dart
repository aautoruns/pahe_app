import 'package:flutter/material.dart';
import 'package:pahe_app/movie/components/movie_discover_component.dart';
import 'package:pahe_app/movie/components/movie_top_rated_component.dart';
import 'package:pahe_app/movie/components/movie_now_playing_component.dart';
import 'package:pahe_app/movie/pages/movie_pagination_page.dart';
import 'package:pahe_app/movie/pages/movie_search_page.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer__literals_to_create_immutables
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Text(
                  'PAHE+',
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: MovieSearchPage(),
                ),
                icon: Icon(Icons.search),
              ),
            ],
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.blueGrey[900],
          ),
          _widgetTitle(
            title: 'Discover Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoviePaginationPage(
                    type: TypeMovie.discover,
                  ),
                ),
              );
            },
          ),
          MovieDiscoverComponent(),
          _widgetTitle(
            title: 'IMDb Top 250',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoviePaginationPage(
                    type: TypeMovie.topRated,
                  ),
                ),
              );
            },
          ),
          MovieGetTopRatedComponent(),
          _widgetTitle(
            title: 'Now Playing In Cinemas',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoviePaginationPage(
                    type: TypeMovie.nowPlaying,
                  ),
                ),
              );
            },
          ),
          MovieNowPlayingComponent(),
          SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _widgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  _widgetTitle({required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              // ignore: prefer__ructors
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              // ignore: sort_child_properties_last
              child: Text(
                'Lihat Semua',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: StadiumBorder(),
                side: BorderSide(
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      );
}
