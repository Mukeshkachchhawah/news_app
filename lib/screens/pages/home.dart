import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/bloc/news_bloc.dart';
import 'package:news_application/categorilist.dart/categori_list.dart';
import 'package:news_application/custom_widget/custom_button.dart';
import 'package:news_application/screens/page_wigets/show_more.dart';
import 'package:news_application/ui_helper.dart';
import 'package:news_application/usnews_bloc/usnews_bloc.dart';

import '../show_news/shownew.dart';

/// globle varible media
var media;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late  TextEditingController SearchContoller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchContoller = TextEditingController();
    context.read<NewsBloc>().add(TopHeadlinesNews());
    context.read<UsnewsBloc>().add(GetUseNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffffffff),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffffffff),
            title: Text('Home', style: TextStyle(
              color: Colors.black
            ),
            ),
            actions: [
              AnimationSearchBar(
                
                centerTitle: "India News",
                onChanged: (p0) {
                
              }, searchTextEditingController: SearchContoller)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  hSpacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Breaking News",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowMoreNews(),));
                          },
                          child:
                              Text("Show More", style: TextStyle(fontSize: 16)))
                    ],
                  ),
                  hSpacer(),
                  BreakingNew(),
                  hSpacer(),
                  Categoriy(),
                  hSpacer(),
                  Text(
                    "Recommended for you",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  hSpacer(),
                  Recommended(),
                ],
              ),
            ),
          )),
    );
  }

  Widget BreakingNew() {
    return BlocBuilder<UsnewsBloc, UsnewsState>(
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
          return SizedBox(
            height: media.size.height * .25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.usNewsModel.articles!.length,
              itemBuilder: (context, index) {
                return Padding(
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
                      width: media.size.width * .9,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(state
                                  .usNewsModel.articles![index].urlToImage
                                  .toString()),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5)),
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
                                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget Categoriy() {
    return SizedBox(
        height: 45,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: CategoriList().categori.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    String selectedCat = CategoriList().categori[index]["name"]!;
                    context
                        .read<NewsBloc>()
                        .add(TopHeadlinesNews(CAT: selectedCat));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: media.size.width*.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //  Icon(Icons.abc),
                            Image.asset(
                              CategoriList().categori[index]['img']!,
                              height: 25,
                              width: 25,
                            ),
                            wSpacer(mWidth: 5.0),
                            Text(
                              CategoriList().categori[index]['name']!,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }

  Widget Recommended() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitialLodingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsInitialErrorgState) {
          return Center(
            child: Text("InterNet Error"),
          );
        } else if (state is NewsInitialLodedState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.mdata.articles!.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowNews(
                                mPublishedAt:
                                    state.mdata.articles![index].publishedAt,
                                mAuthor: state.mdata.articles![index].author,
                                mTitile: state.mdata.articles![index].title,
                                mImg: state.mdata.articles![index].urlToImage,
                                mDesc: state.mdata.articles![index].description,
                                mNeswUrl: state.mdata.articles![index].url,
                              )));
                },
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          '${state.mdata.articles![index].urlToImage}' ??
                              "https://cdn.pixabay.com/photo/2016/04/24/22/30/monitor-1350918_1280.png",
                          fit: BoxFit.cover,
                        )),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.mdata.articles![index].title == null
                            ? "No Title"
                            : state.mdata.articles![index].title.toString()),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Sports")
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.mdata.articles![index].description == null
                            ? "No Description"
                            : state.mdata.articles![index].description
                                .toString()),
                        Text(state.mdata.articles![index].publishedAt == null
                            ? "No publish details"
                            : state.mdata.articles![index].publishedAt
                                .toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
