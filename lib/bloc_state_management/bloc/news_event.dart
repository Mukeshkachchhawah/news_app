// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'news_bloc.dart';

@immutable
class NewsEvent {}

class TopHeadlinesNews extends NewsEvent {
  String? CAT;
  TopHeadlinesNews({this.CAT});
}
