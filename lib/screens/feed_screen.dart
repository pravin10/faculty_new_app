import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faculty_colloboration/Utils/colors.dart';
import 'package:faculty_colloboration/screens/add_post_screen.dart';
import 'package:faculty_colloboration/screens/job_page.dart';
import 'package:faculty_colloboration/screens/profile_screen.dart';
import 'package:faculty_colloboration/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/Utils/global_variable.dart';
import 'package:faculty_colloboration/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const FacultyAppDrawer(),
      backgroundColor: width > webScreenSize
          ? webBackgroundColor
          : primaryColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              centerTitle: false,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddPostScreen(), // Replace with your message screen widget
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(), // Replace with your message screen widget
                      ),
                    );
                  },
                  child: Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => MessageScreen(), // Replace with your message screen widget
                    //   ),
                    // );
                  },
                  child: Icon(
                    Icons.message,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 10,),
                
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.1 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FacultyAppDrawer extends StatelessWidget {
  const FacultyAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var userData = snapshot.data! as dynamic;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(userData['username']),
                    accountEmail: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          ),
                        );
                      },
                      child: Text("View Profile"),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(userData['photoUrl']),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedScreen(), // Replace FeedScreen with the actual name of your feed screen
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('Job'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobPage(), // Replace FeedScreen with the actual name of your feed screen
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Research'),
                    onTap: () {
                      // Handle research tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Scholarship'),
                    onTap: () {
                      // Handle scholarship tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('notifications'),
                    onTap: () {
                      // handle notification tap
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
