import 'package:faculty_colloboration/screens/feed_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/screens/add_post_screen.dart';
import 'package:faculty_colloboration/screens/profile_screen.dart';
import 'package:faculty_colloboration/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const  FeedScreen(),
  const SearchBar(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
