import 'package:flutter/material.dart';
import 'package:news_application/screens/pages/home.dart';
import 'package:news_application/screens/pages/saved.dart';

import '../channels/news_channel.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int selectIndex = 0;

  List<Widget> _pageList = [
    HomePage(),
    // Discover(),
    NewsChannel(),
    Saved(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: OnTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_tv_rounded), label: "Channel"),
            BottomNavigationBarItem(
                icon: Icon(Icons.save_outlined), label: "Saved"),
            //  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Profile")
          ]),
    );
  }

  void OnTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
