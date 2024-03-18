// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/ui/show_news/open_url.dart';
import 'package:news_application/util/ui_helper.dart';
import '../../bloc_state_management/saved_news_bloc/saved_bloc_bloc.dart';

/// global declarer
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
      {super.key,
      String? mImg,
      String? mName,
      String? mAuthor,
      String? mTitle,
      String? mDesc,
      String? mContent,
      String? mimgUrl,
      String? mNewsUrl,
      String? mPublishedAt}) {
    img = mImg;
    name = mName;
    author = mAuthor;
    title = mTitle;
    desc = mDesc;
    content = mContent;
    imgUrl = mimgUrl;
    newsUrl = mNewsUrl;
    publishedAt = mPublishedAt;
  }

  @override
  State<ShowNews> createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  bool isIconChange = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Show News"),
        actions: [
          IconButton(
              onPressed: () {
                int id = generateId();
                String temp1 =
                    name == null ? "Unknown Publisher • " : "${name} • ";
                String temp2 = author == null ? "Unknown Author" : "${author}";
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

                setState(() {
                  isIconChange = true;
                });
              },
              icon: isIconChange
                  ? const Icon(Icons.download_done_outlined)
                  : const Icon(Icons.download_for_offline_outlined)),
          wSpace(width: 5)
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingTitle(),
                  hSpace(),
                  Text(
                    "$title",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  hSpace(),
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
                  hSpace(),
                  Text(desc == null ? "desc" : desc.toString(),
                      style: textStyleFonts18b(context)),
                  hSpace(height: 20.0),
                  const Text(
                    "Read More at",
                    style: TextStyle(fontSize: 18),
                  ),
                  hSpace(),
                  InkWell(
                      onTap: () {
                        String Unlinks = newsUrl.toString();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpenUrl(curl: Unlinks),
                            ));
                      },
                      child: Text(
                        newsUrl == null ? "Not Url" : newsUrl.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )),
                  hSpace(),
                  Text(
                    "Published at : ${publishedAt.toString()}",
                    style: textStyleFonts14b(context),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  int generateId() {
    int timeStamp = DateTime.now().microsecondsSinceEpoch;
    return timeStamp;
  }

  Widget headingTitle() {
    return Column(
      children: [
        Text(name == null ? "Cnn" : "$name"),
        wSpace(),
      ],
    );
  }
}
