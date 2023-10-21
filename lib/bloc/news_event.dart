part of 'news_bloc.dart';

@immutable
class NewsEvent {}

class TopHeadlinesNews extends NewsEvent {
  String? CAT;
  TopHeadlinesNews({this.CAT});
}
