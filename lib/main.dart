import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/api_helper/india_news_api.dart';
import 'package:news_application/database/save_data.dart';
import 'package:news_application/bloc_state_management/saved_news_bloc/saved_bloc_bloc.dart';

import 'package:news_application/ui/onbording/splash_screens.dart';
import 'package:news_application/bloc_state_management/usnews_bloc/usnews_bloc.dart';

import 'api_helper/us_news_api.dart';
import 'bloc_state_management/bloc/news_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => NewsBloc(indiaNewApi: IndiaNewApi()),
    ),
    BlocProvider(
      create: (context) => UsnewsBloc(usNewsApi: UsNewsApi()),
    ),
    BlocProvider(
      create: (context) => SavedBlocBloc(savedNewsDB: SavedNewsDB()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );

    // Set the system navigation bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(backgroundColor: Colors.deepOrange)
        //   primarySwatch: Colors.cyan,
      ),
      home: const SplashScreens(),
    );
  }
}
