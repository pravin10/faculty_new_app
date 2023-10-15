import 'package:faculty_colloboration/pages/Home_Page.dart';
import 'package:flutter/material.dart';



class MyAppDrawer extends StatelessWidget{
  const MyAppDrawer({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'App',
      home: DrawerPage(),
    );
  }
}

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"), // Replace with the user's name
            accountEmail: Text("john.doe@example.com"), // Replace with the user's email
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_pic.jpg'), // Replace with the user's profile picture
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Handle home tap
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Job'),
            onTap: () {
              // Handle job tap
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
          // Add more list items as needed
        ],
      ),
    );
  }
}


class ItemOnePage extends StatelessWidget{

  ItemOnePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
        child: Text('Go to previous screen'),
        onPressed:(){
          Navigator.pop(context);//what is context
        },
      ) 
      ),
    );
  }
}