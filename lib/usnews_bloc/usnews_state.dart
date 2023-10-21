part of 'usnews_bloc.dart';

@immutable
abstract class UsnewsState {}

class UsnewsInitialState extends UsnewsState {}

class UsnewsLodingState extends UsnewsState {}

class UsnewsErrorState extends UsnewsState {
  String? erroMes;
  UsnewsErrorState({required this.erroMes});
}

class UsnewsLodadeState extends UsnewsState {
  USNewsModel usNewsModel;
  UsnewsLodadeState({required this.usNewsModel});
}
