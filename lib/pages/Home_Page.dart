//import 'package:firebase_auth/firebase_auth.dart';
import 'package:faculty_colloboration/pages/LoginPage.dart';
import 'package:flutter/material.dart';

//import 'package:research_app/Pages/register_page.dart';


class HomePage extends StatefulWidget {

  final Function()? onTap;
  const HomePage({super.key, required this.onTap});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  void SignOut(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(onTap: widget.onTap),
    ),
    ); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Home Page "),
      actions: [
        IconButton(
          onPressed: SignOut, 
          icon: Icon(Icons.logout))
      ],),
    );
  }
}