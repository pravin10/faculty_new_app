import 'dart:async';
import 'package:faculty_colloboration/screens/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:faculty_colloboration/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}
// final _router = GoRouter(routes: [
//   GoRoute(path: '/', builder: (context, state) => HomeScreen(), routes: [
//     GoRoute(
//       path: 'sign-in',
//       builder: (context, state) {
//         return SignInScreen(
//           actions: [
//             ForgotPasswordAction(((context, email) {
//               final uri = Uri(
//                   path: '/sign-in/forgot-password',
//                   queryParameters: <String, String?>{
//                     'email': email,
//                   });
//               context.push(uri.toString());
//             })),
//             AuthStateChangeAction(((context, state) {
//               if (state is SignedIn || state is UserCreated) {
//                 var user = (state is SignedIn)
//                     ? state.user
//                     : (state as UserCreated).credential.user;
//                 if (user == null) {
//                   return;
//                 }
//                 if (state is UserCreated) {
//                   user.updateDisplayName(user.email?.split('@')[0]);
//                 }
//                 if (!user.emailVerified) {
//                   user.sendEmailVerification();
//                   const snackBar = SnackBar(
//                     content: Text(
//                         "Please check your email to varify yout email address"),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }
//                 context.pushReplacement('/');
//               }
//             })),
//           ],
//         );
//       },
//       routes: [
//         GoRoute(
//           path: 'forgot-password',
//           builder: (context, state) {
//             final arguments = state.uri.queryParameters;
//             return ForgotPasswordScreen(
//               email: arguments['email'],
//               headerMaxExtent: 200,
//             );
//           },
//         ),
//       ],
//     ),
//     GoRoute(
//       path: 'profile',
//       builder: (context, state) {
//         return ProfileScreen(
//           providers: const [],
//           actions: [
//             SignedOutAction((context) {
//               context.pushReplacement('/');
//             })
//           ],
//         );
//       },
//     )
//   ])
// ]);
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
class MyRouter extends StatelessWidget {
  const MyRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home:SignupScreen()
    );
  }
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
        MaterialPageRoute(builder: (context) => MyRouter()));
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