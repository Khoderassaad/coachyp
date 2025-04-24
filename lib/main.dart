import 'package:coachyp/Pages/HomePage.dart';
import 'package:coachyp/Pages/firebase_notifications.dart';
import 'package:coachyp/Stripe_Payment/Stripe_keys.dart';
import 'package:coachyp/features/auth/presentation/pages/login.dart';
import 'package:coachyp/features/auth/presentation/pages/sign_up.dart';
import 'package:coachyp/features/auth/presentation/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase/firebase_options.dart';

void main() async {
  Stripe.publishableKey=ApiKeys.publishableKey;
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await FirebaseNotifications().initNotifications();
  runApp(COACHY());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class COACHY extends StatefulWidget {
  const COACHY({super.key});

  @override
  State<COACHY> createState() => _COACHYState();
}

class _COACHYState extends State<COACHY> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)), // Splash duration
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const HomePage(); // Show splash screen
          }
          
          // Check auth state after splash
          final user = FirebaseAuth.instance.currentUser;
          if (user != null && user.emailVerified) {
            return HomePage();
          } else {
            return Login(); // Or Welcome() if you want different behavior
          }
        },
      ),
      routes: {
        "sign_up": (context) => const sign_up(),
        "HomePage": (context) => const HomePage(),
        "Login": (context) => const Login(),
      },
    );
  }
}