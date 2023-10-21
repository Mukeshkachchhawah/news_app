import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_application/api_helper/india_news_api.dart';
import 'package:news_application/datamodal/ind_news_modal/jsonmodal.dart';

import '../api_helper/urls.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  IndiaNewApi indiaNewApi;
  NewsBloc({required this.indiaNewApi}) : super(NewsInitialState()) {
    on<TopHeadlinesNews>((event, emit) async {
      emit(NewsInitialLodingState());

      var response = await indiaNewApi.getApi(
          CAT: event.CAT == null ? "general" : event.CAT!);

      if (response != null) {
        emit(NewsInitialLodedState(mdata: JsonDataModal.fromJson(response)));
      } else {
        emit(NewsInitialErrorgState(erroMes: "Internet Error"));
      }
    });
  }
}
