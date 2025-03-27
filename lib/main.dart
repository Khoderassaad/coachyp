import 'package:coachyp/features/Posts/presentation/pages/HomePage.dart';
import 'package:coachyp/features/auth/presentation/pages/login.dart';
import 'package:coachyp/features/auth/presentation/pages/sign_up.dart';
import 'package:coachyp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coachyp/features/messaging/presentation/providers/message_provider.dart';
import 'package:coachyp/features/messaging/data/Repository/messageRepositoryImpl.dart';
import 'package:coachyp/features/messaging/domain/Repositories/MessageRepository.dart'; // Correct import

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
    return MultiProvider(
      providers: [
        // Provide the MessageRepository for MessageProvider
        Provider<MessageRepository>(
          create: (_) => MessageRepositoryImpl(), // Use MessageRepositoryImpl as a provider
        ),
        // Provide MessageProvider with MessageRepository
        ChangeNotifierProvider(
          create: (context) => MessageProvider(
            Provider.of<MessageRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? HomePage()
            : HomePage(), // You can adjust this condition later based on user authentication state
        routes: {
          "sign_up": (context) => sign_up(),
          "HomePage": (context) => HomePage(),
          "Login": (context) => Login(),
        },
      ),
    );
  }
}
