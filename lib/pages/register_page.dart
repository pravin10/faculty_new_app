import 'package:flutter/material.dart';
import 'package:faculty_colloboration/pages/LoginPage.dart';
import '../Components/text_field.dart';
import '../Components/button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
  //just called function to create state of register page
}

class _RegisterPageState extends State<RegisterPage> {

  // Below are all the fields of the page that will be asked from user during account creation

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final mobileNumberTextController = TextEditingController();
  final universityTextController = TextEditingController();
  final departmentTextController = TextEditingController();

  void signup() {
  
  // After filling all the fields the user will be navigated to the next page 
  // but we need to create account of the user and store the information of the user into the database.
  // checking validity of the data filled i.e, the format of the data is correct.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(onTap: widget.onTap)),
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    Icons.person_outlined,
                    size: 100,
                    color: Colors.blue[300],
                  ),
                  const SizedBox(height: 50),
                  //welcome back message
                  Text(
                    'Create an account for you',
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 25),
                  //first name textfield
                  MyTextField(
                    controller: firstNameTextController,
                    hintText: 'First Name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),
                  //last name textfield
                  MyTextField(
                    controller: lastNameTextController,
                    hintText: 'Last Name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),
                  //email textfile
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),
                  //mobile number textfield
                  MyTextField(
                    controller: mobileNumberTextController,
                    hintText: 'Mobile Number',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),
                  //University textfield
                  MyTextField(
                    controller: universityTextController,
                    hintText: 'University',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),
                  //Department textfield
                  MyTextField(
                    controller: departmentTextController,
                    hintText: 'Department',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),
                  //password textfield
                  MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),
                  //Confirm password
                  MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),

                  //signup button
                  MyButton(
                    onTap: signup,
                    text: 'Sign Up',
                  ),

                  const SizedBox(height: 25),
                  //go to login page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage(onTap: null)),
                              );
                            },
                        child: Text(
                          'Login now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
