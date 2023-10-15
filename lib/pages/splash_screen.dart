import 'dart:async';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/pages/LoginPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay to simulate a loading process
    Timer(Duration(seconds: 3), () {
      // Navigate to the new page after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(onTap: null)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wrap the Image.asset with a CircleAvatar
            CircleAvatar(
              radius: 75, // Adjust the radius as needed
              backgroundColor: Colors.blue, // Add background color if needed
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png', // Replace with the path to your logo image
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Faculty App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}