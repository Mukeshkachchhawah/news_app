import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_state_management/usnews_bloc/usnews_bloc.dart';
import '../show_news/shownew.dart';

class ShowMoreNews extends StatefulWidget {
  const ShowMoreNews({super.key});

  @override
  State<ShowMoreNews> createState() => _ShowMoreNewsState();
}

class _ShowMoreNewsState extends State<ShowMoreNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Indian News"),
      ),
      body: BlocBuilder<UsnewsBloc, UsnewsState>(
        builder: (context, state) {
          if (state is UsnewsLadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsnewsErrorState) {
            return const Center(
              child: Text("Error"),
            );
          } else if (state is UsnewsLoadedState) {
            return ListView.builder(
              //   scrollDirection: Axis.horizontal,
              itemCount: state.usNewsModel.articles!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowNews(
                              mImg:
                                  state.usNewsModel.articles![index].urlToImage,
                              mTitle: state.usNewsModel.articles![index].title,
                              mName: state.usNewsModel.articles![index].author,
                              mDesc: state
                                  .usNewsModel.articles![index].description,
                              mNewsUrl: state.usNewsModel.articles![index].url,
                              mPublishedAt: state
                                  .usNewsModel.articles![index].publishedAt,
                            ),
                          ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(state
                                      .usNewsModel.articles![index].urlToImage
                                      .toString()),
                                  fit: BoxFit.cover)),
                        ),
                        title: Text(state.usNewsModel.articles![index].title
                            .toString()),
                        subtitle: Text(state
                            .usNewsModel.articles![index].description
                            .toString()),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
