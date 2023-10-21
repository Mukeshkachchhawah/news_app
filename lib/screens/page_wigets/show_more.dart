import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../usnews_bloc/usnews_bloc.dart';
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
        title: Text("Indian News"),
      ),
      body: BlocBuilder<UsnewsBloc, UsnewsState>(
        builder: (context, state) {
          if (state is UsnewsLodingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsnewsErrorState) {
            return Center(
              child: Text("Errror"),
            );
          } else if (state is UsnewsLodadeState) {
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
                              mTitile: state.usNewsModel.articles![index].title,
                              mName: state.usNewsModel.articles![index].author,
                              mDesc: state
                                  .usNewsModel.articles![index].description,
                              mNeswUrl: state.usNewsModel.articles![index].url,
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

                /*  
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowNews(
                              mImg:
                                  state.usNewsModel.articles![index].urlToImage,
                              mTitile: state.usNewsModel.articles![index].title,
                              mName: state.usNewsModel.articles![index].author,
                              mDesc: state
                                  .usNewsModel.articles![index].description,
                              mNeswUrl: state.usNewsModel.articles![index].url,
                              mPublishedAt: state
                                  .usNewsModel.articles![index].publishedAt,
                            ),
                          ));
                    },
                    child: Container(
                      // height: media.size.height * .3,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(state
                                  .usNewsModel.articles![index].urlToImage
                                  .toString()),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 250),
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network(
                                          // state.mdata.articles![index].url!, fit: BoxFit.cover,
                                          "https://static.vecteezy.com/system/resources/previews/010/146/777/original/world-map-icon-sign-symbol-design-free-png.png",
                                          scale: 90,
                                        ),
                                        Text(
                                          "Word",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.usNewsModel.articles![index].author
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.usNewsModel.articles![index].title
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              */
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
