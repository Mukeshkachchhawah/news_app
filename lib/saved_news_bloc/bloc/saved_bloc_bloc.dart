import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../database/save_data.dart';

part 'saved_bloc_event.dart';
part 'saved_bloc_state.dart';

class SavedBlocBloc extends Bloc<SavedBlocEvent, SavedBlocState> {
  SavedNewsDB savedNewsDB;
  SavedBlocBloc({required this.savedNewsDB}) : super(SavedBlocInitialState()) {
    on<AddNewsEvent>((event, emit) async {
      emit(SavedBlocLodingState());
      var response = savedNewsDB.addNews(
          id: event.id,
          details: event.details,
          title: event.title,
          description: event.description,
          content: event.content,
          imgUrl: event.imgUrl,
          newsUrl: event.newsUrl,
          pub: event.pub);
      if (response == true) {
        var newsData = await savedNewsDB.fetchSavedNews();
        emit(SavedBlocLodadeState(arrData: newsData));
      } else {
        emit(SavedBlocErrorState(notSaved: "Not Found Data"));
      }
    });

    on<GetNewsEvent>((event, emit) async {
      emit(SavedBlocLodingState());

      var newsData = await savedNewsDB.fetchSavedNews();

      if (newsData.isNotEmpty) {
        emit(SavedBlocLodadeState(arrData: newsData));
      } else {
        emit(SavedBlocErrorState(notSaved: "No Saved News"));
      }
    });

    on<DeleteNewsEvent>((event, emit) async {
      emit(SavedBlocLodingState());
      var newsData = await savedNewsDB.deleteNews(event.id);
      if (newsData == true) {
        var removData = await savedNewsDB.fetchSavedNews();
        emit(SavedBlocLodadeState(arrData: removData));
      } else {
        emit(SavedBlocErrorState(notSaved: "Not Found Data"));
      }
    });
  }
}
