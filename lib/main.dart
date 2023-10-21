import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/api_helper/india_news_api.dart';
import 'package:news_application/database/save_data.dart';
import 'package:news_application/saved_news_bloc/bloc/saved_bloc_bloc.dart';

import 'package:news_application/screens/onbording/splash_screens.dart';
import 'package:news_application/usnews_bloc/usnews_bloc.dart';

import 'api_helper/us_news_api.dart';
import 'bloc/news_bloc.dart';


void main() {


  runApp( MultiBlocProvider(providers: [
    BlocProvider(create: (context) => NewsBloc(indiaNewApi: IndiaNewApi()),),
    BlocProvider(create: (context) => UsnewsBloc(usNewsApi: UsNewsApi()),),
    BlocProvider(create: (context) => SavedBlocBloc(savedNewsDB: SavedNewsDB()),)
  ], child: MyApp()));


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreens(),
    );
  }
}
