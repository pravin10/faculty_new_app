
import 'package:faculty_colloboration/pages/Profile_Page.dart';
import 'package:faculty_colloboration/pages/login_with_monile.dart';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/Components/text_field.dart';
import 'package:faculty_colloboration/Components/button.dart';
import 'package:faculty_colloboration/pages/register_page.dart';


class LoginPage extends StatefulWidget {

  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  
  void SignIn() async{
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage(),
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
                    'Welcome back, you have been missed',
                    style: TextStyle(color: Colors.grey[700]),),
                  
                  const SizedBox(height: 25),
                  //email textfile
                  MyTextField(controller: emailTextController, hintText:'Email', obscureText: false),
      
                  const SizedBox(height: 25),
                  //password textfile
                  MyTextField(controller: passwordTextController, hintText:'Password', obscureText: true),
      
                  const SizedBox(height: 25), 
                  //signin button
                  MyButton(onTap: SignIn, 
                  text: 'Sign in'),
                  const SizedBox(height: 25),
                  Text('OR',style: TextStyle(fontSize: 20, color: Colors.grey),),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Signin with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginWithMobile(onTap: null),
                            ));
                          }
                          ,
                        child: Text(
                          'Mobile number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            color: Colors.blue),
                            )
                          ),
                    ],),
                  const SizedBox(height: 25),                  
                  //go to register page 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage(onTap: null)),
                            );
                          }
                          ,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            color: Colors.blue),
                            )
                          ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}