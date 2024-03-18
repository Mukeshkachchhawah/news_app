import 'package:flutter/material.dart';
import 'package:news_application/ui/pages/home.dart';
import 'package:news_application/ui/pages/saved.dart';

import '../channels/news_channel.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int selectIndex = 0;

  final List<Widget> _pageList = [
    const HomePage(),
    const NewsChannel(),
    const Saved(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: onTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_tv_rounded), label: "Channel"),
            BottomNavigationBarItem(
                icon: Icon(Icons.save_outlined), label: "Saved"),
          ]),
    );
  }

  void onTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
