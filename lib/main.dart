import 'package:coachyp/features/auth/presentation/pages/login.dart';
import 'package:coachyp/features/auth/presentation/pages/sign_in.dart';
import 'package:coachyp/features/auth/presentation/pages/welcome.dart';
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

class COACHY extends StatelessWidget {
  const COACHY({super.key});


  @override
  Widget build(BuildContext context) {
    

    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
    
      
  }
}