import 'package:faculty_colloboration/pages/Home_Page.dart';
import 'package:faculty_colloboration/pages/UpdateProfilePage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Function? onTap;

  ProfilePage({this.onTap});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.blue[300],
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the tap action
                  },
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // Background color
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "User Name",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  "University Name",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Department",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the update profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfilePage()),
                    );
                  },
                  child: Text("Update Profile"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color.fromARGB(255, 100, 181, 246)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
