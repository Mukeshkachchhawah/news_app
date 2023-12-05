import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/saved_news_bloc/bloc/saved_bloc_bloc.dart';
import 'package:news_application/screens/channels/channels.dart';
import 'package:news_application/screens/show_news/shownew.dart';
import 'package:news_application/ui_helper.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SavedBlocBloc>().add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Saved News",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<SavedBlocBloc, SavedBlocState>(
        builder: (context, state) {
          if (state is SavedBlocLodingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SavedBlocErrorState) {
            return Center(
              child: Text("Error "),
            );
          } 
          else if (state is SavedBlocLodadeState) {
            var savedNews = state.arrData;
            savedNews = savedNews.reversed.toList();
            if (savedNews.isEmpty) {
              return Center(
                child: Text("No Saved News"),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.arrData.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                /*    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowNews(
         /*                    mName: state.arrData.toString(),
                            mImg: state.arrData.toString(),
                            mNeswUrl: state.arrData.toString(),
                            mPublishedAt: state.arrData.toString(), */
                            ),
                          )); */
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              savedNews[index]["news_imgurl"])),

                                      /* 
                                             '${state.mdata.articles![index].urlToImage}' ??
                              "https://cdn.pixabay.com/photo/2016/04/24/22/30/monitor-1350918_1280.png",
                                             */
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  hSpacer(),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          savedNews[index]["news_title"],
                                          maxLines: 2,
                                        ),
                                        hSpacer(),
                                        Text(
                                          savedNews[index]["news_desc"],
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontFamily: 'SF UI Text',
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        context.read<SavedBlocBloc>().add(
                                            DeleteNewsEvent(
                                                id: savedNews[index]["news_id"]
                                                    .toString()));
                                        context
                                            .read<SavedBlocBloc>()
                                            .add(GetNewsEvent());
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: Text("data"),
            );
          }
        },
      ),
    );
    ;
  }
}
