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
          pageBuilder: (_, __, ___) => const Login(),
          transitionsBuilder: (_, animation, __, child) {
            final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/image/spart-club.jpg",
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 100),
            ShaderMask(
              shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
              child: const Text(
                "COACHY",
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 60,
                  fontFamily: 'Jersey15',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ShaderMask(
              shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
              child: const Text(
                "YOUR PATH TO HEALTHIER LIFE",
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 20,
                  fontFamily: 'Jersey15',
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "POWERED BY INFINTE.ZONE",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
