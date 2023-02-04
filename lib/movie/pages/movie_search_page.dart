import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pahe_app/movie/pages/movie_detail_page.dart';
import 'package:pahe_app/movie/providers/movie_search_provider.dart';
import 'package:pahe_app/widget/image_widget.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Cari Film";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return Center(child: Text("Search Movies"));
        }

        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.movies.isEmpty) {
          return Center(child: Text("Movie Not Found"));
        }

        if (provider.movies.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.all(20),
            itemBuilder: (_, index) {
              final movie = provider.movies[index];
              return Stack(
                children: [
                  Row(
                    children: [
                      ImageNetworkWidget(
                        imageSrc: movie.posterPath,
                        height: 120,
                        width: 80,
                        radius: 10,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: TextStyle(
                                fontFamily: "Lexend",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              movie.overview,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          close(context, null);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) {
                              return MovieDetailPage(id: movie.id);
                            },
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 10),
            itemCount: provider.movies.length,
          );
        }

        return Center(child: Text("Another Error On Search Movies"));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
