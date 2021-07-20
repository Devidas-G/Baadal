import 'package:baadal/Global%20variables.dart';
import 'package:baadal/Pages/FilesPage.dart';
import 'package:baadal/Pages/ProfilePage.dart';
import 'package:baadal/Pages/UploadPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage(bool darkMode, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page=0;
  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CupertinoTabBar(
        onTap: navigationTapped,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: page==0?myColor:Colors.grey[700],),),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file,color: page==1?myColor:Colors.grey[700],)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded,color: page==2?myColor:Colors.grey[700],)),
      ],),
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          Container(
            child: FilesPage(),
          ),
          Container(
            child: UploadPage(),
          ),
          Container(
            child: ProfilePage(),
          ),
        ],
      ),
    );
  }
}
