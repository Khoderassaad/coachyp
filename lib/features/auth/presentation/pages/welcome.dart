import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../colors.dart';
import 'package:coachyp/features/auth/presentation/pages/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Login(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start from right
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: null,
      body: Column(
        children: [
          Container(
            height: 300,
            child: Image.asset(
              "assets/image/spart-club.jpg",
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 160), // Added const
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return myLinearGradient().createShader(bounds);
                },
                child: const Text(
                  // Added const
                  " COACHY ",
                  style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 60,
                      fontFamily: 'Jersey15'),
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) {
                  return myLinearGradient().createShader(bounds);
                },
                child: const Text(
                  // Added const
                  " YOUR PATH TO HEALTHIER LIFE ",
                  style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 20,
                      fontFamily: 'Jersey15'),
                ),
              ),
              const SizedBox(height: 240), // Added const
              const Text(
                // Added const
                "POWERED BY INFINTE.ZONE",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
