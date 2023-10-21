part of 'news_bloc.dart';

@immutable
class NewsState {}

class NewsInitialState extends NewsState {}

class NewsInitialLodingState extends NewsState {}

class NewsInitialErrorgState extends NewsState {
  String erroMes;
  NewsInitialErrorgState({required this.erroMes});
}

class NewsInitialLodedState extends NewsState {
  JsonDataModal mdata;
  NewsInitialLodedState({required this.mdata});
}
