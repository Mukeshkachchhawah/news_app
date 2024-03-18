// ignore_for_file: must_be_immutable

part of 'usnews_bloc.dart';

@immutable
abstract class UsnewsState {}

class UsnewsInitialState extends UsnewsState {}

class UsnewsLadingState extends UsnewsState {}

class UsnewsErrorState extends UsnewsState {
  String? errorMes;
  UsnewsErrorState({required this.errorMes});
}

class UsnewsLoadedState extends UsnewsState {
  USNewsModel usNewsModel;
  UsnewsLoadedState({required this.usNewsModel});
}
