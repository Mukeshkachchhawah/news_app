// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/bloc_state_management/bloc/news_bloc.dart';
import 'package:news_application/categorilist.dart/categori_list.dart';
import 'package:news_application/ui/page_wigets/show_more.dart';
import 'package:news_application/util/app_colors.dart';
import 'package:news_application/util/ui_helper.dart';
import 'package:news_application/bloc_state_management/usnews_bloc/usnews_bloc.dart';

import '../show_news/shownew.dart';

/// globule variable media
var media;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<NewsBloc>().add(TopHeadlinesNews());
    context.read<UsnewsBloc>().add(GetUseNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
            actions: [
              AnimationSearchBar(
                  horizontalPadding: 10,
                  isBackButtonVisible: false,
                  centerTitle: "India News",
                  onChanged: (p0) {},
                  searchTextEditingController: searchController)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Breaking News",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ShowMoreNews(),
                                  ));
                            },
                            child: const Text("Show More")),
                      ],
                    ),
                    hSpace(),
                    breakingNew(),
                    hSpace(),
                    category(),
                    hSpace(),
                    const Text(
                      "Recommended for you",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    hSpace(),
                    recommended(),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget breakingNew() {
    return BlocBuilder<UsnewsBloc, UsnewsState>(
      builder: (context, state) {
        if (state is UsnewsLadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UsnewsErrorState) {
          return const Center(
            child: Text("Errors"),
          );
        } else if (state is UsnewsLoadedState) {
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
                    child: Container(
                      // height: media.size.height * .3,
                      width: media.size.width * .9,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(state.usNewsModel
                                          .articles![index].urlToImage ==
                                      null
                                  ? 'https://www.media-star.com/freebies/Null-Symbol-No-Symbol-By-Media-Star.png'
                                  : state
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
                                        const Text(
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
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.usNewsModel.articles![index].title
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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

  Widget category() {
    return SizedBox(
      height: 50,
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: CategoryList().category.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  String selectedCat = CategoryList().category[index]["name"]!;
                  context
                      .read<NewsBloc>()
                      .add(TopHeadlinesNews(CAT: selectedCat));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: media.size.width * .38,
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
                            CategoryList().category[index]['img']!,
                            height: 25,
                            width: 25,
                          ),
                          wSpace(width: 5.0),
                          Text(
                            CategoryList().category[index]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
      ),
    );
  }

  Widget recommended() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitialLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsInitialErrorState) {
          return const Center(
            child: Text("InterNet Error"),
          );
        } else if (state is NewsInitialLadedState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.data.articles!.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowNews(
                                mPublishedAt:
                                    state.data.articles![index].publishedAt,
                                mAuthor: state.data.articles![index].author,
                                mTitle: state.data.articles![index].title,
                                mImg: state.data.articles![index].urlToImage,
                                mDesc: state.data.articles![index].description,
                                mNewsUrl: state.data.articles![index].url,
                              )));
                },
                child: Card(
                  color: AppColor.witheColor,
                  elevation: 5,
                  child: ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          //   '${state.data.articles![index].urlToImage}',
                          state.data.articles![index].urlToImage == null
                              ? "https://www.media-star.com/freebies/Null-Symbol-No-Symbol-By-Media-Star.png"
                              : '${state.data.articles![index].urlToImage}',

                          //
                          fit: BoxFit.fill,
                        )),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.data.articles![index].title == null
                            ? "No Title"
                            : state.data.articles![index].title.toString()),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Sports")
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.data.articles![index].description == null
                            ? "No Description"
                            : state.data.articles![index].description
                                .toString()),
                        Text(state.data.articles![index].publishedAt == null
                            ? "No publish details"
                            : state.data.articles![index].publishedAt
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
