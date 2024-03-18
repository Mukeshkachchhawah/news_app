// ignore_for_file: must_be_immutable

part of 'saved_bloc_bloc.dart';

@immutable
class SavedBlocState {}

class SavedBlocInitialState extends SavedBlocState {}

class SavedBlocLadingState extends SavedBlocState {}

class SavedBlocErrorState extends SavedBlocState {
  String notSaved;
  SavedBlocErrorState({required this.notSaved});
}

class SavedBlocLoadedState extends SavedBlocState {
  List<Map<String, dynamic>> arrData;

  SavedBlocLoadedState({required this.arrData});
}
