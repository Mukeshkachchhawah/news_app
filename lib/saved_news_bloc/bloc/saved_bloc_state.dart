part of 'saved_bloc_bloc.dart';

@immutable
class SavedBlocState {}

class SavedBlocInitialState extends SavedBlocState {}

class SavedBlocLodingState extends SavedBlocState {}

class SavedBlocErrorState extends SavedBlocState {
  String notSaved;
  SavedBlocErrorState({required this.notSaved});
}

class SavedBlocLodadeState extends SavedBlocState {
  List<Map<String, dynamic>> arrData;

  SavedBlocLodadeState({required this.arrData});
}
