import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_application/datamodal/us_nes_model/us_news_modal.dart';

import '../../api_helper/us_news_api.dart';

part 'usnews_event.dart';
part 'usnews_state.dart';

class UsnewsBloc extends Bloc<UsnewsEvent, UsnewsState> {
  UsNewsApi usNewsApi;
  UsnewsBloc({required this.usNewsApi}) : super(UsnewsInitialState()) {
    on<GetUseNewsEvent>((event, emit) async {
      emit(UsnewsLadingState());
      var response = await usNewsApi.getUsNew();

      if (response != null) {
        emit(UsnewsLoadedState(usNewsModel: USNewsModel.fromJson(response)));
      } else {
        emit(UsnewsErrorState(errorMes: "InterNet Error"));
      }
    });
  }
}
