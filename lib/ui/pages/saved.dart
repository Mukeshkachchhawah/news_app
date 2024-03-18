

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/bloc_state_management/saved_news_bloc/saved_bloc_bloc.dart';

import 'package:news_application/util/app_colors.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    super.initState();
    context.read<SavedBlocBloc>().add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Saved News",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<SavedBlocBloc, SavedBlocState>(
        builder: (context, state) {
          if (state is SavedBlocLadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SavedBlocErrorState) {
            return const Center(
              child: Text("Error "),
            );
          } else if (state is SavedBlocLoadedState) {
            var savedNews = state.arrData;
            savedNews = savedNews.reversed.toList();
            if (savedNews.isEmpty) {
              return const Center(
                child: Text("No Saved News"),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: state.arrData.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      onTap: () {
                       /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowNews(
                                  //  mName: state.arrData.toString(),
                                  //   mImg: state.arrData.toString(),
                                  //   mNeswUrl: state.arrData.toString(),
                                  //   mPublishedAt: state.arrData.toString(),
                                  ),
                            )); */
                      },
                      leading: Container(
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  savedNews[index]["news_imgurl"])),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      title: Text(
                        savedNews[index]["news_title"],
                        maxLines: 2,
                      ),
                      subtitle: Text(
                        savedNews[index]["news_desc"],
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: 'SF UI Text',
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            context.read<SavedBlocBloc>().add(DeleteNewsEvent(
                                id: savedNews[index]["news_id"].toString()));
                            context.read<SavedBlocBloc>().add(GetNewsEvent());
                          },
                          icon: const Icon(
                            Icons.delete_outlined,
                            color: AppColor.redColor,
                            size: 30,
                          )),
                    );
                  });
            }
          } else {
            return const Center(
              child: Text("data"),
            );
          }
        },
      ),
    );
  }
}
