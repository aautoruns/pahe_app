import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pahe_app/movie/models/movie_model.dart';
import 'package:pahe_app/movie/pages/movie_detail_page.dart';
import 'package:pahe_app/movie/providers/movie_get_discover_provider.dart';
import 'package:pahe_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:pahe_app/movie/providers/movie_get_top_rated_provider.dart';
import 'package:pahe_app/widget/item_movie_widget.dart';

enum TypeMovie { discover, topRated, nowPlaying }

class MoviePaginationPage extends StatefulWidget {
  MoviePaginationPage({super.key, required this.type});

  final TypeMovie type;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  // ignore: unused_field
  final PagingController<int, MovieModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      switch (widget.type) {
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
        case TypeMovie.topRated:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPagination(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
        case TypeMovie.nowPlaying:
          context.read<MovieGetNowPlayingProvider>().getNowPlayingWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (_) {
          switch (widget.type) {
            case TypeMovie.discover:
              return Text(
                'Discover Movies',
                style: TextStyle(fontWeight: FontWeight.w600),
              );
            case TypeMovie.topRated:
              return Text(
                'IMDb Highest Rating',
                style: TextStyle(fontWeight: FontWeight.w600),
              );
            case TypeMovie.nowPlaying:
              return Text(
                'Now Playing In Cinemas',
                style: TextStyle(fontWeight: FontWeight.w600),
              );
          }
        }),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey[900],
        elevation: 0.5,
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(15.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) => ItemMovieWidget(
            movie: item,
            heightBackdrop: 270,
            widthBackdrop: double.infinity,
            heightPoster: 150,
            widthPoster: 100,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return MovieDetailPage(id: item.id);
                  },
                ),
              );
            },
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
