import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pahe_app/movie/pages/movie_page.dart';
import 'package:pahe_app/movie/providers/movie_get_discover_provider.dart';
import 'package:pahe_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:pahe_app/movie/providers/movie_get_top_rated_provider.dart';
import 'package:pahe_app/movie/providers/movie_search_provider.dart';

import 'injector.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(const App());
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'PAHE+',
        theme: ThemeData(
          fontFamily: 'Lexend',
          primarySwatch: Colors.blueGrey,
        ),
        home: MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
