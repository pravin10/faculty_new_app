
import 'package:faculty_colloboration/pages/OTP.dart';
import 'package:faculty_colloboration/pages/Profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/Components/text_field.dart';
import 'package:faculty_colloboration/Components/button.dart';
import 'package:faculty_colloboration/pages/register_page.dart';


class LoginWithMobile extends StatefulWidget {

  final Function()? onTap;
  const LoginWithMobile({super.key, required this.onTap});

  @override
  State<LoginWithMobile> createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile> {
  final mobileTextController = TextEditingController();
  
  void SignIn() async{
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OtpClass() ,
    ));
    
    
   }

  // // display message to user for the error
  // void displayMessage(String Message){
  //   showDialog(
  //     context: context, 
  //     builder: (context)=> AlertDialog(
  //       title: Text(Message),
  //     ),);

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color to white or any desired color
        elevation: 0, // Remove the shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black, // Set the icon color
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    Icons.person_outlined,
                    size: 100,
                    color: Colors.blue[300],
                    ),
                  const SizedBox(height: 25),
                  //welcome back message
                  Text(
                    'Signin with mobile number',
                    style: TextStyle(color: Colors.grey[700]),),
                  
                  const SizedBox(height: 25),
                  //email textfile
                  MyTextField(controller: mobileTextController, hintText:'Email', obscureText: false),
      
      
                  const SizedBox(height: 25), 
                  //signin button
                  MyButton(onTap: SignIn, 
                  text: 'Send Code'),
      
                  const SizedBox(height: 25),                  
                ],
              ),
            ),
          ),
        ),
    );
  }
}