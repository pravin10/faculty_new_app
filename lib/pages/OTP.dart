import 'package:flutter/material.dart';
import 'package:faculty_colloboration/Components/text_field.dart';
import 'package:faculty_colloboration/Components/button.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpClass extends StatefulWidget {
  const OtpClass({super.key});

  @override
  State<OtpClass> createState() => _OtpClassState();
}

class _OtpClassState extends State<OtpClass> {
  final OtpTextController = TextEditingController();

  void SignIn() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OtpClass(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                  'OTP',
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 25),
                OTPTextField(
                  length: 5,
                  width: MediaQuery.of(context).size.width * 0.8, // Adjusted width to 80% of the screen width
                  fieldWidth: 50, // Adjusted field width
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),



                const SizedBox(height: 25),
                //signin button
                MyButton(onTap: SignIn, text: 'Signin'),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
