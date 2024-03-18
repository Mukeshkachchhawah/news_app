// ignore_for_file: must_be_immutable

part of 'news_bloc.dart';

@immutable
class NewsState {}

class NewsInitialState extends NewsState {}

class NewsInitialLoadingState extends NewsState {}

class NewsInitialErrorState extends NewsState {
  String errorMes;
  NewsInitialErrorState({required this.errorMes});
}

class NewsInitialLadedState extends NewsState {
  JsonDataModal data;
  NewsInitialLadedState({required this.data});
}
