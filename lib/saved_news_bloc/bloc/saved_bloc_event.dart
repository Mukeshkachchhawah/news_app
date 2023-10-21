part of 'saved_bloc_bloc.dart';

@immutable
 class SavedBlocEvent {}

class AddNewsEvent extends SavedBlocEvent {

  String id;
  String details;
  String title;
  String description;
  String content;
  String imgUrl;
  String newsUrl;
  String pub;

  AddNewsEvent(
      {required this.id,
      required this.details,
      required this.title,
      required this.description,
      required this.content,
      required this.imgUrl,
      required this.newsUrl,
      required this.pub});
}

class GetNewsEvent extends SavedBlocEvent {}

class DeleteNewsEvent extends SavedBlocEvent {
  String id;
  DeleteNewsEvent({required this.id});
}

