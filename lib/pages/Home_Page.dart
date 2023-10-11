import 'package:faculty_colloboration/pages/LoginPage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  final Function()? onTap;

  HomePage({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.pink[200],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate to the login page when the logout icon is clicked
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(onTap: onTap)),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome to the Home Page!"),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
