import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_application/api_helper/india_news_api.dart';
import 'package:news_application/datamodal/ind_news_modal/jsonmodal.dart';


part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  IndiaNewApi indiaNewApi;
  NewsBloc({required this.indiaNewApi}) : super(NewsInitialState()) {
    on<TopHeadlinesNews>((event, emit) async {
      emit(NewsInitialLoadingState());

      var response = await indiaNewApi.getApi(
          CAT: event.CAT == null ? "general" : event.CAT!);

      if (response != null) {
        emit(NewsInitialLadedState(data: JsonDataModal.fromJson(response)));
      } else {
        emit(NewsInitialErrorState(errorMes: "Internet Error"));
      }
    });
  }
}
