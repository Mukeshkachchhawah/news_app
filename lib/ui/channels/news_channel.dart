import 'package:flutter/material.dart';
import 'package:news_application/ui/pages/home.dart';

import '../../view_news.dart';
import 'channels.dart';

class NewsChannel extends StatefulWidget {
  const NewsChannel({super.key});

  @override
  State<NewsChannel> createState() => _NewsChannelState();
}

class _NewsChannelState extends State<NewsChannel> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
          },
          child: const Icon(Icons.arrow_back, color: Colors.black,)),
        backgroundColor: Colors.white,elevation: 0,
        title: const Text("News Channels", style: TextStyle(color: Colors.black),),
      ),
        body: channelCard());
  }

  Widget channelCard() {
    return ListView.builder(
      itemCount: NewsChannelImage.newsChannelsList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: () {
               openChannel(url: NewsChannelImage.newsChannelsList[index]['url']);
                //  NewsChannelImage.newsChannelsList[index]['url'];
              },
              child: Card(
                child: Center(
                  child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "${NewsChannelImage.newsChannelsList[index]['img']}"),
                              fit: BoxFit.fill)),
                      //  child: Image.asset("${NewsChannelImage.newsChannelsList[]['img']}"),
                    ),
                    title: Text(
                      "${NewsChannelImage.newsChannelsList[index]['name']}",
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openChannel({required String url}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => Channel(cUrl: url)));
  }
}


