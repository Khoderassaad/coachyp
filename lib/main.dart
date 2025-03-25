import 'package:coachyp/features/Posts/presentation/pages/HomePage.dart';
import 'package:coachyp/features/auth/presentation/pages/login.dart';
import 'package:coachyp/features/auth/presentation/pages/sign_up.dart';
import 'package:coachyp/features/auth/presentation/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/welcome.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(COACHY());
}

class COACHY extends StatefulWidget {
  const COACHY({super.key});

  @override
  State<COACHY> createState() => _COACHYState();
}

class _COACHYState extends State<COACHY> {
   void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified )? HomePage() : HomePage(),
      routes: {
      "sign_up": (context) => sign_up(),
      "HomePage" : (context) =>HomePage() ,
      "Login" : (context) =>Login()},
    );
  }
}