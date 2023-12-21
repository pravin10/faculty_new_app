import 'package:faculty_colloboration/screens/add_post_screen.dart';
import 'package:faculty_colloboration/screens/feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/Utils/colors.dart';
import 'package:faculty_colloboration/Utils/global_variable.dart';
class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
  @override
  Widget build(BuildContext context) {
    return FeedScreen();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     drawer: FacultyAppDrawer(),
  //     body: PageView(
  //       controller: pageController,
  //       onPageChanged: onPageChanged,
  //       children: homeScreenItems,
  //     ),
  //     bottomNavigationBar: CupertinoTabBar(
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.home,
  //             color: (_page == 0) ? primaryColor : secondaryColor,
  //           ),
  //           label: '',
  //           backgroundColor: primaryColor,
  //         ),
  //         BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.search,
  //               color: (_page == 1) ? primaryColor : secondaryColor,
  //             ),
  //             label: '',
  //             backgroundColor: primaryColor),
  //         BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.add_circle,
  //               color: (_page == 2) ? primaryColor : secondaryColor,
  //             ),
  //             label: '',
  //             backgroundColor: primaryColor),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.favorite,
  //             color: (_page == 3) ? primaryColor : secondaryColor,
  //           ),
  //           label: '',
  //           backgroundColor: primaryColor,
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.person,
  //             color: (_page == 4) ? primaryColor : secondaryColor,
  //           ),
  //           label: '',
  //           backgroundColor: primaryColor,
  //         ),
  //       ],
  //       onTap: navigationTapped,
  //       currentIndex: _page,
  //     ),
  //   );
  // }
}
