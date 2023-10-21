import 'package:flutter/material.dart';
import 'package:news_application/screens/bottom_bar_page/bottombar.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://www.dreshare.com/wp-content/uploads/2023/04/Shubhankar-Mishra.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 650, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Stay Informed\nfrom Day One",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Discover the Latest News with our\nSeamless Onbording Experience6",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBarPage(),
                        ));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff0006E9)),
                    child: Center(
                      child: Text(
                        "Getting Started",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
