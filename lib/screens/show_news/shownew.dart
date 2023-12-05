import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/bloc/news_bloc.dart';
import 'package:news_application/screens/show_news/open_url.dart';
import 'package:news_application/ui_helper.dart';

import '../../custom_widget/custom_button.dart';
import '../../saved_news_bloc/bloc/saved_bloc_bloc.dart';

/// globla decaler
String? img;
String? name;
String? author;
String? title;
String? desc;
String? content;
String? imgUrl;
String? newsUrl;
String? publishedAt;

class ShowNews extends StatefulWidget {
  ShowNews(
      {String? mImg,
      String? mName,
      String? mAuthor,
      String? mTitile,
      String? mDesc,
      String? mContent,
      String? mimgUrl,
      String? mNeswUrl,
      String? mPublishedAt}) {
    img = mImg;
    name = mName;
    author = mAuthor;
    title = mTitile;
    desc = mDesc;
    content = mContent;
    imgUrl = mimgUrl;
    newsUrl = mNeswUrl;
    publishedAt = mPublishedAt;
  }

  @override
  State<ShowNews> createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HedarBar(),
                  hSpacer(),
                  HedingTitle(),
                  hSpacer(),
                  Text(
                    "${title}",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  hSpacer(),
                  Container(
                    height: media.size.height * .25,
                    width: media.size.height * 9,
                    decoration: BoxDecoration(
                        // color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage(img == null
                                ? "https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png"
                                : img.toString()),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  hSpacer(),
                  Text(
                    desc == null ? "desc" : desc.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  hSpacer(mheight: 20.0),
                  Text(
                    "Read More at",
                    style: TextStyle(fontSize: 18),
                  ),
                  hSpacer(),
                  InkWell(
                      onTap: () {
                        String Urilinks = newsUrl.toString();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpenUrl(curl: Urilinks),
                            ));
                      },
                      child: Text(
                        newsUrl == null ? "Not Url" : newsUrl.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )),
                  hSpacer(),
                  Text("Published at : ${publishedAt.toString()}")
                ],
              ),
            )
          ],
        ),
        floatingActionButton: SizedBox(
          height: media.size.height * .06,
          width: media.size.width * .7,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite_border),
                Text("9.4k"),
                Icon(Icons.message),
                Text("9.4k"),
                CircleAvatar(
                  child: Icon(Icons.headset_rounded),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget HedarBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIcon(
                icons: Icon(Icons.arrow_back),
                ontap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        Text(
          "Show News",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIcon(
                icons: Icon(Icons.download_for_offline),
                ontap: () {
                  int id = generateId();
                  String temp1 =
                      name == null ? "Unknown Publisher • " : "${name} • ";
                  String temp2 =
                      author == null ? "Unknown Author" : "${author}";
                  String details = "$temp1$temp2";
                  String mImg = img.toString();

                  context.read<SavedBlocBloc>().add(AddNewsEvent(
                      id: id.toString(),
                      details: details,
                      title: title == null ? "No Title" : title.toString(),
                      description:
                          desc == null ? "No Description" : desc.toString(),
                      content:
                          content == null ? "No Content" : content.toString(),
                      imgUrl: mImg == "null"
                          ? "https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png"
                          : mImg.toString(),
                      newsUrl: newsUrl.toString(),
                      pub: "Published at : ${publishedAt.toString()}"));
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  int generateId() {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    return timeStamp;
  }

  Widget HedingTitle() {
    return Column(
      children: [
        Text("${name == null ? "Cnn" : "${name}"}"),
        wSpacer(),
      ],
    );
  }
}
